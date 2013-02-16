#!/bin/bash

#
# Iptable init config script
# Author:Robert Chain
# Mail:robert.c@lampnode.com
#


IPTABLES=/sbin/iptables;
PORT_HTTP=80;
PORT_HTTPS=443;
PORT_SSH=22;
#PORT_IPP=631;
#PORT_MYSQL=3306;


#
# Init 
#

echo "Init the iptable setup..."
# If connecting remotely we must first temporarily set the default policy on the INPUT 
# chain to ACCEPT otherwise once we flush the current rules we will be locked out of 
# our server
$IPTABLES -P INPUT ACCEPT
# Empty all the rules
$IPTABLES -F
$IPTABLES -X
$IPTABLES -Z
# Accept the Packet from the lo interface, if you do not set this rule, you will not 
# access local services came from 127.0.0.1
$IPTABLES -A INPUT -i lo -j ACCEPT

#
# Port setup
#

# The rule for SSH
if [ "$PORT_SSH" != "" ]; then
	echo "# Add rules for SSH:$PORT_SSH"
	$IPTABLES -A INPUT -p tcp --dport $PORT_SSH -j ACCEPT
fi 

# The rule for http and https
if [ "$PORT_HTTP" != "" ]; then
	echo "# Add rules for HTTP:$PORT_HTTP"
	$IPTABLES -A INPUT -p tcp --dport $PORT_HTTP -j ACCEPT
fi
if [ "$PORT_HTTPS" != "" ]; then
	echo "# Add rules for HTTPS:$PORT_HTTPS"
	$IPTABLES -A INPUT -p tcp --dport $PORT_HTTPS -j ACCEPT
fi

if [ "$PORT_MYSQL" != "" ]; then
        echo "# Add rules for MYSQL:$PORT_MYSQL"
        $IPTABLES -A INPUT -p tcp --dport $PORT_MYSQL -j ACCEPT
fi

# The rule for http and IPP
if [ "$PORT_IPP" != "" ]; then
	echo "# Add rules for IPP:$PORT_IPP"
	$IPTABLES -A INPUT -p tcp --dport 631 -j ACCEPT
	$IPTABLES -A INPUT -p udp --dport 631 -j ACCEPT
fi

# Accept all TCP requests from 10.241.121.15(an intranet ip)
#$IPTABLES -A INPUT -p tcp -s 10.241.121.15 -j ACCEPT

#
# Post setup
#
echo "Post setup...";
# The rule for PING
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# To ensure the normal communication with the external network
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Ignore all requests other than the above rules, Otherwise no filtering function
$IPTABLES -P INPUT DROP
# Similarly, here we've set the default policy on the FORWARD chain to DROP as 
# we're not using our computer as a router so there should not be any packets 
# passing through our computer
$IPTABLES -P FORWARD DROP
# finally, we've set the default policy on the OUTPUT chain to ACCEPT as we want 
# to allow all outgoing traffic as we trust our users.
$IPTABLES -P OUTPUT ACCEPT

echo "Setup is done, check the rules, if it's OK, save the rules with [/etc/init.d/iptables save]"
$IPTABLES -L -v
