#!/bin/sh

KERNEL_VERSION=4.4.62-android-x86_64
PRODUCT_NAME=x86_64qemu
MODULE_PATH=${OUT}/system/lib/modules/${KERNEL_VERSION}/kernel/drivers

create_links () {
    ln -s ${MODULE_PATH}/input/keyboard/atkbd.ko .
    ln -s ${MODULE_PATH}/connector/cn.ko .
    ln -s ${MODULE_PATH}/gpu/drm/drm_kms_helper.ko .
    ln -s ${MODULE_PATH}/gpu/drm/drm.ko .
    ln -s ${MODULE_PATH}/video/fbdev/core/fb_sys_fops.ko .
    ln -s ${MODULE_PATH}/video/fbdev/core/syscopyarea.ko .
    ln -s ${MODULE_PATH}/video/fbdev/core/sysfillrect.ko .
    ln -s ${MODULE_PATH}/video/fbdev/core/sysimgblt.ko .
    ln -s ${MODULE_PATH}/gpu/drm/ttm/ttm.ko .
    ln -s ${MODULE_PATH}/video/fbdev/uvesafb.ko .
}

copy_files() {
    cp ${MODULE_PATH}/input/keyboard/atkbd.ko .
    cp ${MODULE_PATH}/connector/cn.ko .
    cp ${MODULE_PATH}/gpu/drm/drm_kms_helper.ko .
    cp ${MODULE_PATH}/gpu/drm/drm.ko .
    cp ${MODULE_PATH}/video/fbdev/core/fb_sys_fops.ko .
    cp ${MODULE_PATH}/video/fbdev/core/syscopyarea.ko .
    cp ${MODULE_PATH}/video/fbdev/core/sysfillrect.ko .
    cp ${MODULE_PATH}/video/fbdev/core/sysimgblt.ko .
    cp ${MODULE_PATH}/gpu/drm/ttm/ttm.ko .
    cp ${MODULE_PATH}/video/fbdev/uvesafb.ko .
}

[ -d ${MODULE_PATH} ] && echo "Find path p0=$0 p1=$1 p2=$2 p3=$3" || exit 1

case $0 in
        *copy)
		echo "Copy files ..."
		copy_files
	;;
        *link)
		echo "Create links ..."
		create_links
	;;
	*)
		case $1 in
			*copy)
				copy_files
			;;
			*link)
				create_links
			;;
			*)
				echo ${MODULE_PATH}
			;;
		esac
	;;
esac

