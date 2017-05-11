#!/bin/sh

iface=$1
action=$2

if [ "x$action" == "xCONNECTED" ]; then
    sta_freq=`wpa_cli -i wlan0 status | grep freq | cut -c6-`
    ap_freq=`hostapd_cli status | grep freq | cut -c6-`
    if [ -z $sta_freq ]; then
        exit 1
    fi
    if [ "x$sta_freq" != "x$ap_freq" ]; then
        change-hostapd-channel $sta_freq
    fi
fi

