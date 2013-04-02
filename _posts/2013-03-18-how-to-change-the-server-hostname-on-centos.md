---
layout: post
title: "在CentOs上如何修改 Hostname"
tagline: "How to Change the Server Hostname on CentOS"
description: ""
category: Linux 
tags: [Linux, CentOs ]
---
{% include JB/setup %}

主机的命名虽然不是什么大问题，不过还需要有些规律比较好，尤其是具有发信功能的生产主机。

## 方法1

使用"hostname"命令

在终端输入以下命令(Enter the following command into the console):

	hostname my.server.com

再次查看hostname，将发生变化。不过这种方法重启后会无效.
## 方法2

修改network配置文件


	vim /etc/sysconfig/network

修改HOSTNAME字段值

	HOSTNAME=some.servername.com

修改完后需要重启机器才能生效
