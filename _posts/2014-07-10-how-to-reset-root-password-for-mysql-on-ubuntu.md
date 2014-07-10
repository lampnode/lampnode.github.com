---
layout: post
title: "How to reset root password for mysql on Ubuntu"
tagline: "How to reset root password for mysql on Ubuntu"
description: ""
category: MySQL 
tags: [ Ubuntu, MySQL ]
---
{% include JB/setup %}

This article describes how to reset root password for mysql service on Ubuntu.

## Steps

### Edit my.cnf

To open the "/etc/mysql/my.cnf"

	$sudo vim /etc/mysql/my.cnf
	
and add the following line in section named "[mysqld]"

	skip-grant-tables

Then,to restart mysql service

	$sudo service mysql restart  

### Reset root passwd

Let`s login mysql with empty passwd, and update the roots` password.

	$mysql -u root
	mysql> use mysql;
	mysql> update user set password=PASSWORD("new_pass") where user='root';
	mysql> exit;

And, open the configuration file:

	$sudo vim /etc/mysql/my.cnf

Then,comment out or delete the line of "skip-grant-tables".

	#skip-grant-tables
 

### Restart mysql

	$sudo service mysql restart

Now, you should use your "new_pass" login mysql.

	$mysql -uroot -pnew_pass
	Welcome to the MySQL monitor.  Commands end with ; or \g.  
	mysql> 
