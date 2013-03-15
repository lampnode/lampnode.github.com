---
layout: post
title: "增强CentOs的SSH安全配置"
tagline: "Harden SSH access on CentOS 6"
description: ""
category: Linux 
tags: [CentOs, Linux, Security ]
---
{% include JB/setup %}

In a few simple steps, you will be able to diminish risks of unauthorized ssh accesses Your ssh settings can be found in "/etc/ssh/sshd_config", this is where you will have to modify the configuration settings below.

Note: The config file is NOT "/etc/ssh/ssh_config"

## Change your ssh port

### Modify config

By default, ssh run on port 22. You will need to change this default value to an arbitrary port number :
 
	[root@server.com]#vim /etc/ssh/sshd_config
 
This will require ssh connexions to use the 60125 port

	Port 60128
 
## Setup iptables

设置防火墙的时候，务必确认当前ssh端口可以登录，否则会造成ssh无法登录。
 
	[root@server.com]# vim /etc/sysconfig/iptables
 
Add the following to this file:
 
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 60128 -j ACCEPT
 
Restart and check the the iptables:
 
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
 
## Disable root login

If the hacker still gets to connect to your ssh port, he will need authentication. Obvisously he will try the root account which grant maximum priviledge on the server, so you want to disable direct root ssh access.
 
Find this line in your /etc/ssh/sshd_config and change its value to "no"

	PermitRootLogin no
 
## Disable Protocol 1

SSH has two protocols it may use, protocol 1 and protocol 2. The older protocol 1 is less secure and should be disabled unless you know that you specifically require it. Look for the following line in the /etc/ssh/sshd_config file, uncomment it and amend as shown:
 
	# Protocol 2,1
	Protocol 2
 
## Use Public/Private Keys for Authentication

### Client:Create public/private key
First, create a public/private key pair on the client that you will use to connect to the server:
 
	[edwin@client]$ ssh-keygen -t rsa
 
This will create two files in your (hidden) ~/.ssh directory called id_rsa and id_rsa.pub. id_rsa is your private key and id_rsa.pub is your public key.
Now set permissions on your private key:
 
	[edwin@client]$ chmod 700 ~/.ssh
	[edwin@client]$ chmod 600 ~/.ssh/id_rsa 
 
### Server:Setup authorized_keys
Copy the public key (id_rsa.pub) to the server and install it to the authorized_keys list:
 
	[root@server.com]# cat id_rsa.pub >> ~/.ssh/authorized_keys
 
Note: once you have imported the public key, you can delete it from the server.

and finally set file permissions on the server:
 
	[root@server.com]# chmod 700 ~/.ssh
	[root@server.com]# chmod 600 ~/.ssh/authorized_keys
 
The above permissions are required if StrictModes is set to yes in /etc/ssh/sshd_config (the default).

### Server:Setup sshd_config
Once you have checked you can successfully login to the server using your public/private key pair, you can disable password authentication completely by adding the following setting to your /etc/ssh/sshd_config file:
 
Disable password authentication forcing use of keys
	PasswordAuthentication no
 
### Server:Restart sshd service
 
	[root@server.com]# /etc/rc.d/init.d/sshd restart
 
### Client:Test
 
	[edwin@client]$ ssh root@server.com -p 60128
