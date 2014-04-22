---
layout: post
title: "在Ubuntu上如何禁止IPv6"
tagline: "Howto disable IPv6 on Ubuntu 13.x"
description: ""
category: Ubuntu 
tags: [ Ubuntu ]
---
{% include JB/setup %}

The document is guide you to disable ipv6 on Ubuntu 13.x

## Steps

### Check if ipv6

To check if IPv6 is enabled or disabled(0 means it’s enabled and 1 is disabled.):

	$ cat /proc/sys/net/ipv6/conf/all/disable_ipv6

### Disable IPv6 
	
For disable IPv6 on Ubuntu Server, we need add these configuration lines in sysctl.conf

	$sudo vim /etc/sysctl.conf

Add the following to the end of file

	# IPv6 configuration
	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1


###  Reload configurationf or sysctl.conf

	sudo sysctl -p

### Check it

	ip addr

