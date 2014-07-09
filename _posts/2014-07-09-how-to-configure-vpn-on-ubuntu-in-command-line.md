---
layout: post
title: "How to configure vpn on Ubuntu in command line"
tagline: "How to configure vpn on Ubuntu in command line"
description: ""
category: Linux 
tags: [Ubuntu, VPN ]
---
{% include JB/setup %}

Although NetworkManager on Ubuntu supports VPN, it can not work on commmand line. This article describes how to setup 
PPTP VPN on Ubuntu in command line.

### Installation

	# sudo apt-get install pptp-linux ppp pptpd

### Configuration

	# sudo pptpsetup --create VPN_NAME --server EXAMPLE.COM  --username USERNAME --password PASSWD --encrypt --start

List all of vpns

	#ls -al /etc/ppp/peers/
	
	drwxr-s--- 2 root dip  4096 Jul  9 16:39 .
	drwxr-xr-x 8 root root 4096 Jul  9 16:41 ..
	-rw-r--r-- 1 root dip   175 Jul  9 16:11 VPN_NAME1
	-rw-r--r-- 1 root dip   175 Jul  9 16:39 VPN_NAME2
	-rw-r----- 1 root dip  1093 Jun 24 18:57 provider

### Running the VPN Connection

	#sudo pon VPN_NAME

To stop it:

	#sudo poff VPN_NAME
