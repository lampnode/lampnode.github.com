---
layout: post
title: "Howto configure sudo on CentOS"
tagline: "Howto configure sudo on CentOS"
description: ""
category: Linux
tags: [ Linux, CentOs ]
---
{% include JB/setup %}

The purpose of this document is to provide a quick and easy guide for settting sudo on CentOS. It`s a good method to 
implement security on linux is harden the user management policy and user permission.


## Check sudo has installed or not

	#rpm -qa|grep sudo
	sudo-1.7.4p5-13.el6_3.x86_64

## Setup steps

### Modify the sudoers configurartion file

To use "/usr/sbin/visudo" to add/remove the list of users who can execute "sudo"

	# visudo

Or:

	$vim /etc/sudoers

#### For root permissons

In the end of this file or the below of the line " root ALL=(ALL)      ALL ", add the following lines, replacing [USERNAME] 
with your Respective username:

	# For user can use all root privilege
 	edwin  		 ALL=(ALL)      ALL
	cent             ALL=(ALL)      NOPASSWD: ALL

Syntax:

	[USERNAME]     ALL=(ALL)     ALL


 - User "edwin" will has administrator privileges as root.
 - User "cent" will be a system administrator too, he will exacute any command as root without password. It may really be 
very dangerous! Not recommended.

#### Optional settings

##### Limit executing commands

	# Add aliase for the kind of shutdown commands
	Cmnd_Alias SHUTDOWN = /sbin/halt, /sbin/shutdown, \
	/sbin/poweroff, /sbin/reboot, /sbin/init

	# add commands in aliase 'SHUTDOWN' are not allowed 
	edwin	ALL=(ALL)	ALL, !SHUTDOWN

##### Use aliases

	# Add aliase for the kind of user management comamnds
	Cmnd_Alias USERMGR = /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod, \
	/usr/bin/passwd
	
	# add at the last
	%usermgr	ALL=(ALL)	USERMGR


##### Assign the specified command to the specified user

In the end of "root ALL=(ALL) ALL", add the following:

	# add at the last
	 cent    ALL=(ALL) /usr/sbin/visudo
	fedora  ALL=(ALL) /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod, /usr/bin/passwd
	ubuntu  ALL=(ALL) /bin/vi

### Reboot the services:

	# shutdown -r now

### Test

Use "fdisk" to test sudoer is work or not:

	$ sudo fdisk -l
	
	We trust you have received the usual lecture from the local System
	Administrator. It usually boils down to these three things:

	    #1) Respect the privacy of others.
	    #2) Think before you type.
	    #3) With great power comes great responsibility.

	[sudo] password for edwin: 

	Disk /dev/xvda: 21.5 GB, 21474836480 bytes
	255 heads, 63 sectors/track, 2610 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk identifier: 0x00000000

	    Device Boot      Start         End      Blocks   Id  System
	/dev/xvda1   *           1        2550    20480000   83  Linux
	/dev/xvda2            2550        2611      490496   82  Linux swap / Solaris


## Add sudo logs

### Modify the sudo configuration file:

	# visudo  

Add the following at the end of this file:

	# For log
	Defaults syslog=local1

### Modify the "/etc/rsyslog.conf"

	#vi /etc/rsyslog.conf 
	
In about 42 lines, add the following

	# The authpriv file has restricted access.
 	local1.*	/var/log/sudo.log #需要增加的内容
	authpriv.*	/var/log/secure

### Add sudo.log

	# touch /var/log/sudo.log

### Reboot system log service

	#/etc/init.d/rsyslog restart
	Shutting down system logger:                               [  OK  ]
	Starting system logger:                                    [  OK  ]

### Test	

Use "fdisk" to test it:

	[edwin@ ~]$ sudo fdisk -l
	[sudo] password for edwin: 

	Disk /dev/xvda: 21.5 GB, 21474836480 bytes
	255 heads, 63 sectors/track, 2610 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk identifier: 0x00000000

    	Device Boot      Start         End      Blocks   Id  System
	/dev/xvda1   *           1        2550    20480000   83  Linux
	/dev/xvda2            2550        2611      490496   82  Linux swap / Solaris

Check the "/var/log/sudo.log":

	[edwin@ ~]$ sudo cat /var/log/sudo.log 
	Apr 28 11:37:51 lo sudo:    edwin : TTY=pts/1 ; PWD=/home/edwin ; USER=root ; COMMAND=/sbin/fdisk -l
	Apr 28 11:38:02 lo sudo:    edwin : TTY=pts/1 ; PWD=/home/edwin ; USER=root ; COMMAND=/bin/cat /var/log/sudo.log

