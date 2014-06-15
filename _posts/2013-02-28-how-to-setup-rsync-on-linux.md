---
layout: post
title: "How to Setup Rsync on Linux"
tagline: "How to Setup Rsync on Linux"
description: ""
category: Linux 
tags: [ Linux, rsync ]
---
{% include JB/setup %}


## Testing Environment

* Server-side Host 192.168.1.105 Rsync server
* Client-side Host 192.168.1.100 

## Server-side configuration

### Install packages
	
	#sudo yum -y install xinetd  rsync

### Setup xinetd

Modify "disable = yes" to "disable = no" (/etc/xinetd.d/rsync)

	#sudo vim /etc/xinetd.d/rsync

Sample file:

	service rsync
	{
	disable = no #Update "yes" to "no"
	socket_type = stream
	wait = no
	user = root
	server = /usr/bin/rsync
	server_args = –daemon
	log_on_failure += USERID
	}

### Start xinetd services

	#sudo  /etc/init.d/xinetd start

### Setup iptables

The port of rsync service is 873. 

	# iptables -A INPUT -p tcp --dport 873 -j ACCEPT

Sample outputs:

	# iptables --list
	......
	ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh 
	ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:rsync 
	......

Save the new rule:

	#sudo /etc/init.d/iptables save


### Edit "rsyncd.conf"

	#sudo vim /etc/rsyncd.conf

Sample content:

{% highlight bash %}

# Global setup
hosts allow=192.168.0.102 192.168.0.100  
hosts deny=*
log file = /var/log/rsyncd.log
uid = root
gid = root

# Module setup
[web]
path = /var/www
auth users = admin
secrets file = /etc/rsyncd.secrets
read only= yes

[database]
path = /var/database
auth users = admin
secrets file = /etc/rsyncd.secrets
read only= yes

{% endhighlight %}

### Edit "rsyncd.secrets"

	#sudo vim /etc/rsyncd.secrets

Sample content:
		
	admin:1234 

### Modify the permission of "rsynced.secrets"

	#sudo  chown root:root /etc/rsyncd.secrets
	#sudo  chmod 600 /etc/rsyncd.secrets


## Client-side configuration

### Install rsync

	#sudo yum -y install rsync

### Usages 

#### Format

	rsync [OPTION]... SRC DEST
	rsync [OPTION]... SRC [USER@]HOST:DEST
	rsync [OPTION]... [USER@]HOST:SRC DEST
	rsync [OPTION]... [USER@]HOST::SRC DEST
	rsync [OPTION]... SRC [USER@]HOST::DEST	
	rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]


#### Usages

#### Rsync data

	# rsync -avz admin@192.168.1.105::backup /www

#### Rsync data with delete
	
	# rsync -avz --delete admin@192.168.1.105::backup /www

***NOTE*** With delete(Warnin:When using this parameter, it is recommended to use absolute path
136 Specify the local directory path to prevent empty the current directory)

#### Rsync data with SSH

See[How to backup data useing rsync with SSH ](/Linux/using-rsync-with-ssh-to-backup-data/) 

#### Rsync data with crond

##### Files and Directories

Content of backup("/opt/backup"):

	drwxr-xr-x 11 lampnode lampnode May 23 09:44 data
	-r--------  1 lampnode lampnode   23 Jun 15 15:39 rsync.pwd
	-rwx------  1 lampnode lampnode  122 Jun 15 15:43 web.sync.sh

##### rsync.pwd

Content Example:

	1234

##### web.sync.sh
	
Content Example:

	#!/bin/bash
	/usr/bin/rsync -avz admin@192.168.1.105::web /opt/backup/data --password-file=/opt/backup/rsync.pwd
