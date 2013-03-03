---
layout: post
title: "常用的SQL语句"
tagline: "Common Useful SQL Commands"
description: ""
category: MySQL
tags: [SQL]
---
{% include JB/setup %}


## 用法

### 数据库操作

####  显示所有数据库

	mysql> SHOW DATABASES;

#### 创建数据库


	mysql> CREATE DATABASE mydatabase;

Custom character-set

	mysql>CREATE DATABASE `mydatabase` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci
#### 使用指定数据库

	mysql> USE mydatabase;

#### 删除数据库

	mysql> DROP DATABASE mydatabase;

### 数据表操作

#### 创建一个表

	CREATE TABLE if not exists database_name.table_name (fieldname1 type1, fieldname2, type2 ...)

需要指定表中有哪些字段，以及他们持有什么样的数据。

	CREATE TABLE if not exists db.people (First text, Last text, Age int, pk int not null auto_increment primary key)


#### 显示当前数据库所有数据表

	mysql> SHOW TABLES;

#### 显示当前表的结构

	mysql> DESC mytable;

或者

	mysql> SHOW COLUMNS FROM mytable;

#### 重新命名数据库表

	mysql> RENAME TABLE OLD_NAME TO NEW_NAME;

或者

	mysql> ALTER TABLE OLD_NAME rename as NEW_NAME;

#### 删除一个表

	mysql> DROP TABLE mytable;

#### 清空一个表

	TRUNCATE TABLE database_name.table_name

#### 复制一个表

	CREATE TABLE database_name.copy_name LIKE database_name.original_name

	INSERT database_name.copy_name SELECT * FROM database_name.original_name

有许多复制的表的方法，但其中大多数是不完整的。上面的第一行复制的原始表的结构，第二行中的数据复制。其他复制方法可能无法复制的每一个细节。

### 数据操作

#### 修改表字段名

	mysql> UPDATE mytable SET mycolumn="newinfo" WHERE mycolumn="oldinfo";

#### 修改表字段

	ALTER TABLE db_name.ziptable CHANGE latitude latitude double

#### 删除一个表字段

	ALTER TABLE database_name.table_name DROP COLUMN fieldname

该字段以及相关数据将被一并删除

### 删除一条记录

	DELETE FROM database_name.table_name WHERE (record identifiers)

这将删除特定的记录从表中。要小心，到指定的记录要明确，以避免删除比你预计的更多的记录。如果每一条记录都有一个唯一的主键，使用它.

### 修改character set

	ALTER TABLE db_name.table_name CHARACTER SET utf8 COLLATE utf8_unicode_ci

	ALTER TABLE db_name.table_name CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci

使用第二个的时候需要确认有没有旧的和新的字符编码之间的冲突的可能性。
