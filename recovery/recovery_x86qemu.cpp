/******************************************************************************
 *
 * recovery_x86vbox.cpp - Extend recovery for x86vbox
 *
 * Copyright (c) 2017 Roger Ye.  All rights reserved.
 * Software License Agreement
 *
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
 * NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
 * NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. The AUTHOR SHALL NOT, UNDER
 * ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES, FOR ANY REASON WHATSOEVER.
 *
 *****************************************************************************/

#include <linux/input.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "common.h"
#include "screen_ui.h"
#include "device.h"

// defined in "roots.h"
int unmount_format_volumes(int format);

class X86vboxUI : public ScreenRecoveryUI {
public:
    virtual KeyAction CheckKey(int key) {
      if (key == KEY_HOME) {
        return TOGGLE;
      }
      return ENQUEUE;
    }
};

class X86vboxDevice : public Device {
private:
	X86vboxUI* ui_;

public:
    X86vboxDevice(X86vboxUI* ui) : Device(ui), ui_(ui)  { }

    virtual const char* const* GetMenuItems();
    virtual BuiltinAction InvokeMenuItem(int menu_position);
    X86vboxUI* GetUI() { return ui_; }
    int CreatePartitions();
};

static const char* MENU_ITEMS[] = {
    "Reboot system now",
    "Reboot to bootloader",
    "Apply update from VBox shared storage",
    "Apply update from SD card",
    "Wipe data/factory reset",
    "Wipe cache partition",
    "Mount /system",
    "View recovery logs",
    "Create partitions",
    "Power off",
    NULL
};

const char* const* X86vboxDevice::GetMenuItems() {
  return MENU_ITEMS;
}

static const char *X86VBOX_PARTITION_SCRIPT = "/sbin/create_partitions.sh";
static char* const x86vbox_argv[] = {"create_partitions.sh", NULL};
int X86vboxDevice::CreatePartitions() {
    int status;
    pid_t child;

    status = unmount_format_volumes(0);
    if (status != 0) {
        LOGE("failed to un-mount the partitions; aborting\n");
        return status;
    }

    if ((child = vfork()) == 0) {
        execv(X86VBOX_PARTITION_SCRIPT, x86vbox_argv);

        status = unmount_format_volumes(1);
        if (status != 0) {
            LOGE("failed to format the volumes; aborting\n");
            return status;
        }
        _exit(-1);
    }
    waitpid(child, &status, 0);
    if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
        LOGE("%s failed with status %d\n", X86VBOX_PARTITION_SCRIPT, WEXITSTATUS(status));
    }
    return WEXITSTATUS(status);
}

Device::BuiltinAction X86vboxDevice::InvokeMenuItem(int menu_position) {
  switch (menu_position) {
    case 0: return REBOOT;
    case 1: return REBOOT_BOOTLOADER;
    case 2: return APPLY_ADB_SIDELOAD;	// Apply update from VBox shared storage
    case 3: return APPLY_SDCARD;
    case 4: return WIPE_DATA;
    case 5: return WIPE_CACHE;
    case 6: return MOUNT_SYSTEM;
    case 7: return VIEW_RECOVERY_LOGS;
    case 8:
    	// Create partition
    	CreatePartitions();
    	return NO_ACTION;
    case 9: return SHUTDOWN;
    default: return NO_ACTION;
  }
}

Device* make_device() {
  return new X86vboxDevice(new X86vboxUI);
}
