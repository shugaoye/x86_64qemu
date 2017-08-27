#
# Product-specific compile-time definitions.
#

# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_PRELINK_MODULE := false

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86

TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_64_BIT)
TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI) $(TARGET_2ND_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)
TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2) $(TARGET_2ND_CPU_ABI) $(TARGET_2ND_CPU_ABI2) $(NATIVE_BRIDGE_ABI_LIST_64_BIT) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736
BOARD_USERDATAIMAGE_PARTITION_SIZE := 419430400
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_SEPOLICY_DIRS += build/target/board/generic/sepolicy
BOARD_SEPOLICY_DIRS += build/target/board/generic_x86/sepolicy

include device/generic/common/BoardConfig.mk

#
# TWRP configuration START
#
# Platform, disable below options first
# TARGET_NO_RADIOIMAGE := true
# TARGET_BOARD_PLATFORM := sc1

BOARD_KERNEL_BASE := 0x80000000

# Redefine these two variables, since they are defined in device/generic/common/BoardConfig.mk
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false

# BOARD_KERNEL_CMDLINE :=

# Recovery:Start

# Use this flag if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_USERIMAGES_USE_EXT4 := true

# TWRP specific build flags
DEVICE_RESOLUTION := 1024x768
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_EXCLUDE_MTP := true
TWRP_EVENT_LOGGING := true
# This excludes parted from the build... parted is prebuilt and for arm CPU only
BOARD_HAS_NO_REAL_SDCARD := true
# Double buffer cannot work well on virtualbox
RECOVERY_GRAPHICS_FORCE_SINGLE_BUFFER := true
# Define x86qemu specific implementation in recovery
X86QEMU_RECOVERY := true

#
# TWRP configuration END
#

# device-specific extensions to the recovery UI
TARGET_RECOVERY_UI_LIB := librecovery_ui_x86_64qemu

# add device-specific extensions to the updater binary
TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_x86_64qemu
# TARGET_RECOVERY_UPDATER_EXTRA_LIBS +=

ADD_RADIO_FILES := true
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)
