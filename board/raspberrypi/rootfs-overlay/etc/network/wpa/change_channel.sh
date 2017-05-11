#!/bin/sh

iface=$1
action=$2
hostapd_init=/etc/init.d/S95hostapd
conf=/data/hostapd.conf

freq_to_channel() {
    #https://en.wikipedia.org/wiki/List_of_WLAN_channels#2.4.C2.A0GHz_.28802.11b.2Fg.2Fn.29
    if [ $1 -ge 2412 ] && [ $1 -le 2472 ]; then
        chan=`expr \(  $1 - 2412 \) / 5 + 1`
        echo $chan
    fi 
}

if [ "x$action" == "xCONNECTED" ]; then
    sta_freq=`wpa_cli -i wlan0 status | grep freq | cut -c6-`
    ap_freq=`hostapd_cli status | grep freq | cut -c6-`
    if [ -z $sta_freq ]; then
        exit 1
    fi
    if [ "x$sta_freq" != "x$ap_freq" ]; then
        chan=`freq_to_channel $sta_freq`
        sed -i s/channel=.*/channel=$chan/g $conf
        $hostapd_init restart
    fi
fi

