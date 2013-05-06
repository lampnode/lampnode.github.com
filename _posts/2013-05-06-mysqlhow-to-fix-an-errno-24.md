---
layout: post
title: "MySQL:如何修复报错信息(Errno: 24)"
tagline: "MySQL:How to Fix an (Errno: 24)"
description: ""
category: MySQL
tags: [ MySQL ]
---
{% include JB/setup %}

当创建一大量表的时侯，MySQL可能会有如下类型的错误

	[ERROR] /usr/sbin/mysqld: Can't open file: './database/table.frm' (errno: 24)


errno: 24 simply means that too many files are open for the given process. There is a read-only mysql variable called open_files_limit that will show how many open files are allowed by the mysqld:

## 关于Errno：24

这个报错出现意味着对于给定的进程中打开文件过多。有一个MySQL变量称为open_files_limit，主要来设置相关的参数。可使用如下命令查看当前设置:

	SHOW VARIABLES LIKE 'open%'

系统默认的限制比较低，一般是1024.

## 处理方法

修改配置文件/etc/my.cnf,增加如下内容:

	[mysqld]
	......
	open_files_limit = 100000
	......

然后，重启mysqld服务:

	sudo /etc/init.d/mysql restart

