---
layout: post
title: "Manually Installing Zend Server"
tagline: "Manually Installing Zend Server"
description: ""
category: Linux 
tags: [ ZendServer, CentOs, Ubuntu, PHP ]
---
{% include JB/setup %}

This document applies only to Zend Server 5.x
 
## Installation 

### On Ubuntu

Only for Ubuntu 10.x, 9.x, 11.04 or later versions do not apply this configuration.

#### Add deb sources 

Add the following line on the file named " /etc/apt/sources.list":

	deb http://repos.zend.com/zend-server/deb server non-free


Import public key from the Zend repository:

	$ wget http://repos.zend.com/zend.key -O- |sudo apt-key add -

Then, update local repository:

	$ sudo apt-get update


#### Setup

##### Install Zend Server CE

	$ sudo apt-get install zend-server-php-5.x

##### Install Zend Server


	$ sudo apt-get install zend-server-php-5.x

### On CentOs/RHEL/Fedora

#### Setup YUM repository

Create a new repo file named "/etc/yum.repos.d/zend.repo",
	
	$sudo vim /etc/yum.repos.d/zend.repo
	
Add the following lines to this file:

	[Zend]
	name=Zend Server
	baseurl=http://repos.zend.com/zend-server/rpm/$basearch
	enabled=1
	gpgcheck=1
	gpgkey=http://repos.zend.com/zend.key

	[Zend_noarch]
	name=Zend Server - noarch
	baseurl=http://repos.zend.com/zend-server/rpm/noarch
	enabled=1
	gpgcheck=1
	gpgkey=http://repos.zend.com/zend.key


#### Setup

##### For Zend Server CE

	$sudo yum install zend-server-ce-php-5.x

Examples:

	$sudo yum install zend-server-ce-php-5.2

Or for php 5.3(Recommend)

	$sudo yum install zend-server-ce-php-5.3


##### For Zend Server  


	$sudo yum install zend-server-php-x

##### post installation

	# yum clean all

## Setup web shell for zend server

After installing, a completion notification will appear, with a notice that the servers have started. To access the Administration Interface (Web) open your browser at:
 
	https://localhost:10082/ZendServer
 
or
 
	http://localhost:10081/ZendServer.
 
Upon initial log in, you will be prompted to define your password.


## Post configuration

### Add path

To add the install/path/bin directory to your $PATH environment variable for all users:

Log in as root or use sudo to execute the following commands.Using a text editor, open /etc/profile.  
	
	$sudo vim /etc/profile	

Add the following lines to the end of the file:
	
	PATH=$PATH:/install/path/bin
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:install/path/lib

Example:

	PATH=$PATH:/usr/local/zend/bin
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/zend/lib


Replace install_path with your Zend Server installation path. Then save the file. In order for this to take effect, close and reopen your shell or run the following command:

	$sudo source /etc/profile

You can now run the PHP binary provided by Zend Server without typing its full path.

## Uninstall Zend Server

### Steps

To uninstall run:

	$sudo zendctl.sh stop

And then:

	$yum remove -y 'deployment-daemon-zend-server' && yum remove -y '*zend*'

If you want to disable Zend source words, need to remove the zend.repo

### Reference articles

See [How to setup apache virtual hosts ](/apache/how-to-setup-apache-virtual-host-configuration/)


