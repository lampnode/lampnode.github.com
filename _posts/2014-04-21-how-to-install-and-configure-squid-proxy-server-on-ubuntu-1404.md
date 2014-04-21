---
layout: post
title: "How to install and configure squid proxy server on Ubuntu 14.04"
tagline: "How to install and configure squid proxy server on Ubuntu 14.04"
description: ""
category: Linux
tags: [ Ubuntu ]
---
{% include JB/setup %}

This document describes the steps to setup a Squid proxy server on Ubuntu 14.04

## Installation

### Local network

	LAN:192.168.0.0/24
	Proxy Server:192.168.0.3(hostname:srv.example.com)

### install squid3 by apt-get

	$sudo apt-get install squid3

## Configuration

### Create cache path
	
	$sudo mkdir -p /var/cache/squid
	$sudo chown proxy:proxy /var/cache/squid

### modify the config file

Before editing squid configuration, Make a backup of your /etc/squid3/squid.conf file for future reference. Squid.conf has nearly all the options listed and it is recommended to go through that file to know more about squid options.

	$sudo cp /etc/squid3/squid.conf /etc/squid3/squid.conf.origin
	$sudo vim /etc/squid3/squid.conf

Squid3 configuration:
	
	#Set localnet
	acl localnet src 192.168.0.0/16	
	
	#Add related http_access before localhost 
	http_access allow localnet
	http_access allow localhost

	#Setup cache
	cache_dir ufs /var/cache/squid 10000 16 256
	cache_mem 600 MB
	cache_swap_low                  70
	cache_swap_high                 85
	maximum_object_size             32768 KB

	ipcache_size                    1024
	ipcache_low                     90
	ipcache_high                    95
	fqdncache_size                  1024
	
	#Add visible_hostname if you need
	visible_hostname srv.example.com


### Create swap directory

	$ sudo squid3 -z
	2014/04/21 11:06:21| Squid is already running!  Process ID 1060

### config ip_forword

	$sudo vim /etc/sysctl.conf
	
To modify the following params:

	# Controls IP packet forwarding
	net.ipv4.ip_forward = 1

	# Controls source route verification
	net.ipv4.conf.default.rp_filter = 1

	# Do not accept source routing
	net.ipv4.conf.default.accept_source_route = 0

To apply this configuration

	$sudo sysctl -p

### setup ufw

	$sudo ufw allow 3128

## Start squid3

	edwin@srv:~$ sudo service squid3 restart
	squid3 stop/waiting
	squid3 start/running, process 6576


