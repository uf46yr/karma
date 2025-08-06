#/bin/bash

EAP='wlan1'

sudo ifconfig $EAP up

cp hostapd-eaphammer-karma.conf /tmp/hostapd-eaphammer.conf

sed -i "s/interface=.*/interface=$EAP/g" /tmp/hostapd-eaphammer.conf

sudo /opt/eaphammer/local/hostapd-eaphammer/hostapd/hostapd-

eaphammer -x /tmp/hostapd-eaphammer.conf
