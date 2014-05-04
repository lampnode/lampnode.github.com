---
layout: post
title: "Howto manage VPN connection from the command line on Ubuntu"
tagline: "Howto manage VPN connection from the command line on Ubuntu"
description: ""
category: Linux 
tags: [ Linux, Ubuntu, VPN ]
---
{% include JB/setup %}

The purpose of this document is to explain how to connect/disconnect VPN from the command line on Ubuntu. if you want 
to interact with NetworkManager from the command line you can use the "nmcli" command.

## Abount nmcli

nmcli is a command-line tool for controlling NetworkManager and getting its status.  It is not meant as a replacement 
of nm-applet or other similar clients.  Rather it's a complementary utility to these programs.  The main nmcli's usage 
is on servers, headless machines or just for power users who prefer the command line.

## Basic usage

You can list all NM connections using the following command

	$ sudo nmcli con
	[sudo] password for edwin: 
	NAME                      UUID                                   TYPE              TIMESTAMP-REAL                    
	VPN.HK1                   39895673-8899-4c10-89a4-fd171328bbbf   vpn               ......
	Auto Ethernet             8a91884c-cd0c-4af4-a164-175f877928c8   802-3-ethernet    ......
	VPN.KR1                   79dc89d0-2a3b-4782-82f4-8704251311f7   vpn               ......

You can start connection (wifi, vpn, etc) using the following command

	nmcli con up id CONNECTION_NAME

Example

	$sudo con up id VPN.HK1


You can disconnect the connection using the following command

	nmcli con down id CONNECTION_NAME

Example 

	$sudo con down id VPN.HK1

### Debug

The regular users usually don not have permission to control networking. Using the commands 
above with sudo should work for most connections, but VPN specifically might fail with the following error

	"Error: Connection activation failed: no valid VPN secrets."


#### Reason for this error

For most connection types, the default handling is that NM stores passwords itself. However, for certain VPN, the passwords 
are rather regarded as personal and thus they are stored by default in clients (e.g.keyring). So, if you have configured 
vpn connection for a user, but activate that under root or sudoer, the password in user's keyring is not accessible.


In order to fix this, you should edit the following file 

	/etc/NetworkManager/system-connections/CONNECTION_NAME

Example
	/etc/NetworkManager/system-connections/VPN.HK1 

Under the group [vpn], change the password flags line to(Default is password-flags=1):

	password-flags=0

then, add the following:

	[vpn-secrets]
	password=YourPassword

Then starting the VPN connection with sudo nmcli con up id ConnectionName should work without problems.

## Other usage

### To view the current wireless network

	 nmcli dev wifi



