#!/bin/bash

WANINT=$(ip route list 0/0 | awk '{print $5}')
IPADDR=$(ifconfig ${WANINT} | grep inet | awk '{print $2}')
echo "WANINT: ${WANINT} | IPADDR: ${IPADDR}"

## disable squid redirect
iptables -t nat -D SQUID -p tcp -j DNAT --to ${IPADDR}:3128
iptables -t nat -D PREROUTING ! -i ${WANINT} -p tcp --dport 80 -j SQUID
iptables -t nat -X SQUID

./iptables.nat.list.sh
