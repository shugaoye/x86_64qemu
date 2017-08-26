# x86_64qemu
AOSP build for QEMU

20170824 - Created the initial code base from x86qemu

--------------------------------------------------------------
/Android/Sdk/emulator/qemu/linux-x86_64/qemu-system-i386 
	-dns-server 127.0.1.1 
	-serial null 
	-cpu android32 
	-enable-kvm 
	-smp cores=4 
	-m 1536 
	-lcd-density 420 
	-kernel /vol1/aosp/Android/Sdk/system-images/android-26/google_apis/x86//kernel-ranchu 
	-initrd /vol1/aosp/Android/Sdk/system-images/android-26/google_apis/x86//ramdisk.img 
	-object iothread,id=disk-iothread 
	-nodefaults 
	-drive if=none,overlap-check=none,cache=unsafe,index=0,id=system,file=/vol1/aosp/.android/avd/a26x86.avd/system.img.qcow2,read-only 
	-device virtio-blk-pci,drive=system,iothread=disk-iothread,modern-pio-notify 
	-drive if=none,overlap-check=none,cache=unsafe,index=1,id=cache,file=/vol1/aosp/.android/avd/a26x86.avd/cache.img.qcow2,l2-cache-size=1048576 
	-device virtio-blk-pci,drive=cache,iothread=disk-iothread,modern-pio-notify 
	-drive if=none,overlap-check=none,cache=unsafe,index=2,id=userdata,file=/vol1/aosp/.android/avd/a26x86.avd/userdata-qemu.img.qcow2,l2-cache-size=1048576 
	-device virtio-blk-pci,drive=userdata,iothread=disk-iothread,modern-pio-notify 
	-drive if=none,overlap-check=none,cache=unsafe,index=3,id=encrypt,file=/vol1/aosp/.android/avd/a26x86.avd/encryptionkey.img.qcow2,l2-cache-size=1048576 
	-device virtio-blk-pci,drive=encrypt,iothread=disk-iothread,modern-pio-notify 
	-drive if=none,overlap-check=none,cache=unsafe,index=4,id=sdcard,file=/vol1/aosp/.android/avd/a26x86.avd/sdcard.img.qcow2,l2-cache-size=1048576 
	-device virtio-blk-pci,drive=sdcard,iothread=disk-iothread,modern-pio-notify 
	-netdev user,id=mynet 
	-device virtio-net-pci,netdev=mynet 
	-show-cursor 
	-L /vol1/aosp/Android/Sdk/emulator/lib/pc-bios 
	-soundhw hda 
	-vga none 
	-append 'qemu=1 androidboot.hardware=ranchu clocksource=pit android.qemud=1 console=0 android.checkjni=1 qemu.gles=1 qemu.encrypt=1 qemu.opengles.version=196609 cma=288M' 
	-android-hw /vol1/aosp/.android/avd/a26x86.avd/hardware-qemu.ini