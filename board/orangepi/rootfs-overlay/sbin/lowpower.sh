#!/bin/sh
lowspeed=408000
highspeed=672000
cpu_state=0
dram_speed=$lowspeed

if [ x"$1" == x"off"]; then
	cpu_state=1
	dram_speed=$highspeed
fi

echo $cpu_state >/sys/devices/system/cpu/cpu3/online
echo $cpu_state >/sys/devices/system/cpu/cpu2/online
echo $cpu_state >/sys/devices/system/cpu/cpu1/online
echo $dram_speed >/sys/devices/platform/sunxi-ddrfreq/devfreq/sunxi-ddrfreq/userspace/set_freq
