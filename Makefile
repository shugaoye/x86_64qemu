# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#******************************************************************************
#
# Makefile - Make file for eclipse integration
#
# Copyright (c) 2016 Roger Ye.  All rights reserved.
#
# This is part of the build for virtual device x86qemu.
#
#******************************************************************************

initrd_dir :=  ${OUT}/../../../../bootable/newinstaller/initrd
TARGET_INSTALLER_OUT :=${OUT}/installer
ACP := acp
MKBOOTFS := mkbootfs
X86QEMU_BOOT_IMAGES_DIR := images/android-x86qemu

all:
	cd ../../..;make -j4 2>&1 | tee x86qemu-`date +%Y%m%d`.txt

x86qemu:
	cd ../../..;make -j4

updater:
	cd ../../..;make updater
	cp $OUT/system/bin/updater ~/temp/sbin

librecovery_ui_x86qemu:
	cd ../../..;make librecovery_ui_x86qemu

librecovery_updater_x86qemu:
	cd ../../..;make librecovery_updater_x86qemu

snod:
	cd ../../..;make snod

initrd_img:
	cd ../../..;make initrd USE_SQUASHFS=0

ramdisk:
	cd ../../..;$(MKBOOTFS) -d ${OUT}/system ${OUT}/root | minigzip > ${OUT}/ramdisk.img

clean-ramdisk:
	rm ${OUT}/ramdisk.img
	rm -rf ${OUT}/root

installer:
	rm -rf $(TARGET_INSTALLER_OUT)/scripts
	$(ACP) -pr $(initrd_dir)/scripts $(TARGET_INSTALLER_OUT)/scripts
	$(ACP) -pr $(initrd_dir) $(TARGET_INSTALLER_OUT)
	cd ../../..;$(MKBOOTFS) $(TARGET_INSTALLER_OUT) | gzip -9 > ${OUT}/initrd.img

ramdisk-recovery:
	cd ../../..;$(MKBOOTFS) -d ${OUT}/system ${OUT}/recovery/root | minigzip > ${OUT}/ramdisk-recovery.img

recoveryimage:
	cd ../../..;make -j4 recoveryimage 2>&1 | tee x86qemu-`date +%Y%m%d`.txt

clean-recoveryimage:
	rm ${OUT}/recovery.img
	rm -rf ${OUT}/recovery/root
	rm ${OUT}/ramdisk-recovery.img
	
dist:
	if [ -d "images" ]; then \
	echo "Find images folder."; \
	rm -rf images; \
	fi
	mkdir -p ${X86QEMU_BOOT_IMAGES_DIR}
	cp ${OUT}/ramdisk.img ${X86QEMU_BOOT_IMAGES_DIR}
	cp ${OUT}/ramdisk-recovery.img ${X86QEMU_BOOT_IMAGES_DIR}
	cp ${OUT}/kernel ${X86QEMU_BOOT_IMAGES_DIR}
	cd images; zip x86qemu.dat android-x86qemu/*
	cd ../../..;mkdir -p dist_output
	cd ../../..;make dist DIST_DIR=dist_output 2>&1 | tee x86qemu-`date +%Y%m%d`.txt
