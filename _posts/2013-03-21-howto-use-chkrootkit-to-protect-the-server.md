---
layout: post
title: "如何使用chkrootkit工具保护服务器"
tagline: "HowTo use chkrootkit to protect the server"
description: ""
category: Linux
tags: [ Linux, Security ]
---
{% include JB/setup %}

 在保护linux 服务器时除了Tripwire 这样强大工具外，还有一个简单又好用的工具–chkrootkit。chkrootkit 顾名思义是监测系统是否被安装了rootkit 的一个安全工具。

## 安装chkrootkit

	 yum install chkrootkit

## chkrootkit的应用

chkrootkit 的使用非常简单直接运行 chkrootkit 命令，然后会有如下输出
{% highlight bash %}
ROOTDIR is `/’
Checking `amd’… not found
Checking `basename’… not infected
Checking `biff’… not found
Checking `chfn’… not infected
Checking `chsh’… not infected
Checking `cron’… not infected
Checking `crontab’… not infected
Checking `date’… not infected
Checking `du’… not infected
Checking `dirname’… not infected
Checking `echo’… not infected
Checking `egrep’… not infected
Checking `env’… not infected
.
.
.
{% endhighlight %}

如果有rootkit会报'INFECTED', 以可以直接用：

	chkrootkit -n|grep 'INFECTED'
