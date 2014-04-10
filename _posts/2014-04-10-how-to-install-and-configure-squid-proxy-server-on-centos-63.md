---
layout: post
title: "how to install and configure squid proxy server on centos 6.3"
tagline: "how to install and configure squid proxy server on centos 6.3"
description: ""
category: Linux 
tags: [CentOs, Squid]
---
{% include JB/setup %}

This document describes the steps to setup a Squid proxy server on CentOs 6.3.
The Squid  will paly tow main roles which mainly act as a cacheing proxy server between the local users and the internet. The 2nd role, the Squid also regularly used as a content accelerator, intercepting requests to a server and using a cached version of the web page to serve the request for the local users.

The following steps is to insall and configure the Squid.

## Installation

### local network

	Network:192.168.0.0/16
	Proxy Server:192.168.0.3

### install by yum

	#yum install squid -y

## Configuration

	#vim /etc/squid/squid.conf


### ACL

	acl manager proto cache_object
	acl localhost src 127.0.0.1/32 ::1
	acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1

	acl localnet src 192.168.0.0/16 # RFC1918 possible internal network

	acl SSL_ports port 443
	acl Safe_ports port 80          # http
	acl Safe_ports port 21          # ftp
	acl Safe_ports port 443         # https
	acl Safe_ports port 70          # gopher
	acl Safe_ports port 210         # wais
	acl Safe_ports port 1025-65535  # unregistered ports
	acl Safe_ports port 280         # http-mgmt
	acl Safe_ports port 488         # gss-http
	acl Safe_ports port 591         # filemaker
	acl Safe_ports port 777         # multiling http
	acl CONNECT method CONNECT

### http access

	http_access allow manager localhost
	http_access deny manager

	# Deny requests to certain unsafe ports
	http_access deny !Safe_ports

	# Deny CONNECT to other than secure SSL ports
	http_access deny CONNECT !SSL_ports

	http_access allow localnet
	http_access allow localhost

	# And finally deny all other access to this proxy
	http_access deny all

### access port
	
	http_port 3128

### refresh_pattern

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320

### cache

	coredump_dir /var/cache/squid
	cache_dir ufs /var/cache/squid 10000 16 256

	cache_mem 600 MB

	cache_swap_low                  70
	cache_swap_high                 85
	maximum_object_size             32768 KB

	ipcache_size                    1024
	ipcache_low                     90
	ipcache_high                    95
	fqdncache_size                  1024


### hostname

	visible_hostname srv.hxstong.org

## Post setup

### Sysctl Configuration

To open the sysctl config file

	vim /etc/sysctl.conf

To modify the following params:


	# Controls IP packet forwarding
	net.ipv4.ip_forward = 1

	# Controls source route verification
	net.ipv4.conf.default.rp_filter = 1

	# Do not accept source routing
	net.ipv4.conf.default.accept_source_route = 0

To apply this configuration

	#sysctl -p

### iptables
	
	iptables -A INPUT -s 192.168.0.0/24 -p tcp --dport 3128 -j ACCEPT
	iptables -A OUTPUT -d 192.168.0.0/24 -p tcp --sport 3128 -J ACCEPT

### services setup

	#chkconfig squid on
	#/etc/init.d/squid start

