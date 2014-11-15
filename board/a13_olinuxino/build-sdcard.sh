#! /bin/sh

#
# get/test parameters
#
PARTITION_BOOT_OFFSET=2048
PARTITION_ROOT_OFFSET=34815
BINARIES_DIR="$1"
SDCARD_DEV="$2"

if [ ! -e "$BINARIES_DIR" ] || [ ! -e "$SDCARD_DEV" ]
then
    echo "Usage: $0 <binaries_dir> <sdcard device>"
    exit 1
fi

#
# ask confirmation
#
while true; do
    echo "Do you wish to install images on device $SDCARD_DEV? Content will be removed... (y/n)"
    read -p "" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#
# remove all contents in sdcard directory
#
echo -n "remove all contents on sdcard..."
dd if=/dev/zero of=$SDCARD_DEV bs=512 > /dev/null 2>&1
echo ": done"

#
# format sdcard
#
echo -n "partitioning sdcard..."
fdisk $SDCARD_DEV >/dev/null 2>&1 <<EOF
n
p
1
$PARTITION_BOOT_OFFSET
$PARTITION_ROOT_OFFSET
n
p
2


w
EOF
echo ": done"

echo -n "format partition..."
mkfs.vfat "$SDCARD_DEV"1 > /dev/null 2>&1
mkfs.ext3 "$SDCARD_DEV"2 > /dev/null 2>&1
echo ": done"

#
# copy bootloader
#
echo -n "copy bootloader..."
dd if=$BINARIES_DIR/u-boot-sunxi-with-spl.bin of=$SDCARD_DEV bs=1024 seek=8 > /dev/null 2>&1
echo ": done"

#
# paste kernel image 
#
echo -n "copy kernel image..."
mkdir -p /mnt/sd
mount "$SDCARD_DEV"1 /mnt/sd
cp $BINARIES_DIR/uImage /mnt/sd
cp $BINARIES_DIR/script.bin /mnt/sd
umount /mnt/sd
rmdir /mnt/sd
echo ": done"

#
# paste RFS
#
echo -n "copy RFS..."
mkdir -p /mnt/sd
mount "$SDCARD_DEV"2 /mnt/sd
tar xf $BINARIES_DIR/rootfs.tar -C /mnt/sd
umount /mnt/sd
rmdir /mnt/sd
echo ": done"
