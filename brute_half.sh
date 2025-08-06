#!/bin/bash                                                
tcpdump -r $dumpfile.pcapng -nn -w $dumpfile.pcap

aircrack-ng -w /opt/wordlists/top100k.txt "$dumpfile.pcap" && read ok

rm $dumpfile.pcap
