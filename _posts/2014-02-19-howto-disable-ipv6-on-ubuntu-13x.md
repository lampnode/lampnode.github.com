---
layout: post
title: "Howto disable IPv6 on Ubuntu 13.x"
tagline: "Howto disable IPv6 on Ubuntu 13.x"
description: ""
category: Ubuntu 
tags: [ Ubuntu ]
---
{% include JB/setup %}

The document is guide you to disable ipv6 on Ubuntu 13.x

## Steps

### Edit the sysctl.conf

For disable IPv6 on Ubuntu Server, we need add these configuration lines in sysctl.conf

	sudo vim /etc/sysctl.conf

Add the following to the end of file

	# IPv6 configuration
	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1


###  Reload configurationf or sysctl.conf

	sudo sysctl -p

### Check it

	ip addr

