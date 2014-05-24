---
layout: post
title: "How to Change the Server Hostname on CentOS"
tagline: "How to Change the Server Hostname on CentOS"
description: ""
category: Linux 
tags: [Linux, CentOs ]
---
{% include JB/setup %}

The purpose of this document is guide you to change the hostname on CentOS. you should use any one of the following
methods to change the hostname on CentOS.

## Method A: Use "hostname" command

Enter the following command into the console:

	$hostname my.server.com

To view the hostgname, it has changed to "my.server.com". But this method will restore the previous state after you reboot
the system.

## Method B: Modify the network configuration

### Edit "/etc/sysconfig/network"

The "/etc/sysconfig/network" file also has an entry for HOSTNAME. Change the value here as shown below.

	$sudo vim /etc/sysconfig/network

Modify this file, and set the new hostname here. For example, change it as shown below:

	HOSTNAME=some.servernewname.com

Restart the network service, if you want any other services that are using the hostname to pickup the changes.

	$sudo service network restart
	Shutting down interface eth0:        [  OK  ]
	Shutting down loopback interface:   [  OK  ]
	Bringing up loopback interface:     [  OK  ]
	Bringing up interface eth0:          [  OK  ]

If this is not a production system, you can also reboot the system to make sure the hostname is changed properly, 
and the system is picking it up properly during startup.

###  Modify the "/etc/hosts" file

If you have entries in the "/etc/hosts" file with the old hostname. you should modify it. For example, the entry 
for 127.0.0.1 line in this file will still show the old hostname, In this example, it shows as "dev-server":

	$ cat /etc/hosts
	127.0.0.1  dev-server localhost.localdomain localhost

Modify this file, and set the new hostname here.

	$sudo vim /etc/hosts

Change the dev-server to some.servernewname.com.
