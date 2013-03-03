---
layout: post
title: "在Linux上安装配置MySQL"
tagline: "How to install MySQL on Linux"
description: ""
category: MySQL
tags: [ MySQL Linux ]
---
{% include JB/setup %}


## Installation

### Installation of MySql Server using yum.

	[root@server /]# yum install mysql mysql-server php-mysql

### Start mysql service.

	[root@server /]# service mysqld start

***Output***
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

You will notice here that when it starts the service for the first time, MySQL dumps some “todo” information on the screen which includes setting the Root password for MySQL.

### Setting The Root Password After MySQL Install

#### By command line

MySQL asks us to set the root password during first MySQL bootup.

Set MySQL Root Password: 

	mysqladmin -u root password ‘newpassword’

Where the first password is literally the word password and newpassword is the password you want to set for your MySQL server.

Example: 
	[root@server]# mysqladmin -uroot password fu09wf((3

The above example would set the password “fu09wf((3″ for the root user.



####  In mysql

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

Now we logged in to mysql.

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
Output show by default mysql creates 3 databases.
{% endhighlight %}


###### Select ‘mysql’ database

{% highlight bash %}
	mysql> use mysql
{% endhighlight %}

###### Show users & passwords
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

Output shows 5 users but if you look in the ‘password’ field its blank means passwords are undefined.

 

######  Set Passwords
{% highlight bash %}
mysql> set password for 'root'@'robert.server.com'= password ('centOs');
mysql> set password for 'root'@'localhost'= password ('centOs');
mysql> set password for 'root'@'127.0.0.1'= password ('centOs');
{% endhighlight %}

##### Verify changes

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

Note : According to output there is still two Anonymous users exist without passwords.

##### Delete anonymous Users

{% highlight  bash %}
mysql> DELETE FROM mysql.user WHERE user = '  ';
Query OK, 2 rows affected (0.00 sec)
{% endhighlight %}

##### Run ‘flush privileges’ command.
{% highlight bash %}
mysql>; flush privileges;
Query OK, 0 rows affected (0.00 sec)
{% endhighlight %}
verify changes
{% highlight bash %}
mysql> select user,host,password from user;
+------+-----------------------+-------------------------------------------+
| user | host                  | password                                  |
+------+-----------------------+-------------------------------------------+
| root | localhost             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | dbase1.broexperts.com | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
| root | 127.0.0.1             | *84BB5DF4823DA319BBF86C99624479A198E6EEE9 |
+------+-----------------------+-------------------------------------------+
3 rows in set (0.00 sec)
{% endhighlight %}
Now output shows we have 3 users and all secured with password.


### Configure MySQL To Start On System Restart/Boot

Add the MySQL service to our start up run levels. By default, if we were to restart the system at this stage, MySQL would not boot up with the system and we would have to manually start the service again.

        [root@server ]# chkconfig –level 235 mysqld on

This would cause the MySQL service to start up anytime the system enters runlevels 2,3 or 5. Since our system usually runs in runlevel 3 when first booted we know MySQL will start when the server restarts from now on.


## Post-Installation

### setup character-set

#### Check current character-set

	mysql>show variables like 'character_set_%';
	mysql>show variables like 'collation_%';

#### modify the default character-set

	vi /etc/my.cnf

Add the following on [client]

	default-character-set=utf8

Add the following on [mysqld]

	default-character-set=utf8

#### reboot the mysql
	
	[root@server /]# service mysqld restart

