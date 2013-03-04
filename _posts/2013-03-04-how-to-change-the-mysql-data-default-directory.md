---
layout: post
title: "如何改变MySQL数据的默认目录"
tagline: "How to change the MySQL data default directory"
description: ""
category: MySQL
tags: [ MySQL ]
---
{% include JB/setup %}

## 关于Mysql数据目录

Mysql数据目录是mysql数据库存储数据的位置，在Linux下，默认的一般是 /var/lib/mysql. 有时候需要改变这个默认配置.

## 处理方法

首先，使用Root用户登录系统，然后进行如下操作：

###  停止mysqld

	/etc/init.d/mysqld stop
 
### 将mysql数据目录移动到目标位置

例如，要移动到 /opt/mysql ，使用如下命令:

 
	mv /var/lib/mysql/ /opt/mysql
 
### 修改mysql的配置文件
 
	vim /etc/my.cnf
 
找到"datadir"  , 修改为新的"/opt/mysql",内容如下:

{% highlight bash %} 
[mysqld]
datadir=/opt/mysql #需要修改这个
socket=/opt/mysql/mysql.sock 
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
 
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
{% endhighlight %}
 
###  修改 /etc/init.d/mysqld

 	vim /etc/init.d/mysqld
 
修改如下部分:
 
	get_mysql_option mysqld datadir "/opt/mysql"
 
###  启动MySQL

	/etc/init.d/mysqld start
 

### 可选配置

#### PHP 找不到socket

如果PHP连接mysql的时候出现如下错误:

 
	can't connect to local MYSQL server through socket '/varlib/mysql/mysql.socket'
	You should use this command to fix this problem:

需要增加一个链接即可:
 
	mkdir /var/lib/mysql
	ln -s /opt/mysql/mysql.sock /var/lib/mysql/mysql.sock
	chown -R mysql:mysql /var/lib/mysql/
