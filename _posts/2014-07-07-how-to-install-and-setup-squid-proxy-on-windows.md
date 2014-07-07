---
layout: post
title: "How to Install and Setup Squid Proxy on Windows"
tagline: "How to Install and Setup Squid Proxy on Windows"
description: ""
category: Windows
tags: [ Windows, Squid ]
---
{% include JB/setup %}

The purpose of this document is to guide your step by step to insall and configurate squid on Windows.

## Requirement

- squid for windows 2.7
- Windows XP sp3

## Installation

### Download Squid

You should download squid 2.7 for Windows from [http://squid.acmeconsulting.it/Squid27.html](http://squid.acmeconsulting.it/Squid27.html). Then unzip the file, copy squid directory to the "C:/". If you modify it, is not recommended.

### Init configuration

To open command prompt as Administrator, and type below commands to copy default configuration files and 
install squid as windows service.

	> cd /d c:\squid\etc
	> copy *.default *.

## Configuration

### Basic configuration

#### Restricting access to your Squid Proxy Server

To limit on who are allowed to connect to your Proxy Server, you should change / add the allowed IP Address that is allowed to connect to your squid proxy at below section

	#acl localnet src 10.0.0.0/8	# RFC1918 possible internal network
	#acl localnet src 172.16.0.0/12	# RFC1918 possible internal network
	acl localnet src 192.168.0.0/16	# RFC1918 possible internal network

then right before http_access allow localnet, add http_access allow localhost so it looks like:

	http_access allow localhost
	http_access allow localnet

#### Limiting access to specific ports only

If you need to limit on which ports your Squid proxy clients are allowed to connect to, then you need to adjust this

	acl Safe_ports port 80		# http
	acl Safe_ports port 21		# ftp
	acl Safe_ports port 443		# https
	acl Safe_ports port 70		# gopher
	acl Safe_ports port 210		# wais
	acl Safe_ports port 1025-65535	# unregistered ports
	acl Safe_ports port 280		# http-mgmt
	acl Safe_ports port 488		# gss-http
	acl Safe_ports port 591		# filemaker
	acl Safe_ports port 777		# multiling http

For example if you want to limit your clients to HTTP and HTTPS only, then you can remove / comment all the other lines beside 80 and 443.

#### Changing disk cache location and size

For better performance, it’s better to put the Squid cache directory into another partition (in other words, not your system partition) and even better on different hard drive. So find this line:

	cache_dir ufs c:/squid/var/cache 100 16 256

And then change it to any directory you want, and also adjust the disk cache size to your liking, for example to put your squid cache directory at X:\squid-data\cache with a maximum capacity of 1500 MB

	cache_dir ufs x:/squid-data/cache 1500 16 256

Also it’d better to put all squid logs into different partition too

	cache_log x:/squid-data/logs/cache.log 		#c:/squid/var/logs/cache.log
	access_log x:/squid-data/logs/access.log 	#c:/squid/var/logs/access.log squid
	cache_store_log x:/squid-data/store.log 	#c:/squid/var/logs/store.log

#### Creating Squid cache data directory

Now back at the command prompt again, and this time type:
	
	> c:\squid\sbin\squid.exe -z

To create Squid Swap Directories which is used to store cached objects

#### Parsing configuration


	> c:\squid\sbin\squid -k parse

#### Starting Squid Service

	> c:\squid\sbin\squid -i

Then , you should start the squid service on the control panel. If you choose command prompt method then you need to type (run command prompt as administrator):

	> net start squid


Note: if you want to uninstall squid services, you should run the following command:

	> c:\squid\sbin\squid -r

### Advanced Configuration

#### Object cache size

	maximum_object_size 64 MB
	cache_mem 96 MB
	maximum_object_size_in_memory 256 KB

#### DNS

use specific dns server in this case

	dns_nameservers 208.67.222.222 208.67.220.220

#### visible_hostname

	visible_hostname squid.example.com

