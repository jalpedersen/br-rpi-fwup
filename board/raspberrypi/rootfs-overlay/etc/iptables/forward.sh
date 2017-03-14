#!/bin/sh

#We include both usb0 and eth1 as inside interfaces as the usb gadget pop up as eth1 if inserted after boot - but as usb0 
#if the gadget is present at boot.

outside=eth0
inside1=wlan0
inside2=usb0

sysctl -w net.ipv4.ip_forward=1

iptables -t nat -A POSTROUTING -o $outside -j MASQUERADE
iptables -A FORWARD -i $outside -o $inside1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $inside1 -o $outside -j ACCEPT
iptables -A FORWARD -i $outside -o $inside2 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $inside2 -o $outside -j ACCEPT
