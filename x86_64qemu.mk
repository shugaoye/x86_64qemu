#
# Copyright (C) 2017 The x86_64qemu Open Source Project
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

# includes the base of Android-x86 platform
$(call inherit-product,device/generic/common/x86_64.mk)

# Overrides
PRODUCT_NAME := x86_64qemu
PRODUCT_BRAND := Android-x86
PRODUCT_DEVICE := x86_64qemu
PRODUCT_MODEL := x86_64qemu_ch14

PRODUCT_COPY_FILES += \
    device/generic/x86_64qemu/recovery.fstab:recovery/root/etc/recovery.fstab \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/atkbd.ko:recovery/root/x86_64qemu/atkbd.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/cn.ko:recovery/root/x86_64qemu/cn.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/drm.ko:recovery/root/x86_64qemu/drm.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/ttm.ko:recovery/root/x86_64qemu/ttm.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/drm_kms_helper.ko:recovery/root/x86_64qemu/drm_kms_helper.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/fb_sys_fops.ko:recovery/root/x86_64qemu/fb_sys_fops.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/sysimgblt.ko:recovery/root/x86_64qemu/sysimgblt.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/sysfillrect.ko:recovery/root/x86_64qemu/sysfillrect.ko \
    device/generic/x86_64qemu/recovery/root/x86_64qemu/syscopyarea.ko:recovery/root/x86_64qemu/syscopyarea.ko \
    device/generic/x86_64qemu/recovery/root/init.recovery.x86_64qemu.rc:root/init.recovery.x86_64qemu.rc \
    device/generic/x86_64qemu/recovery/root/sbin/network_start.sh:recovery/root/sbin/network_start.sh \
    device/generic/x86_64qemu/recovery/root/sbin/init.x86_64qemu.sh:recovery/root/sbin/init.x86_64qemu.sh \
    device/generic/x86_64qemu/recovery/root/sbin/create_partitions.sh:recovery/root/sbin/create_partitions.sh \
    device/generic/x86_64qemu/recovery/root/sbin/gdbserver:recovery/root/sbin/gdbserver \
    device/generic/x86_64qemu/recovery/root/sbin/parted:recovery/root/sbin/parted \
    device/generic/x86_64qemu/recovery/root/lib/libc.so.6:recovery/root/lib/libc.so.6 \
    device/generic/x86_64qemu/recovery/root/lib/libcrypt.so.1:recovery/root/lib/libcrypt.so.1 \
    device/generic/x86_64qemu/recovery/root/lib/libdl.so.2:recovery/root/lib/libdl.so.2 \
    device/generic/x86_64qemu/recovery/root/lib/libm.so.6:recovery/root/lib/libm.so.6 \
    device/generic/x86_64qemu/recovery/root/lib/libntfs-3g.so.31:recovery/root/lib/libntfs-3g.so.31 \
    device/generic/x86_64qemu/recovery/root/lib/libpthread.so.0:recovery/root/lib/libpthread.so.0 \
    device/generic/x86_64qemu/recovery/root/lib/librt.so.1:recovery/root/lib/librt.so.1 \
    device/generic/x86_64qemu/recovery/root/bin/busybox:recovery/root/bin/busybox \
    device/generic/x86_64qemu/recovery/root/bin/ld-linux.so.2:recovery/root/bin/ld-linux.so.2 \
    device/generic/x86_64qemu/recovery/root/bin/lndir:recovery/root/bin/lndir \
    device/generic/x86_64qemu/recovery/root/system/bin/linker:recovery/root/system/bin/linker \
    device/generic/x86_64qemu/recovery/root/system/bin/linker64:recovery/root/system/bin/linker64 \
    device/generic/x86_64qemu/recovery/root/system/lib/libc.so:recovery/root/system/lib/libc.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libc++.so:recovery/root/system/lib/libc++.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libcutils.so:recovery/root/system/lib/libcutils.so \
    device/generic/x86_64qemu/recovery/root/system/lib/liblog.so:recovery/root/system/lib/liblog.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libm.so:recovery/root/system/lib/libm.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libpcre.so:recovery/root/system/lib/libpcre.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libselinux.so:recovery/root/system/lib/libselinux.so \
    device/generic/x86_64qemu/recovery/root/system/lib/libext2_uuid.so:recovery/root/system/lib/libext2_uuid.so


#    device/generic/x86_64qemu/recovery/root/x86_64qemu/uvesafb.ko:recovery/root/x86_64qemu/uvesafb.ko \
