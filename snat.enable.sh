#!/bin/bash

## still testing
#iptables -t nat -A POSTROUTING ! -s 172.16.10/24 -o eth0 -j SNAT --to 172.16.100.50
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to 172.16.100.50
#iptables -t nat -D POSTROUTING
