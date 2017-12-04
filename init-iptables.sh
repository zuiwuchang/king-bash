#!/bin/bash
#Program:
#      my iptables setting
#History:
#       2017-12-4 king first release
#Email:
#       zuiwuchang@gmail.com

# clear all rules
iptables -t nat -F
iptables -t filter -F
iptables -t mangle -F

#forword 80 to 8080
#iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
 
# allow ping lo(0.0.0.0)
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

#allow 80 ...
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
#sudo iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
#sudo iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT

#allow ssh
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

#reject all other
iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited
