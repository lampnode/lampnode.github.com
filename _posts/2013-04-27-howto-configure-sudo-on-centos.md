---
layout: post
title: "如何在CentOS上配置sudo"
tagline: "Howto configure sudo on CentOS"
description: ""
category: Linux
tags: [ Linux, CentOs ]
---
{% include JB/setup %}

在linux系统中，由于root的权限过大，一般情况都不使用它。只有在一些特殊情况下才采用登录root执行管理任务，一般情况下临时使用root权限多采用su和sudo命令。
Sudo是一款开源安全工具，它能允许管理员给予某些用户或组以作为root用户或其他用户从而运行特定命令的权利。这个软件还能记录下特定系统用户的命令和参数。

## 特点

- 命令记录: 记录命令和参数。该功能用于跟踪用户输入的命令，尤其适合于进行系统审计。因为sudo 会记录下所有作为root用户(或者规定的其他用户)的命令，所以许多管理员经常用它来替代root shell，以便记录下自己使用的命令，这不仅能增进系统安全，还能用来进行故障检修。
- 命令限制:限定用户或者用户组能够使用的命令。
- 票据式系统:票据式系统通过创建票据对登录sudo施行时间限制，在给定时间内票据是有效的。每个新命令都刷新这个票据时间。缺省是5分钟

## 查看sudo是否安装:

	[root@localhost ~]#rpm -qa|grep sudo
	sudo-1.7.4p5-13.el6_3.x86_64

## 设置步骤

### Step1: 使用visudo修改sudo的配置文件

	[root@localhost ~]# visudo

#### root权限转移用户

在文件的末尾加上

	# For user can use all root privilege
 	cent   		 ALL=(ALL)      ALL
	edwin            ALL=(ALL)      NOPASSWD: ALL


其中，cent用户可以使用sudo执行root命令，需要输入密码; edwin 则不需要输入密码。

#### 设置一些命令不允许。

	# Add aliase for the kind of shutdown commands
	Cmnd_Alias SHUTDOWN = /sbin/halt, /sbin/shutdown, \
	/sbin/poweroff, /sbin/reboot, /sbin/init

	# add commands in aliase 'SHUTDOWN' are not allowed 
	cent	ALL=(ALL)	ALL, !SHUTDOWN

#### 一些以root权限的命令传送到用户组

	# Add aliase for the kind of user management comamnds
	Cmnd_Alias USERMGR = /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod, \
	/usr/bin/passwd
	
	# add at the last
	%usermgr	ALL=(ALL)	USERMGR


#### 转移指定命令给指定用户

在root ALL=(ALL) ALL 之后增加或者行尾增加如下内容:

	# add at the last
	 cent    ALL=(ALL) /usr/sbin/visudo
	fedora  ALL=(ALL) /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod, /usr/bin/passwd
	ubuntu  ALL=(ALL) /bin/vi

### 重启服务器

	[root@localhost ~]# shutdown -r now

### 测试

	edwin@localhost ~]$ cd /home/
	edwin@localhost home]$ ls
	lice  edwin  jack  jeffrey  tomson
	[edwin@localhost home]$ sudo cd jeffrey/
	sudo: cd: command not found
	[edwin@localhost home]$ rm -rf jeffrey/
	rm: cannot remove 'jeffrey': Permission denied
	[edwin@localhost home]$ sudo rm -rf jeffrey
