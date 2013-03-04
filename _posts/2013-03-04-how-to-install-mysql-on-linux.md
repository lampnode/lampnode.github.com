---
layout: post
title: "在Linux上安装配置MySQL"
tagline: "How to install MySQL on Linux"
description: ""
category: MySQL
tags: [ MySQL Linux ]
---
{% include JB/setup %}

## 简介
MySQL是一个关系型数据库管理系统，由瑞典MySQL AB公司开发，目前属于Oracle公司。与其他的大型数据库例如Oracle、DB2、SQL Server等相比，MySQL自有它的不足之处，如规模小、功能有限（MySQL Cluster的功能和效率都相对比较差）等，但是这丝毫也没有减少它受欢迎的程度。对于一般的个人使用者和中小型企业来说，MySQL提供的功能已经绰绰有余，而且由于MySQL是开放源码软件，因此可以大大降低总体拥有成本。

目前Internet上流行的网站构架方式是LAMP（Linux+Apache+MySQL+PHP/Perl/Python)，即使用Linux作为操作系统，Apache作为Web服务器，MySQL作为数据库，PHP/Perl/Python作为服务器端脚本解释器。

## 安装

### 使用YUM安装（ CentOS 5.x/6.x ）

	[root@server /]# yum install mysql mysql-server php-mysql

### 启动mysql

	[root@server /]# service mysqld start

***首次启动，输入如下：***
{% highlight bash%}

Initializing MySQL database:  Installing MySQL system tables...
OK
Filling help tables...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:

/usr/bin/mysqladmin -u root password 'new-password'
/usr/bin/mysqladmin -u root -h robert.server.com password 'new-password'

Alternatively you can run:
/usr/bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:
cd /usr ; /usr/bin/mysqld_safe &amp;

You can test the MySQL daemon with mysql-test-run.pl
cd /usr/mysql-test ; perl mysql-test-run.pl

Please report any problems with the /usr/bin/mysqlbug script!

                                                           [  OK  ]
Starting mysqld:                                           [  OK  ]

{% endhighlight %}

首次启动显示的信息中，一个关键的提示就是需要设置数据库的root密码

### 设置root的密码

设置Root密码，可以使用两种方式，推荐使用第一种，我遇到过第一种失败的情况，这时候可以考虑第二种方法。

#### 使用命令行

使用命令行设置root的密码，必须保证mysql服务在运行中。如上提示，设置root密码的命令行格式如下: 

	[root@server]#mysqladmin -u root password 'newpassword'


注意提高密码的复杂度，例如: 
	
	[root@server]# mysqladmin -uroot password 'fu09wf((3'


####  使用MYSQL提供的shell

{% highlight bash %}
	[root@server /]# mysql
	Welcome to the MySQL monitor.  Commands end with ; or \g.
	Your MySQL connection id is 2
	Server version: 5.1.61 Source distribution

	Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

	Oracle is a registered trademark of Oracle Corporation and/or its
	affiliates. Other names may be trademarks of their respective
	owners.

	Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

	mysql>
{% endhighlight %}

提示，已经进入mysql提供的shell环境.使用如下命令，查看当前存在的数据库有那些。

{% highlight bash %}
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| test               |
+--------------------+
3 rows in set (0.03 sec)
{% endhighlight %}
默认情况下，mysql应该有如上3个数据库存在。


###### 查看用户密码情况

使用mysql数据库：
{% highlight bash %}
	mysql> use mysql
{% endhighlight %}

显示用户名，跟密码：
{% highlight bash %}
mysql> select user,host,password from user;
+------+-----------------------+----------+
| user | host                  | password |
+------+-----------------------+----------+
| root | localhost             |          |
| root | robert.server.com     |          |
| root | 127.0.0.1             |          |
|      | localhost             |          |
|      | robert.server.com     |          |
+------+-----------------------+----------+
5 rows in set (0.00 sec)
{% endhighlight %}

从输出信息可以看到，root用户的密码字段是空的。

###### 设置密码
{% highlight bash %}
mysql> set password for 'root'@'robert.server.com'= password ('centOs');
mysql> set password for 'root'@'localhost'= password ('centOs');
mysql> set password for 'root'@'127.0.0.1'= password ('centOs');
{% endhighlight %}

##### 验证密码是否设置成功

{% highlight bash %}
mysql> select user,host,password from user;
+------+-----------------------+-------------------------------------------+
| user | host                  | password                                  |
+------+-----------------------+-------------------------------------------+
| root | localhost             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | dbase1.broexperts.com | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | 127.0.0.1             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
|      | localhost             |                                           |
|      | dbase1.broexperts.com |                                           |
+------+-----------------------+-------------------------------------------+
5 rows in set (0.00 sec)
{% endhighlight %}

注意：通过显示，可以看到仍然有2个匿名用户没有密码。

##### 删除匿名用户

{% highlight  bash %}
mysql> DELETE FROM mysql.user WHERE user = '  ';
Query OK, 2 rows affected (0.00 sec)
{% endhighlight %}

##### 刷新MySQL的系统权限相关表
{% highlight bash %}
mysql>; flush privileges;
Query OK, 0 rows affected (0.00 sec)
{% endhighlight %}

再次验证
{% highlight bash %}
mysql> select user,host,password from user;
+------+-----------------------+-------------------------------------------+
| user | host                  | password                                  |
+------+-----------------------+-------------------------------------------+
| root | localhost             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | robert.server.com     | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | 127.0.0.1             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
+------+-----------------------+-------------------------------------------+
3 rows in set (0.00 sec)
{% endhighlight %}
只有密码用户存在。


### 设置系统启动选项


        [root@server ]# chkconfig –level 235 mysqld on

## 安装后配置

### 设置字符集 Character-set

#### 查看当前的Character-set
使用如下两条命令查看当前的字符集设置:

	mysql>show variables like 'character_set_%';
	mysql>show variables like 'collation_%';

#### 修改默认字符集

mysql的配置文件，在CentOS是放在/etc/目录下的:
	[root@server~]#vim /etc/my.cnf

在 [client] 部分增加如下设置

	default-character-set=utf8

在 [mysqld] 部分增加如下设置

	default-character-set=utf8

#### 重启
	
	[root@server /]# service mysqld restart

### 省略登录密码

在WEB管理账户的home目录下，增加一个.my.cnf的文件，设置如下内容:

{% highlight bash %}

#For ~/.my.cnf
[client]
pass=ROOT_PASSWD
user=root
[mysqldump]
pass=ROOT_PASSWD
user=root

{% endhighlight %}
修改.my.cnf的权限：

	[root@server~]#chmod 700 ~/.my.cnf

这样以来，在进入mysql的shell或者使用mysqldump命令的时候，就可以省略密码输入。
