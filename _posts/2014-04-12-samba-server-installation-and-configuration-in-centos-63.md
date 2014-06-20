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

## Install samba

 To run this in a terminal install the samba packages:

	# yum install samba* -y

## Configuration

The default configuration file: /etc/samba/smb.conf

	# vim /etc/samba/smb.conf

### Configure for anonymous share

#### Key params in global

To specify the Windows workgroup and a brief description of the Samba server:

	workgroup = WORKGROUP
	server string = samba.example.com

Te be a WINS server

	wins support = Yes
	netbios name = robert
	browseable = yes
	public = yes

In smb.conf, the security = share directive that sets share-level security is: 

	security = share

To enable Chinese charset support if need
	
	dos charset = GB2312
	unix charset = GB2312
	display charset = GB2312

Directory permission:

	directory mask = 0777
	force directory mode = 0777
	directory security mask = 0777
	force directory security mode = 0777
	create mask = 0777
	force create mask = 0777
	security mask = 0777
	force security mode = 0777

Restrict who can access the shares

	hosts allow = 127. 192.168.0.


To create directory for share
	
	cd /opt
	mkdir  share
	mkdir  share/disk 
	mkdir  share/public
 	chown -R nobody:nobody share/

#### Share group

To create a Samba share directory on your Linux system, add the following section to your smb.conf file.
Let us add the config for disk(Read and writable) and public(Read only) in this example:

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

By default Samba is not started automatically at boot. You can set it to start automatically on boot by running this command:

	# chkconfig smb on
	# chkconfig nmb on	

## Disable SELinux

By default, SELinux will disallow the samba daemons (smb and nmb respectively) access to any folder, so you will need 
to disable selinux.

	

## iptables setup

 To allow TCP ports 139 and 445 as well as UDP ports 137 and 138 through your firewall

	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 137 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 138 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m tcp -p tcp --dport 139 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m tcp -p tcp --dport 445 -j ACCEPT
	iptables -A INPUT -s 192.168.0.0/24 -m state --state NEW -m udp -p udp --dport 445 -j ACCEPT
	
