---
layout: post
title: "Samba Server Installation and Configuration in CentOS 6.3"
tagline: "Samba Server Installation and Configuration in CentOS 6.3"
description: ""
category: linux 
tags: [Samba, CentOs]
---
{% include JB/setup %}

Samba is used to allow users to share files, folders and printers between linux and windows. This document describes how to install and configure asmba server on CentOS 6.3

## Scenario

### Samba server:
	
	OS: CentOS 6.3
	Hostname: smb.example.com
	IP: 192.168.0.10

### Samba Clients

	OS: window XP
	IP:192.168.0.26

## Install samba package

	# yum install samba* -y

## Configuration

### Configure for anonymous share

	# vim /etc/samba/smb.conf

Key params in global:

        workgroup = WORKGROUP
        server string = samba.example.com

        wins support = Yes
        netbios name = robert
        browseable = yes
        public = yes


        security = share

	
	dos charset = GB2312
	unix charset = GB2312
	display charset = GB2312
	directory mask = 0777
	force directory mode = 0777
	directory security mask = 0777
	force directory security mode = 0777
	create mask = 0777
	force create mask = 0777
	security mask = 0777
	force security mode = 0777
	hosts allow = 127. 192.168.0.


To create directory for share
	
	cd /opt
	mkdir  share
	mkdir  share/disk 
	mkdir  share/public
 	chown -R nobody:nobody share/

To add the config for disk(Read and writable) and public(Read only):

	[public]
	comment = Share Public directory
	path = /opt/share/public
	read only = yes
	create mask = 0744
	directory mask = 0744
	guest only = Yes
	guest ok = Yes

	[disk]
	comment = Share disk directory
	path = /opt/share/disk
	read only = no
	create mask = 0777
	directory mask = 0777
	guest only = Yes
	guest ok = Yes

	

## Start samba server

In order to make the network placesd(Windows) can display samba, The nmb service must start.
	
	# /etc/init.d/smb start
	# /etc/init.d/nmb start

	# chkconfig smb on
	# chkconfig nmb on	

## iptables setup

	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 137 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 138 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m tcp -p tcp --dport 139 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m tcp -p tcp --dport 445 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 445 -j ACCEPT
	
