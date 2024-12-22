#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
