---
layout: post
title: "Harden SSH access on CentOS 6"
tagline: "Harden SSH access on CentOS 6"
description: ""
category: Linux 
tags: [CentOs, Linux, Security ]
---
{% include JB/setup %}

## Default files Layout for configuration 

- /etc/ssh/sshd_config - For OpenSSH server 
/etc/ssh/ssh_config - For OpenSSH client
- ~/.ssh/ - configuration path for current user
- ~/.ssh/authorized_keys or ~/.ssh/authorized_keys - pub keys (RSA or DSA) 
- /etc/hosts.allow and /etc/hosts.deny : access control list（tcp-wrappers）

**NOTE**: The server configuration file IS NOT  "/etc/ssh/ssh_config"

## Change the access port

Run ssh on a non-standard port using Port option. you should edit the server 
configuration file:
 
	[root@server.com]#vim /etc/ssh/sshd_config
 
Then, update port from 22 to 60128:

	Port 60128
 
## Setup Iptables

You also need to update firewall settings so that users can login using TCP port 60128. 
Before setting up the iptables, You should make sure that the current ssh port can log in, 
otherwise it will cause ssh not login normally.  Edit, /etc/sysconfig/iptables and open 
sshd port 60128:

	[root@server.com]# vim /etc/sysconfig/iptables
 
Add the following rule:

	## delete or comment out port 22 line ##
	## -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT 
	## open port 60128
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 60128 -j ACCEPT
 
The Reboot the Iptables，check the list:
 
	[root@server.com]# /etc/init.d/iptables restart
	[root@server.com]# iptables --list
	Chain INPUT (policy ACCEPT)
	target     prot opt source               destination         
	ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
	ACCEPT     icmp --  anywhere             anywhere            
	ACCEPT     all  --  anywhere             anywhere            
	ACCEPT     tcp  --  anywhere             anywhere            state NEW tcp dpt:ssh 
	ACCEPT     tcp  --  anywhere             anywhere            state NEW tcp dpt:http 
	ACCEPT     tcp  --  anywhere             anywhere            state NEW tcp dpt:https 
	ACCEPT     tcp  --  anywhere             anywhere            state NEW tcp dpt:60128 
 
	.......

 
## Forbidden  remote access by root

You should file the keyword "PermitRootLogin" in the file named "/etc/ssh/sshd_config".

	#PermitRootLogin yes

Then, comment out this line and change it to no:

	PermitRootLogin yes
 
## Disable SSH Protocol 1

You should find the following in the  "/etc/ssh/sshd_config":

	# Protocol 2,1

Update it to:

	Protocol 2
 
## Enable key authentication

If you want to complete this step, you need a client and a server, our aim is to enable 
server-side ssh key authentication.

	client: 192.168.0.12 / example1.com
	server: 192.168.0.13 / example2.com

### Client-side: Create key

First, create a public/private key pair on the client(192.168.0.12) that you will use to 
connect to the server(192.168.0.13):
 
	[edwin@example1.com]$ ssh-keygen -t rsa
 
This will create two files in your (hidden) ~/.ssh directory called id_rsa and id_rsa.pub. id_rsa is your private key and id_rsa.pub is your public key.
Now set permissions on your private key:
 
	[edwin@example1.com]$ chmod 700 ~/.ssh
	[edwin@example1.com]$ chmod 600 ~/.ssh/id_rsa 
 
### Server-side:Add authorized_keys

Copy the public key (id_rsa.pub) to the server and install it to the authorized_keys list:
 
	[root@example2.com]# cat id_rsa.pub >> ~/.ssh/authorized_keys
 
Note: once you have imported the public key, you can delete it from the server.

and finally set file permissions on the server:
 
	[root@example2.com]# chmod 700 ~/.ssh
	[root@example2.com]# chmod 600 ~/.ssh/authorized_keys
 
The above permissions are required if StrictModes is set to yes in /etc/ssh/sshd_config (the default).

### Server-side: disable password authentication

	PasswordAuthentication no
 
### Reboot sshd
 
	[root@exmaple2.com]# /etc/rc.d/init.d/sshd restart
 
### Test from client-side
 
	[edwin@example1.com]$ ssh root@example2.com -p 60128
