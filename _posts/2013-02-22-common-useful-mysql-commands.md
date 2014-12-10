---
layout: post
title: "Common Useful MySQL command-line tools"
tagline: "Common Useful MySQL Commands"
description: ""
category: MySQL
tags: [MySQL]
---
{% include JB/setup %}

Here are examples of how to solve some common problems with MySQL.

## Requirement

* CentOs 5.x 6.x/Ubuntu 8.x or later
* MySQL and MySQL-server has been installed on system
* DBA can access mySql server

## To login

	$mysql -h hostname -u root -p

## Importing/export data

### To import sql file to specific database:

	$mysql -u USERNAME -p --default-character-set=utf8 USER_DATABASE < backup.sql

Example:

	mysql -u root --default-character-set=utf8 shop < backup.sql

Note:

* --default-character-set=utf8:encoding
* USER_DATABASE:specific database   
* USERNAME:the admin for the database 

### To export data to sql file:

#### To export from specific database:

	$mysqldump -u root  --add-drop-table --extended-insert=false --default-character-set=utf8 DTATBASE_NAME > backup.sql

or
	$mysqldump -u root  --add-drop-table --extended-insert=false \
	--default-character-set=utf8 DTATBASE_NAME \
	| gzip > DTATBASE_NAME.$(date -d today +"%Y-%m-%d").sql.gz

Note：

-  --add-drop-table
-  --extended-insert=false
-  --default-character-set=utf8

#### To dump all databases

	$mysqldump -u root -p --all-databases > alldatabases.sql

or

	$mysqldump -u root -p --all-databases | gzip > databasebackup.sql.gz


Or, you should use shell script to backup database, see <a href="/MySQL/mysql-automatic-backup-script">Mysql automatic backup script</a>

#### To dump only specific tables from a database

	$mysqldump DTATBASE_NAME TABLE_1 TABLE_2 TABLE_3 > dump.sql

## User management

### List users

	mysql> SELECT * FROM mysql.user;

### Delete the Null user

	mysql> DELETE FROM mysql.user WHERE user = ' ';

### To delete all of users except root

	mysql> DELETE FROM mysql.user WHERE NOT (host="localhost" AND user="root");

### Rename the root

	mysql> UPDATE mysql.user SET user="mydbadmin" WHERE user="root";

### Add a new DBA

#### Do not specify a database

	mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

#### To specify a database

	mysql> GRANT ALL PRIVILEGES ON mydatabase.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

### Add a new admin to specific database

#### The database name does not contain  "_"

	mysql>GRANT ALL PRIVILEGES ON `YOURDB`.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

#### The database name contain "_"

	mysql>GRANT ALL PRIVILEGES ON `YOUR\_DB`.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

### Add a new normal user to specific database

##### The database name do not contain "_"

	mysql>GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON YOURDB.* TO 'NEW_USER'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

##### the database name contain "_"

	mysql>GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON `YOUR\_DB`.* TO 'NEW_USER1'@'localhost' IDENTIFIED BY 'NEW_PASSWD_TO_USER';

### To update passwd

	mysql> UPDATE mysql.user SET password=oldpass("newpass") WHERE User='username';

### To delete user

	mysql>DELETE FROM mysql.user WHERE user="username";
	mysql>DELETE FROM mysql.user where User='NEW_USER' and Host='localhost';

### Check the privileges

	mysql>show grants for 'root'@'localhost';
