---
layout: post
title: "增强CentOs的SSH安全配置"
tagline: "Harden SSH access on CentOS 6"
description: ""
category: Linux 
tags: [CentOs, Linux, Security ]
---
{% include JB/setup %}

## 默认配置

- /etc/ssh/sshd_config - OpenSSH服务器配置文件
/etc/ssh/ssh_config - OpenSSH客户端配置文件
- ~/.ssh/ - 用户ssh配置目录
- ~/.ssh/authorized_keys or ~/.ssh/authorized_keys - 公钥列表 (RSA or DSA) 
- /etc/hosts.allow and /etc/hosts.deny : 访问控制列表（tcp-wrappers）
- 默认端口是22

**注意**: 服务器配置文件不是 "/etc/ssh/ssh_config"

## 修改默认访问端口

### 修改配置文件
 
	[root@server.com]#vim /etc/ssh/sshd_config
 
修改 port 参数为:

	Port 60128
 
## 设置Iptables

设置防火墙的时候，务必确认当前ssh端口可以登录，否则会造成ssh无法登录。
 
	[root@server.com]# vim /etc/sysconfig/iptables
 
添加如下规则:
 
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 60128 -j ACCEPT
 
重启Iptables，然后查看结果:
 
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

 
## 禁止 root 登录

在 /etc/ssh/sshd_config 里找到关键词PermitRootLogin,修改为 "no"

	PermitRootLogin no
 
## 禁止 Protocol 1

在 /etc/ssh/sshd_config 里找到 

	# Protocol 2,1

修改为:

	Protocol 2
 
## 使用密钥登录

这里需要客户端，跟服务端两个部分进行设置与测试.

### 客户端:创建公密钥

First, create a public/private key pair on the client that you will use to connect to the server:
 
	[edwin@client]$ ssh-keygen -t rsa
 
This will create two files in your (hidden) ~/.ssh directory called id_rsa and id_rsa.pub. id_rsa is your private key and id_rsa.pub is your public key.
Now set permissions on your private key:
 
	[edwin@client]$ chmod 700 ~/.ssh
	[edwin@client]$ chmod 600 ~/.ssh/id_rsa 
 
### 服务端:设置authorized_keys

Copy the public key (id_rsa.pub) to the server and install it to the authorized_keys list:
 
	[root@server.com]# cat id_rsa.pub >> ~/.ssh/authorized_keys
 
Note: once you have imported the public key, you can delete it from the server.

and finally set file permissions on the server:
 
	[root@server.com]# chmod 700 ~/.ssh
	[root@server.com]# chmod 600 ~/.ssh/authorized_keys
 
The above permissions are required if StrictModes is set to yes in /etc/ssh/sshd_config (the default).

### 服务端:设置sshd_config
 
禁止密码登录

	PasswordAuthentication no
 
### 重启sshd
 
	[root@server.com]# /etc/rc.d/init.d/sshd restart
 
### 客户端测试
 
	[edwin@client]$ ssh root@server.com -p 60128
