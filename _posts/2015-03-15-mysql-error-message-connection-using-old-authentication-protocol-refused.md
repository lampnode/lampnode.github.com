---
layout: post
title: "Mysql Error Message: Connection using old authentication protocol refused"
tagline: "Mysql Error Message: Connection using old authentication protocol refused"
description: ""
category: mysql
tags: [ MySQL ]
---
{% include JB/setup %}



If you have the following error message when you used mysql client login to remove mysql server in command line, 

## Error messages

	Error: 2049 (CR_SECURE_AUTH) 

	Message: Connection using old (pre-4.1.1) authentication protocol refused (client option 'secure_auth' enabled) 

中文：
	
	错误：2049 (CR_SECURE_AUTH) 
	消息：拒绝使用旧密码加密（早于4.1.1）的连接请求（服务器开启了客户端'secure_auth'选项对于使用16位密码加密的账户禁止链接）。

## Checking

### Check the user table and configuration

	$mysql -u root -p
	mysql> use mysql;
	mysql> select * from user where user='xxxx';

The password encryption is 16 bit:

	1234fed5236b32a1

The param named "old_passwords" in your my.cnf. 

	old_passwords=1

### Fix it

###  configruation

To put a comment on the "old_passwords=1" entry in the configuration file.

	old_passwords=1
	
Then reboot the mysqld.

### Update all of passwords for users

	mysql> SET PASSWORD FOR 'webuser'@'%' = PASSWORD('123456')
	mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456')
	......
	mysql> flush PRIVILEGES;
	
Well done.


	

