---
layout: post
title: "在CentOs上如何修改 Hostname"
tagline: "How to Change the Server Hostname on CentOS"
description: ""
category: Linux 
tags: [Linux, CentOs ]
---
{% include JB/setup %}

## 方法1

使用 “Hostname command”.

Enter the following command into the console:

	hostname my.server.com

Once you enter the above command, the server hostname will be automatically changed.

## 方法2

修改network配置文件


	vim /etc/sysconfig/network

修改HOSTNAME字段值

	HOSTNAME=some.servername.com

修改完后需要重启机器才能生效
