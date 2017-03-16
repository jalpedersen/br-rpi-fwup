#!/bin/sh
target=$1

if [ -z $target ]; then
    echo "Usage: $0 target_ip"
    exit 1
fi

cat raspberrypi.fw | ssh root@$target \
        'fwup -a -U -d /dev/mmcblk0 -t upgrade && reboot'
