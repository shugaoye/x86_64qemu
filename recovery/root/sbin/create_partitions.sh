#!/sbin/sh
# This will repartition the virtual hard disk so that
# all recovery necessory partitions can be created.
# This partitioning scheme is based on a 8000MiB
# virtual hard disk.

echo "Creating partition table..."
dd if=/dev/zero of=/dev/block/sda bs=1024 count=1024
fdisk /dev/block/sda << EOF
n
p
1
1
243
n
p
2
244
365
n
p
3
366
487
n
e
488
1044
n
488
609
n
610
633
n
634
815
n
816
1044
t
3
c
a
1
p
w
EOF          

