---
layout: post
title: "MySQL error 1146: table doesn't exist when doing backup"
tagline: "MySQL error 1146: table doesn't exist when doing backup"
description: ""
category: MySQL 
tags: [ Linux, MySQL ]
---
{% include JB/setup %}

When running mysqldump to back up a database, There is an error like below:

    mysqldump: Got error: 1146: Table `dbName.errorTableName` doesn`t exist when using LOCK TABLES

## Error Checking

To make sure that the table does exist and there`s no issues, use  mysqlcheck:

	$mysqlcheck -u root -p dbName

if you receive something like below:

	dbName.errorTableName
	Error: Table `dbName.errorTableName` doesn`t exist
	status: Operation failed

You should try the following solution.

## Solution

You should simply drop the error table in order to resolve this error by doing the following commands:

	mysql -u mysql_user -p
	mysql> use database_name
	mysql> show tables;
	mysql> drop table table_name;
	mysql> quit


