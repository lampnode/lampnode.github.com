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
DenyHosts是Python语言写的一个程序，它会分析sshd的日志文件（/var/log/secure），当发现重 复的攻击时就会记录IP到/etc/hosts.deny文件，从而达到自动屏IP的功能。

DenyHosts官方网站为：http://denyhosts.sourceforge.net

## Tcp wrappers与SSHD

### Tcp wrappers工作机制

* 如果数据包有匹配的规则在/etc/hosts.allow,则此数据包可以通过，
* 如果没有匹配的规则在 /etc/hosts.allow中，则会继续检查hosts.deny,
* 如果有匹配的规则在 /etc/hosts.deny中，则会被拒绝。
            
最后，如果在 /etc/hosts.allow和/etc/hosts.deny中都没有被描述，则可以通过，能够被使用.注意：在/etc/hosts.allow和 /etc/hosts.deny中添加规则后，无需重启服务，规则可以即刻生效

### 测试SSH是否支持TCP Wrappers

用ldd进行测试即可：
        
{% highlight bash %}  

	[root@localhost ~]# ldd /usr/sbin/sshd
	linux-vdso.so.1 =>  (0x00007fffffdff000)
	libfipscheck.so.1 => /lib64/libfipscheck.so.1 (0x00007fa1359a2000)
	libwrap.so.0 => /lib64/libwrap.so.0 (0x00007fa135796000)
	libaudit.so.1 => /lib64/libaudit.so.1 (0x00007fa13557a000)
	libpam.so.0 => /lib64/libpam.so.0 (0x00007fa13536c000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fa135167000)
	libselinux.so.1 => /lib64/libselinux.so.1 (0x00007fa134f48000)
	libcrypto.so.10 => /usr/lib64/libcrypto.so.10 (0x00007fa134bae000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007fa1349aa000)
	libz.so.1 => /lib64/libz.so.1 (0x00007fa134794000)
	libnsl.so.1 => /lib64/libnsl.so.1 (0x00007fa13457b000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007fa134343000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007fa134129000)
	libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007fa133ee7000)
	libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007fa133c07000)
	libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007fa1339db000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007fa1337d7000)
	libnss3.so => /usr/lib64/libnss3.so (0x00007fa13349a000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fa133107000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003036c00000)
	libfreebl3.so => /lib64/libfreebl3.so (0x00007fa132ea4000)
	libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007fa132c99000)
	libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007fa132a96000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fa132878000)
	libnssutil3.so => /usr/lib64/libnssutil3.so (0x00007fa132652000)
	libplc4.so => /lib64/libplc4.so (0x00007fa13244d000)
	libplds4.so => /lib64/libplds4.so (0x00007fa132248000)
	libnspr4.so => /lib64/libnspr4.so (0x00007fa13200b000)

{% endhighlight %}

我们可以从中找到：libwrap.so.0 => /usr/lib/libwrap.so.0 (0x003d5000). 这一行，这说明我们的sshd是支持 tcp wrappers的
          
备注： 
* ldd 命令会把所指定的可执行模块的依赖(shared library dependencies)模块列表打印出来
* /usr/lib/libwrap.so.0这个库文件是tcp wrapper的库


## 安装

### 在CentOs YUM安装

CentOS 6默认源是没有DenyHosts安装包的, 所以我们需要添加fedora的软件库, 参看<a href="/Linux/how-to-enable-epel-repository-for-centos/">在CentOS上如何启 EPEL Repository</a>


现在就可以通过yum安装DenyHosts了:

        yum install denyhosts

安装完后DenyHosts会自动重启httpd同时DenyHosts也会自动运行.

## 黑名单与白名单

DenyHosts的黑名单为/etc/hosts.deny, 白名单/etc/hosts.allow.

## 深入配置

如果需要深入配置DenyHosts, 需要修改的文件为/etc/denyhosts.conf 修改完后需要重启DenyHosts才可以运行新的配置.
CentOS重启DenyHosts

	/etc/init.d/denyhosts restart

常用配置:

#### SECURE_LOG = /var/log/secure	 

ssh日志文件，用来提供给denyhosts做分析判断的数据源，根据该文件判断是否为非法IP

#### PURGE_DENY = 5m			 

表示过多久后清除已经禁止的IP，空表示永远不解禁

* 'm' = minutes        分钟
* 'h' = hours          小时
* 'd' = days           天
* 'w' = weeks          周
* 'y' = years          年

#### DENY_THRESHOLDS

允许非法用户，普通用户，管理员登录失败的次数 （对此3个值进行设置）

	DENY_THRESHOLD_INVALID = 5	表示允许无效用户登录失败的次数
	DENY_THRESHOLD_VALID = 10	#表示允许普通用户登录失败的次数
	DENY_THRESHOLD_ROOT = 5		#表示允许root用户登录失败的次数

* 非法用户： 用户名根本不存在的用户
* 普通用户： 用户名存在，非管理员(root)	

#### RESET_ON_SUCCESS = yes 		

如果一个ip登陆成功后，失败的登陆计数是否重置为0

#### AGE_RESET 	

	AGE_RESET_VALID=5d 		#用户的登录失败计数会在多久以后重置为0，(h表示小时，d表示天，m表示月，w表示周，y表示年)
	AGE_RESET_ROOT=25d
	AGE_RESET_RESTRICTED=25d
	AGE_RESET_INVALID=10d


## 测试

* 目标机器:192.168.0.8(Ubuntu) 已经安装了denyhosts
* 客户端机器:192.168.0.7(CentOS) 执行登录测试

### 在客户端尝试非法登录

使用一个不存在的用户,进行多次无效登录
{% highlight bash %}

[edwin@localhost ~]$ ssh tom@192.168.0.8
The authenticity of host '192.168.0.8 (192.168.0.8)' can't be established.
RSA key fingerprint is 38:41:2c:9e:20:13:39:ec:40:a5:b2:48:b9:72:d9:cb.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.0.8' (RSA) to the list of known hosts.
tom@192.168.0.8's password: 
Permission denied, please try again.
tom@192.168.0.8's password: 
Permission denied, please try again.
tom@192.168.0.8's password: 
Permission denied (publickey,password).

[edwin@localhost ~]$ ssh tom@192.168.0.8
tom@192.168.0.8's password: 
Permission denied, please try again.
tom@192.168.0.8's password: 
Permission denied, please try again.
tom@192.168.0.8's password: 
Permission denied (publickey,password).

.....
{% endhighlight %}

经过几次尝试后，目标机器开始拒绝访问:

{% highlight bash %}
[edwin@localhost ~]$ ssh tom@192.168.0.8
ssh_exchange_identification: Connection closed by remote host
{% endhighlight %}

### 查看目标机器日志

{% highlight bash %}
edwin@edwin-hxstongX:~$ sudo cat /var/log/denyhosts
2013-02-27 18:03:35,869 - denyhosts   : INFO     new denied hosts: ['192.168.0.7']
 {% endhighlight %}

