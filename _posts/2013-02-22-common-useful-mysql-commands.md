---
layout: post
title: "常用的MySQL命令汇总"
tagline: "Common Useful MySQL Commands"
description: ""
category: MySQL
tags: [MySQL]
---
{% include JB/setup %}


## 系统要求

* CentOs 5.x 6.x
* Ubuntu 8.x or later

## 软件要求

1. MySQL and MySQL-server has been installed on system
2. DBA can access mySql server

## 用法

### 导入sql文件到指定数据库

	mysql -u USERNAME -p --default-character-set=utf8 USER_DATABASE < backup.sql

参数解析:

* --default-character-set=utf8 编码
* USER_DATABASE 指定数据库
* USERNAME 数据库管理员用户名

### 用户管理

#### 显示所有用户

	mysql> SELECT * FROM mysql.user;

#### 删除Null用户

	mysql> DELETE FROM mysql.user WHERE user = ' ';

#### 删除所有非ROOT用户

	mysql> DELETE FROM mysql.user WHERE NOT (host="localhost" AND user="root");

#### 修改数据库管理员用户名

	mysql> UPDATE mysql.user SET user="mydbadmin" WHERE user="root";

#### 创建一个新的DBA

不指定数据库

	mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

指定数据库

	mysql> GRANT ALL PRIVILEGES ON mydatabase.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

#### 创建一个高级用户给指定数据库

数据库名不含有"_"

	mysql>GRANT ALL PRIVILEGES ON `YOURDB`.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

数据库名含有"_"

	mysql>GRANT ALL PRIVILEGES ON `YOUR\_DB`.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

#### 授权一个普通用户给指定数据库

##### 数据库名不含有"_"

	mysql>GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON YOURDB.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';
	
##### 数据库名含有"_"
	
	mysql>GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON `YOUR\_DB`.* TO 'NEW_USER1'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

#### 修改用户密码

	mysql> UPDATE mysql.user SET password=oldpass("newpass") WHERE User='username';

### 删除数据库用户
	
	mysql>DELETE FROM mysql.user WHERE user="username";
	mysql>DELETE FROM mysql.user where User='NEW_USER' and Host='localhost';

### 查看权限 (privileges)
	mysql>show grants for 'root'@'localhost';

### 使用mysqldump备份数据库

#### 备份指定数据库到指定的(压缩)文件
	mysqldump -u root  --add-drop-table --extended-insert=false \
	--default-character-set=utf8 DTATBASE_NAME \
	| gzip > DTATBASE_NAME.$(date -d today +"%Y-%m-%d").sql.gz

参数解析：

-  --add-drop-table 添加删除数据库表的语句
-  --extended-insert=false 使用完整INSERT语句进行导出
-  --default-character-set=utf8 导出数据库编码设置

#### 备份所有数据库
 
	mysqldump -u root -p --all-databases > alldatabases.sql
	mysqldump -u root -p--all-databases | gzip > databasebackup.sql.gz


或者使用shell脚本将所有数据库备份到指定文件夹，参看<a href="/MySQL/mysql-automatic-backup-script">Mysql自动备份脚本</a>
