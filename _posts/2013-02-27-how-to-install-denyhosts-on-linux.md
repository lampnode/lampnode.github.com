---
layout: post
title: "如何在Linux上安装DenyHosts"
tagline: "How To Install DenyHosts on Linux"
description: ""
category: Linux
tags: [ Security ]
---
{% include JB/setup %}

## About DenyHosts

About DenyHosts
DenyHosts is a security tool written in python that monitors server access logs to prevent brute force attacks on a virtual server. The program works bybanning IP addresses that exceed a certain number of failed login attempts. 

## CentOs 6

### 安装

CentOS 6默认源是没有DenyHosts安装包的, 所以我们需要添加fedora的软件库, 参看<a href="/Linux/how-to-enable-epel-repository-for-centos/">在CentOS上如何启用 EPEL Repository</a>


现在就可以通过yum安装DenyHosts了:

	yum install denyhosts

安装完后DenyHosts会自动重启httpd同时DenyHosts也会自动运行.

### 黑名单与白名单

DenyHosts的黑名单为/etc/hosts.deny, 白名单/etc/hosts.allow.

### 深入配置

如果需要深入配置DenyHosts, 需要修改的文件为/etc/denyhosts.conf 修改完后需要重启DenyHosts才可以运行新的配置.
CentOS重启DenyHosts

	/etc/init.d/denyhosts restart

常用配置:

	SECURE_LOG = /var/log/secure	 #ssh日志文件，根据该文件判断是否为非法IP
	HOSTS_DENY = /etc/hosts.deny	 #控制用户登录的文件
	PURGE_DENY = 5m			 #表示过多久后清除已经禁止的IP，空表示永远不解禁
	BLOCK_SERVICE  = sshd		#表示禁止的服务名
	DENY_THRESHOLD_INVALID = 5	#表示允许无效用户登录失败的次数
	DENY_THRESHOLD_VALID = 10	#表示允许普通用户登录失败的次数
	DENY_THRESHOLD_ROOT = 5		#表示允许root用户登录失败的次数
	DAEMON_LOG = /var/log/denyhosts	#DenyHosts的日志文件
	RESET_ON_SUCCESS = yes 		#如果一个ip登陆成功后，失败的登陆计数是否重置为0
	AGE_RESET_VALID=5d 		#用户的登录失败计数会在多久以后重置为0，(h表示小时，d表示天，m表示月，w表示周，y表示年)
	AGE_RESET_ROOT=25d
	AGE_RESET_RESTRICTED=25d
	AGE_RESET_INVALID=10d

	ADMIN_EMAIL = root@localhost #管理员邮件地址,它会给管理员发邮件
	SMTP_HOST = localhost
	SMTP_PORT = 25
	SMTP_FROM = DenyHosts <nobody@localhost>
	SMTP_SUBJECT = DenyHosts Report



