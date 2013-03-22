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
linux服务(daemon)有Stand alone daemon(服务可单独启动)和Super daemon(通过xinetd统一管理的服务)。其中,xinetd监听来自网络>的请求，从而启动相应的服务。它可以用来启动使用特权端口和非特权端口的服务.

#### Stand alone daemon

启动的脚本放置在/etc/init.d/这个目录中,

##### 启动规则一：

	/etc/init.d/cmd {start|stop|status|restart|condrestart}

##### 启动规则二：

	service rsync start

	特点：daemon常驻内存，响应快，无服务启动时间。
 
 
#### Super daemon

配置文件/etc/xinetd.conf,个别daemon配置文件则放在/etc/xinetd.d/*内，启动规则统一为：

	/etc/init.d/xinetd restart
	
特点：由super daemon统一管理，仅当客户请求时，super daemon才唤醒相应的服务。
详细资料可以参看[鳥哥的 Linux 私房菜:第十八章、認識系統服務 (daemons)](http://linux.vbird.org/linux_basic/0560daemons.php)
	
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

## 配置文件
### 配置文件位置

- /etc/xinetd.conf - 全局配置
- /etc/xinetd.d/ directory - 针对具体服务的配置

### 配置文件解析

{% highlight bash %}
[root@server ~]# vim /etc/xinetd.conf
defaults
{
	# 日志相关设置
        log_type        = SYSLOG daemon info  	
        log_on_failure  = HOST   	
        log_on_success  = PID HOST DURATION EXIT 	
	
	# 性能设置
        cps         = 50 10 #同一秒內的最大连接数 50 ，若超过暂停 10 秒
        instances   = 50    #同一服务的最大同时连接数
        per_source  = 10    #同一来源的客户端的最大连接数
	
	# 网络设置
        v6only          = no #禁止IPv6

	# 环境参数
        groups          = yes
        umask           = 002
}

includedir /etc/xinetd.d #引入更多设定
{% endhighlight %}

## 自定制服务

假设要增加一个自定义服务，名称为foo

	[root@server~]#vim /etc/xinetd.d/foo

增加如下内容:

{% highlight bash %}
service login
{
	socket_type = stream
	protocol = tcp
	wait = no
	user = root
	server = /usr/sbin/foo
	instances = 20
}
{% endhighlight %}

其中参数的意义:

- **socket_type:** 设定网路socket类型，stream 为联机机制较为可靠的 TCP 封包，若为 UDP 封包则使用 dgram 机制
- **protocol:** 设定协议类型,使用的网络协议，需参考 /etc/protocols 内的通讯协议，一般使用 tcp 或 udp
- **wait:**  Multi-threaded 或者 single-threaded设定,一般来说可以同时被启用，所以可以设定 wait = no 此外，一般 udp 设定为 yes 而 tcp 设定为 no。
- **server:** 指出这个服务的启动程序.例如 /usr/bin/rsync 为启动 rsync 服务的指令
- **user:** 执行该程序的用户.如果 xinetd 是以 root 的身份启动来管理的，那么这个项目可以设定为其他用户。此时这个 daemon 将会以此设定值指定的身份来启动该服务的程序.
