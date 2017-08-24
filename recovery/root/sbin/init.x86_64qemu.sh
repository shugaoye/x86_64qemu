#!/bin/busybox sh 

echo -n "Initializing x86vbox hardware ..."
PATH=/bin:/sbin:/bin; export PATH

cd /bin;busybox --install -s

cd /x86_64qemu
insmod atkbd.ko
insmod cn.ko
# insmod drm.ko
# insmod ttm.ko
# insmod fb_sys_fops.ko
# insmod sysimgblt.ko
# insmod sysfillrect.ko
# insmod syscopyarea.ko
# insmod drm_kms_helper.ko
insmod uvesafb.ko mode_option=${UVESA_MODE:-1024x768}-32

