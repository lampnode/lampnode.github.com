---
layout: post
title: "如何在Linux上安装与配置 Logwatch"
tagline: "How to Installing and Configuring Logwatch on Linux"
description: ""
category: Linux
tags: [ Linux, CentOs]
---
{% include JB/setup %}

Logwatch是一款专门监测Linux日志文件的软件。安装以后只要稍微配置一下，就能每天将主机的log分析文件发送至指定的邮箱.

## 安装与配置

### CentOs

#### YUM安装

	yum install logwatch

#### 配置

	vi /usr/share/logwatch/default.conf/logwatch.conf

##### 发送邮件

查找 MailTo = ，然后改为你的实际Email地址，比如 
	
	MailTo = user@domain.com 


##### 设置详细程度

Detail = 是细节度，推荐 10 ，即最高。 

logwatch默认为每天执行一次（cron.daily）。

## 使用方法

手动执行logwatch的命令为： 

	logwatch --print

这条命令将会把昨天的日志信息简要的打印出来. 比如用户登录失败信息、SSH 登录信息、磁盘空间使用等.


直接指定邮件发送

	logwatch --range today --print --mailto yourmail@gmail.com


单独查看某个服务，比如 SSH 登录信息: 

	logwatch --service sshd --print
