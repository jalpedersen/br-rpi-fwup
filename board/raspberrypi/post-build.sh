#!/bin/sh
# args from BR2_ROOTFS_POST_SCRIPT_ARGS
# $2    path of boot.cmd
# $3    output directory for boot.scr


#Fix permissions
chmod 0700 $1/etc/monitrc

env
echo "Compiling overlays"
overlaydir=$BINARIES_DIR/overlays
mkdir -p $overlaydir
dtc=$BUILD_DIR/linux-31a8651c138253007c66e1be176cdc839b416842/scripts/dtc/dtc

for o in $BR2_EXTERNAL_FWUP_PATH/board/raspberrypi/overlays/*-overlay.dts; do
  if [ -f $o ]; then
    file=`basename $o`
    output=${file%"-overlay.dts"}.dtbo
    $dtc $o -I dts -@ -O dtb -o $overlaydir/$output
  fi
done
