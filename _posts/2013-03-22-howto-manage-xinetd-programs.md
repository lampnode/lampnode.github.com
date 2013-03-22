---
layout: post
title: "如何管理xinetd的服务 "
tagline: "HowTo Manage xinetd Programs"
description: ""
category: Linux 
tags: [ Linux ]
---
{% include JB/setup %}

## About xinetd

xinetd是一个运行于类Unix操作系统的开放源代码的超级服务器（Super-server）守护进程。它的功能是管理网络相关的服务。由于其较高的安全性，xinetd开始逐渐取代inetd。


### 系统服务介绍
linux服务(daemon):有stand alone(服务可单独启动)和super daemon(通过xinetd统一管理的服务)。其中,xinetd监听来自网络>的请求，从而启动相应的服务。它可以用来启动使用特权端口和非特权端口的服务.

#### Stand alone daemon

启动的脚本放置在/etc/init.d/这个目录中,

##### 启动规则一：

	/etc/init.d/cmd {start|stop|status|restart|condrestart}

##### 启动规则二：

	service rsync start

	特点：daemon常驻内存，响应快，无服务启动时间。
 
 
#### Super daemon

配置文件/etc/xinetd.conf,个别daemon配置文件则放在/etc/xinetd.d/*内，启动规则统一为：

/etc/init.d/xinetd restart.
	
特点：由super daemon统一管理，仅当客户请求时，super daemon才唤醒相应的服务。
	
### 常用命令：

#### 查看super daemon所管理的服务有哪些启动

{% highlight bash %}
[root@server]# grep -i 'disable' /etc/xinetd.d/*
/etc/xinetd.d/chargen-dgram:	disable		= yes
/etc/xinetd.d/chargen-stream:	disable		= yes
/etc/xinetd.d/daytime-dgram:	disable		= yes
/etc/xinetd.d/daytime-stream:	disable		= yes
/etc/xinetd.d/discard-dgram:	disable		= yes
/etc/xinetd.d/discard-stream:	disable		= yes
/etc/xinetd.d/echo-dgram:	disable		= yes
/etc/xinetd.d/echo-stream:	disable		= yes
/etc/xinetd.d/eklogin:	disable		= yes
/etc/xinetd.d/ekrb5-telnet:	disable		= yes
/etc/xinetd.d/gssftp:	disable		= yes
/etc/xinetd.d/klogin:	disable		= yes
/etc/xinetd.d/krb5-telnet:	disable		= yes
/etc/xinetd.d/kshell:	disable		= yes
/etc/xinetd.d/rsync:	disable	= no
/etc/xinetd.d/tcpmux-server:	disable		= yes
/etc/xinetd.d/time-dgram:	disable		= yes
/etc/xinetd.d/time-stream:	disable		= yes
{% endhighlight %}

#### 查看rsync占用的端口号

	[root@backupcat ~]# grep 'rsync' /etc/services 
	rsync		873/tcp				# rsync
	rsync		873/udp				# rsync

#### 查看873端口是否正在监听

	[root@server ~]# grep 'rsync' /etc/services
	rsync		873/tcp				# rsync
	rsync		873/udp				# rsync

