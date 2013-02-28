---
layout: post
title: "如何在Linux上安装Rsync"
tagline: "How to Setup Rsync on Linux"
description: ""
category: Linux 
tags: [ Linux ]
---
{% include JB/setup %}

## 关于rsync

rsync是类unix系统下的数据镜像备份工具。它的特性如下：

* 可以镜像保存整个目录树和文件系统。
* 可以很容易做到保持原来文件的权限、时间、软硬链接等等。
* 无须特殊权限即可安装。
* 快速：第一次同步时 rsync 会复制全部内容，但在下一次只传输修改过的文件。rsync 在传输数据的过程中可以实行压缩及解压缩操作，因此可以使用更少的带宽。
* 安全：可以使用scp、ssh等方式来传输文件，当然也可以通过直接的socket连接。
* 支持匿名传输，以方便进行网站镜象。

## 环境要求

* 服务端主机 192.168.1.105 提供镜像服务
* 客户端主机 192.168.1.100 获取镜像内容

## 安装
### 服务端主机配置
#### 安装 xinedtd rsync
	
	[root@server ~]# yum -y install xinetd  rsync

#### 设置xinetd

修改 "disable = yes" to "disable = no" 在/etc/xinetd.d/rsync

	[root@server ~]# vi /etc/xinetd.d/rsync

修改该文件:

	service rsync
	{
	disable = yes
	socket_type = stream
	wait = no
	user = root
	server = /usr/bin/rsync
	server_args = –daemon
	log_on_failure += USERID
	}

#### 重启 xinetd

	[root@server ~]#  /etc/init.d/xinetd start

#### 设置防火墙  iptables (开放 873)

rsync默认使用的是873端口，需要设置防火墙

	[root@server ~]#  telnet 127.0.0.1 873
	Trying 127.0.0.1...
	telnet: connect to address 127.0.0.1: Connection refused
	[root@server ~]# iptables -A INPUT -s 192.168.0.0/255.255.255.0 -p tcp -m tcp --dport 873 -j ACCEPT
	[root@server ~]# iptables -A INPUT -p tcp -m tcp --dport 873 -j DROP

#### 设置 rsyncd.conf

	[root@server ~]# vi /etc/rsyncd.conf

设置样例如下:	
		[backup]
		path = /www
		auth users = admin
		uid = root
		gid = root
		secrets file = /etc/rsyncd.secrets
		read only = no
		list = yes

#### 设置 rsyncd.secrets

	[root@server ~]#  vi /etc/rsyncd.secrets

设置样例如下:		
		admin:1234 

#### 修改  rsynced.secrets的权限

	[root@server ~]# chown root:root /etc/rsyncd.secrets
	[root@server ~]# chmod 600 /etc/rsyncd.secrets


### 客户端设置

#### 安装rsync

	[root@client ~]# yum -y install rsync

#### 用法

#####  例子1
	[root@client ~]# rsync -avz admin@192.168.1.105::backup /www

##### 例子2

With delete(Warnin:When using this parameter, it is recommended to use absolute path
Specify the local directory path to prevent empty the current directory)
	
	[root@client ~]# rsync -avz --delete admin@192.168.1.105::backup /www

##### 联合SSH

参看[使用Rsync经SSH备份数据](/Linux/using-rsync-with-ssh-to-backup-data/) 
