#!/bin/sh -x

set -e

TARGETDIR=$1
FWUPCONF_NAME=$2

FWUP_CONFIG=$BR2_EXTERNAL_FWUP_PATH/board/orangepi/$FWUPCONF_NAME
FWUP=$HOST_DIR/usr/bin/fwup
UBOOT_CONFIG=$BR2_EXTERNAL_FWUP_PATH/board/orangepi/orangepi-zero/boot.cmd

FW_PATH=$BINARIES_DIR/orangepi.fw
IMG_PATH=$BINARIES_DIR/orangepi.img

# Process the kernel if using device tree
if [ -e $HOST_DIR/usr/bin/mkknlimg ]; then
    $HOST_DIR/usr/bin/mkknlimg \
        $BINARIES_DIR/zImage $BINARIES_DIR/zImage.mkknlimg
fi

# Create/copy u-boot files to the images directory
$HOST_DIR/usr/bin/mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
    -n "u-boot script" -d $UBOOT_CONFIG $BINARIES_DIR/boot.scr

# Build the firmware image (.fw file)
echo "Creating firmware file..."
PROJECT_ROOT=$BR2_EXTERNAL_FWUP_PATH $FWUP -v -c -f $FWUP_CONFIG -o $FW_PATH

# Build a raw image that can be directly written to
# an SDCard (remove an exiting file so that the file that
# is written is of minimum size. Otherwise, fwup just modifies
# the file. It will work, but may be larger than necessary.)
echo "Creating raw SDCard image file..."
rm -f $IMG_PATH
$FWUP -a -d $IMG_PATH -i $FW_PATH -t complete


