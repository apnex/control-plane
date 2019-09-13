#!/bin/bash

# ip_forwarding
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null
sysctl net.ipv4.ip_forward

# Flush all iptables rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Enable permit INPUT, OUTPUT, FORWARD
iptables -A OUTPUT -j ACCEPT -m comment --comment "Accept all output"
iptables -A INPUT -j ACCEPT -m comment --comment "Accept all input"
iptables -A FORWARD -j ACCEPT -m comment --comment "Accept all forward"

# Show
iptables --list
