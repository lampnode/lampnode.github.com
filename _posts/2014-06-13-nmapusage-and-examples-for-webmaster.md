---
layout: post
title: "Nmap:Usage and Examples for webmaster"
tagline: "Nmap:Usage and Examples for webmaster"
description: ""
category: Linux 
tags: [ Linux, Network ]
---
{% include JB/setup %}

## Basic usages

### Scan a single host

	### Scan with ip
	# nmap 192.168.0.1
 
	## Scan with host name
	# nmap server.example.com
 
Sample outputs:

	Starting Nmap 6.40 ( http://nmap.org ) at 2014-06-13 18:52 CST
	Nmap scan report for dev.hxstong.org (192.168.0.7)
	Host is up (0.00063s latency).
	Not shown: 995 filtered ports
	PORT     STATE SERVICE
	80/tcp   open  http
	135/tcp  open  msrpc
	139/tcp  open  netbios-ssn
	445/tcp  open  microsoft-ds
	2869/tcp open  icslap

	Nmap done: 1 IP address (1 host up) scanned in 16.57 seconds

### Scan multiple hosts

	# nmap 192.168.0.1 192.168.0.12 192.168.0.23
	# nmap 192.168.0.1-20
	# 192.168.0.0/24
	# nmap 192.168.0.0/24 --exclude 192.168.0.5

Read list of hosts/networks from a file

	# nmap -iL ~/hosts.txt

Example of file content(hosts.txt):

	server.example.com
	192.168.0.0/24
	192.168.1.0/24
	10.1.2.3
	localhost

Sample output:

	Starting Nmap 6.40 ( http://nmap.org ) at 2014-06-13 18:53 CST
	Nmap scan report for 192.168.0.1
	Host is up (0.0061s latency).
	Not shown: 996 closed ports
	PORT     STATE SERVICE
	53/tcp   open  domain
	80/tcp   open  http
	443/tcp  open  https
	7777/tcp open  cbt

	Nmap scan report for dev.example.com (192.168.0.7)
	Host is up (0.00085s latency).
	Not shown: 995 filtered ports
	PORT     STATE SERVICE
	80/tcp   open  http
	135/tcp  open  msrpc
	139/tcp  open  netbios-ssn
	445/tcp  open  microsoft-ds
	2869/tcp open  icslap

	Nmap scan report for printer.example.com (192.168.0.10)
	Host is up (0.00033s latency).
	Not shown: 993 filtered ports
	PORT    STATE  SERVICE
	22/tcp  open   ssh
	53/tcp  open   domain
	80/tcp  closed http
	139/tcp open   netbios-ssn
	443/tcp closed https
	445/tcp open   microsoft-ds
	631/tcp open   ipp

	Nmap scan report for ns.example.com (192.168.0.16)
	Host is up (0.00061s latency).
	Not shown: 994 closed ports
	PORT     STATE SERVICE
	53/tcp   open  domain
	80/tcp   open  http
	443/tcp  open  https
	3128/tcp open  squid-http
	3306/tcp open  mysql
	4000/tcp open  remoteanything

	Nmap done: 256 IP addresses (5 hosts up) scanned in 20.89 seconds

Save output to a text file:

	# nmap 192.168.0.1 > output.txt
	# nmap -oN ~/output 192.168.0.1


## Advanced Usages
	
###	Turn on OS and version detection

	#nmap -A 192.168.0.7
 
Sample output:

	Starting Nmap 6.40 ( http://nmap.org ) at 2014-06-13 19:05 CST
	Nmap scan report for dev.hxstong.org (192.168.0.7)
	Host is up (0.00046s latency).
	Not shown: 995 filtered ports
	PORT     STATE SERVICE     VERSION
	80/tcp   open  http        Apache httpd 2.2.25 ((Win32) mod_ssl/2.2.25 OpenSSL/0.9.8y)
	|_http-methods: No Allow or Public header in OPTIONS response (status code 200)
	| http-robots.txt: 1 disallowed entry 
	|_/
	|_http-title: Site doesn`t have a title (text/html;charset=UTF-8).
	135/tcp  open  msrpc       Microsoft Windows RPC
	139/tcp  open  netbios-ssn
	445/tcp  open  netbios-ssn
	2869/tcp open  http        Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
	Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

	Host script results:
	|_nbstat: NetBIOS name: DEVELOPER, NetBIOS user: <unknown>, NetBIOS MAC: d4:3d:7e:f0:0c:24 (Micro-Star Int`l Co)
	| smb-os-discovery: 
	|   OS: Windows 7 Ultimate 7601 Service Pack 1 (Windows 7 Ultimate 6.1)
	|   OS CPE: cpe:/o:microsoft:windows_7::sp1
	|   Computer name: Developer
	|   NetBIOS computer name: DEVELOPER
	|   Workgroup: WORKGROUP
	|_  System time: 2014-06-13T19:06:16+08:00
	| smb-security-mode: 
	|   Account that was used for smb scripts: guest
	|   User-level authentication
	|   SMB Security: Challenge/response passwords supported
	|_  Message signing disabled (dangerous, but default)
	|_smbv2-enabled: Server supports SMBv2 protocol

	Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
	Nmap done: 1 IP address (1 host up) scanned in 111.26 seconds


### Scan host with specific ports protected by firewall

	#  nmap -PN -p 1-20000 192.168.0.16
	
Sample output:

	Starting Nmap 6.40 ( http://nmap.org ) at 2014-06-13 19:13 CST
	Nmap scan report for 192.168.0.16
	Host is up (0.022s latency).
	Not shown: 19996 filtered ports
	PORT      STATE  SERVICE
	22/tcp    closed ssh
	80/tcp    open   http
	443/tcp   open   https
	10001/tcp open   unknown

	Nmap done: 1 IP address (1 host up) scanned in 78.44 seconds

### Detect remote services

	#nmap -sV -p T:10001 192.168.0.8

	Starting Nmap 6.40 ( http://nmap.org ) at 2014-06-13 19:41 CST
	Nmap scan report for 192.168.0.8
	Host is up (0.022s latency).
	PORT      STATE SERVICE VERSION
	10001/tcp open  ssh     OpenSSH 5.9p1 Debian 5ubuntu1 (Ubuntu Linux; protocol 2.0)
	Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

	Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
	Nmap done: 1 IP address (1 host up) scanned in 0.66 seconds





