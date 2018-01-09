#!/bin/sh

dtbs="bcm2708-rpi-b bcm2708-rpi-b-plus bcm2708-rpi-cm"

#File resources
for dtb in $dtbs; do
cat << EOF
file-resource $dtb.dtb {
    host-path = "\${PROJECT_ROOT}/buildroot/output/images/$dtb.dtb"
}
EOF
done
echo;echo


#complete
for dtb in $dtbs; do
cat << EOF
on-resource $dtb.dtb { fat_write(\${BOOT_PART_OFFSET}, "$dtb.dtb") }
EOF
done
echo;echo

#upgrade
##init
for dtb in $dtbs; do
cat << EOF
fat_rm(\${BOOT_PART_OFFSET}, "$dtb.dtb.pre")
EOF
done
echo;echo
##resource
for dtb in $dtbs; do
cat << EOF
on-resource $dtb.dtb { fat_write(${BOOT_PART_OFFSET}, "$dtb.dtb.new") }
EOF
done
echo;echo
##finish (pre)
for dtb in $dtbs; do
cat << EOF
fat_mv(\${BOOT_PART_OFFSET}, "$dtb.dtb", "$dtb.dtb.pre")
EOF
done
echo;echo
##finish 
for dtb in $dtbs; do
cat << EOF
fat_mv(\${BOOT_PART_OFFSET}, "$dtb.dtb.new", "$dtb.dtb")
EOF
done
echo;echo
## error
for dtb in $dtbs; do
cat << EOF
fat_rm(\${BOOT_PART_OFFSET}, "$dtb.dtb.new")
EOF
done
echo;echo




