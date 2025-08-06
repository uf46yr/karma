#!/bin/bash

tmux new-session -d -s karma -n WPA 'sudo hcxdumptool -i mon0

--enable_status=15 -o $dumpfile.pcapng --passive

--disable_ap_attacks'

tmux split-window -v -t WPA './brute_half.sh'

tmux a -t karma
