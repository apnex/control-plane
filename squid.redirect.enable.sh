#!/bin/bash

WANINT=$(ip route list 0/0 | awk '{print $5}')
IPADDR=$(ifconfig ${WANINT} | grep inet | awk '{print $2}')
echo "WANINT: ${WANINT} | IPADDR: ${IPADDR}"

## remove existing rules
./squid.redirect.disable.sh >/dev/null

## enable squid redirect
iptables -t nat -N SQUID
iptables -t nat -A SQUID -p tcp -j DNAT --to ${IPADDR}:3128
iptables -t nat -I PREROUTING ! -i ${WANINT} -p tcp --dport 80 -j SQUID

./iptables.nat.list.sh
