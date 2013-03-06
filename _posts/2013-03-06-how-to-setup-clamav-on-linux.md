---
layout: post
title: "如何在Linux上设置ClamAV"
tagline: "How to setup ClamAV on Linux"
description: ""
category: Linux
tags: [ Linux, Security ]
---
{% include JB/setup %}

ClamAV is an open source (GPL) antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats. It is the de facto standard for mail gateway scanning. It provides a high performance mutli-threaded scanning daemon, command line utilities for on demand file scanning, and an intelligent tool for automatic signature updates. The core ClamAV library provides numerous file format detection mechanisms, file unpacking support, archive support, and multiple signature languages for detecting threats. The core ClamAV library is utilized in Immunet 3.0, powered by ClamAV, which is a fast, fully featured Desktop AV solution for Windows.

## Installation On CentOs

### Download rpm packages

We can download the lastest stable version 0.97.2-1 from http://pkgs.repoforge.org/clamav/
 
	wget http://pkgs.repoforge.org/clamav/clamav-db-0.97.2-1.el5.rf.x86_64.rpm
	wget http://pkgs.repoforge.org/clamav/clamav-0.97.2-1.el5.rf.x86_64.rpm
	wget http://pkgs.repoforge.org/clamav/clamd-0.97.2-1.el5.rf.x86_64.rpm
 
### RPM Install

	rpm -ivh clamav-db-0.97.2-1.el5.rf.x86_64.rpm
	rpm -ivh clamav-0.97.2-1.el5.rf.x86_64.rpm
	rpm -ivh clamd-0.97.2-1.el5.rf.x86_64.rpm
 
### Start clamd and freshclam

 
	service clamd start
	freshclam --daemon
 
### Auto Start the freshclam

	echo "/usr/bin/freshclam --daemon" >> /etc/rc.d/rc.local


## Basic Usage

### Scan files
 
	clamscan file
 
### Scan path
 
	clamscan -r /home
 
	clamscan -r /  
 
 
### Load database from selected file and limit disk usage to 50 Mb
 
	clamscan -d /tmp/newclamdb --max-space=50m -r /tmp
 
### Scan Data folw
 
	cat testfile | clamscan -
 
### Scan mail path
 
	clamscan -r --mbox /var/spool/mail
 
###Save the scan report to file
 
	clamscan -r -i --mbox /var/spool/mail>error.log
 
	clamscan -r -i /home>error.log
 
