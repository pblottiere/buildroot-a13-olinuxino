#!/bin/sh
#--------

BOARD_DIR="$(dirname $0)"

#
# BASIC CONF
#

# bootloader
cp $BASE_DIR/build/uboot-sunxi-3f5ff92/u-boot-sunxi-with-spl.bin $BINARIES_DIR

# rfs
if [ -e $BOARD_DIR/rfs/etc/wpa_supplicant.conf ];
then
	cp $BOARD_DIR/rfs/etc/wpa_supplicant.conf $TARGET_DIR/etc/wpa_supplicant.conf
fi

if [ -e $BOARD_DIR/rfs/etc/modprobe.conf ];
then
	cp $BOARD_DIR/rfs/etc/modprobe.conf $TARGET_DIR/etc/modprobe.conf
fi

if [ -e $BOARD_DIR/rfs/etc/modprobe.d/8192cu.conf ];
then
	mkdir -p $TARGET_DIR/etc/modprobe.d
	cp $BOARD_DIR/rfs/etc/modprobe.d/8192cu.conf $TARGET_DIR/etc/modprobe.d
fi

if [ -e $BOARD_DIR/rfs/etc/network/interfaces ];
then
	cp $BOARD_DIR/rfs/etc/network/interfaces $TARGET_DIR/etc/network/interfaces
fi

#
# SERVER CONF
#

# auto mount disk
#mkdir $TARGET_DIR/mnt/disk
#echo "/dev/uba1    /mnt/disk    ntfs-3g    1    1" >> $TARGET_DIR/etc/fstab
