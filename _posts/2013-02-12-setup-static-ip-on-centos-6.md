---
layout: post
title: "Setup static ip on CentOS 6"
description: ""
category: Linux
tags: [ CentOs ]
---
{% include JB/setup %}

## Test Context

- CentOs 6.3
- Localhost IP:192.168.0.7
- Gateway: 192.168.0.1

## Setup

### ifcfg-eth0
	[root@edwin] vim /etc/sysconfig/network-scripts/ifcfg-eth0

The config example is the following:

	DEVICE=eth0
	NM_CONTROLLED=yes
	ONBOOT=yes
	BOOTPROTO=static
	HWADDR=00:21:85:12:57:06
	TYPE=Ethernet
	UUID=6a129ba5-6430-40cc-b863-882ec2f3d34d
	IPADDR=192.168.0.7
	NETMASK=255.255.255.0
	GATEWAY=192.168.0.1
	USERCTL=no
	DNS1=8.8.8.8
	DNS2=8.8.4.4
 
### resolv.conf

Note:If your have add DNS1 (and DNS2) in the ifcif-eth0; this step could skip.
	
	[root@edwin]vim /etc/resolv.conf

The config example is the following:

	nameserver 8.8.8.8
	nameserver 8.8.4.4
 
### network(Option)
	
	[root@edwin]vim /etc/sysconfig/network
 
The config example is the following:

	NETWORKING=yes
	NETWORKING_IPV6=no
	HOSTNAME=CentOS
 
