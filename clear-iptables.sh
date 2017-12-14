#!/bin/bash
#Program:
#      my iptables clear
#History:
#       2017-12-14 king first release
#Email:
#       zuiwuchang@gmail.com

# clear all rules
iptables -t nat -F
iptables -t filter -F
iptables -t mangle -F

