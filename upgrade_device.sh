#!/bin/sh
target=$1
firmware=${2:-raspberrypi.fw}

if [ -z $target ]; then
    echo "Usage: $0 target_ip"
    exit 1
fi
echo "Flashing $target with $firmware"
cat $firmware | ssh root@$target \
        'fwup -a -U -d /dev/mmcblk0 -t upgrade && reboot'
