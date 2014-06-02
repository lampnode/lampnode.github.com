---
layout: post
title: "Howto harden ubuntu 14.04 after installation"
tagline: "Howto harden ubuntu 14.04 after installation"
description: ""
category: Linux 
tags: [Linux, Ubuntu ]
---
{% include JB/setup %}

The purpose of this document is decribe howto secure your ubuntu after installing it.

## Network

### To eanble ufw

	$sudo ufw allow ssh
	$sudo ufw enable

### To secure openssh server

#### Update config
	$sudo vim /etc/ssh/sshd_config

Update the following, then restart the ssh:

	Port 10000
	PermitRootLogin no
	DebianBanner no

#### Blocks SSH attacks

Install file2ban:

	$sudo apt-get install fail2ban

Edit the configuration file "/etc/fail2ban/jail.local"  and create the filter rules as required.

	$sudo vim /etc/fail2ban/jail.conf

Enable the SSH monitoring and banning jail:

	[ssh]
	enabled  = true
	port     = <ENTER YOUR SSH PORT NUMBER HERE>
	filter   = sshd
	logpath  = /var/log/auth.log
	maxretry = 3

### Harden sysctl settings

	$sudo vim /etc/sysctl.conf

Add the following lines at the end of this file:

	# IP Spoofing protection
	net.ipv4.conf.all.rp_filter = 1
	net.ipv4.conf.default.rp_filter = 1

	# Ignore ICMP broadcast requests
	net.ipv4.icmp_echo_ignore_broadcasts = 1

	# Disable source packet routing
	net.ipv4.conf.all.accept_source_route = 0
	net.ipv4.conf.default.accept_source_route = 0

	# Ignore send redirects
	net.ipv4.conf.all.send_redirects = 0
	net.ipv4.conf.default.send_redirects = 0

	# Block SYN attacks
	net.ipv4.tcp_syncookies = 1
	net.ipv4.tcp_max_syn_backlog = 2048
	net.ipv4.tcp_synack_retries = 2
	net.ipv4.tcp_syn_retries = 5

	# Log Martians
	net.ipv4.conf.all.log_martians = 1
	net.ipv4.icmp_ignore_bogus_error_responses = 1

	# Ignore ICMP redirects
	net.ipv4.conf.all.accept_redirects = 0
	net.ipv4.conf.default.accept_redirects = 0 

	# Ignore Directed pings
	net.ipv4.icmp_echo_ignore_all = 1

Disable IPv6 if you do not need it.

	#Disable IPv6 configuration
	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1

To reload sysctl with the latest changes, enter:

	$sudo sysctl -p

## System

### To Check for rootkits

	$sudo apt-get install rkhunter chkrootkit

To run chkrootkit open a terminal window and enter :

	$sudo chkrootkit

To update and run RKHunter. Open a Terminal and enter the following :

	$sudo rkhunter --update
	$sudo rkhunter --propupd
	$sudo rkhunter --check

### To watch logs

	$sudo apt-get install logwatch libdate-manip-perl


### To Audit your system security

	$sudo apt-get install tiger






