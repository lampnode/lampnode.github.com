---
layout: post
title: "Common Useful SQL Commands"
tagline: "Common Useful SQL Commands"
description: ""
category: MySQL
tags: [ SQL, MySQL ]
---
{% include JB/setup %}

Here are examples of how to solve some common problems with MySQL.


## For Database

### Show all databases;

	mysql> SHOW DATABASES;

#### Add new database

	mysql> CREATE DATABASE mydatabase;

Or, custom character-set

	mysql>CREATE DATABASE `mydatabase` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci

### Use specific database

	mysql> USE mydatabase;

### Delete database

	mysql> DROP DATABASE mydatabase;

## For tables

### Add a new table


	CREATE TABLE if not exists database_name.table_name (fieldname1 type1, fieldname2, type2 ...)

or

	CREATE TABLE if not exists db.people (First text, Last text, Age int, pk int not null auto_increment primary key)


### list all of tables

	mysql> SHOW TABLES;

###  provides information about a table 

	mysql> DESC mytable;

or

	mysql> SHOW COLUMNS FROM mytable;

or 

	mysql> SHOW CREATE TABLE mysql name;

### Rename a table

	mysql> RENAME TABLE OLD_NAME TO NEW_NAME;

or

	mysql> ALTER TABLE OLD_NAME rename as NEW_NAME;

### Drop a table

	mysql> DROP TABLE mytable;

### Truncate a table

	TRUNCATE TABLE database_name.table_name

### Duplicate a table

	CREATE TABLE database_name.copy_name LIKE database_name.original_name

	INSERT database_name.copy_name SELECT * FROM database_name.original_name


## For column

#### To update a column

	mysql> UPDATE mytable SET mycolumn="newinfo" WHERE mycolumn="oldinfo";

#### To modify a column

	mysql> ALTER TABLE `ec_journal_info` CHANGE COLUMN `foo` `foo` varchar(50) character set utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '';

#### To drop a column

	ALTER TABLE database_name.table_name DROP COLUMN fieldname

## For rows

### To drop a row

	DELETE FROM database_name.table_name WHERE (record identifiers)


## For charset

### Table level

#### For specific table

Example: To check the table named systems_user from the database named cms

{% highlight bash %}
mysql>show table status from cms like '%systems_user%'; 
+-----------------+--------+---------+------------+----+-----------------+-----------+
| Name            | Engine | Version | Row_format | Rows  | Collation    | ...       |
+-----------------+--------+---------+------------+----+-----------------+-----------+
| systems_user    | MyISAM |      10 | Dynamic    | 5  | utf8_general_ci | ...       |   
+-----------------+--------+---------+------------+----+-----------------+-----------+
1 row in set
{% endhighlight %}

#### For all of table

{% highlight bash %}
mysql> SELECT table_name,Engine,table_rows,Avg_row_length,Data_length,
  	Index_length,Auto_increment,table_collation
	FROM information_schema.tables
	WHERE Table_Schema='myDatabase';
+--------------------+--------+------------+----------------+-------------+--------------+----------------+-----------------+
| table_name         | Engine | table_rows | Avg_row_length | Data_length | Index_length | Auto_increment | table_collation |
+--------------------+--------+------------+----------------+-------------+--------------+----------------+-----------------+
| archives_articles  | MyISAM |         20 |           1113 |       22260 |         3072 |            133 | utf8_general_ci |
| archives_catalog   | MyISAM |         11 |             29 |         328 |         3072 |            125 | utf8_general_ci |
| config_viewparams  | MyISAM |          1 |             24 |          24 |         2048 | NULL           | utf8_general_ci |
| navigation_item    | MyISAM |          8 |             21 |         172 |         3072 |            140 | utf8_general_ci |
| page_article       | MyISAM |          5 |             39 |         196 |         2048 |             11 | utf8_general_ci |
| page_catalog       | MyISAM |          1 |             68 |          68 |         2048 |              8 | utf8_general_ci |
| systems_log        | MyISAM |          1 |             56 |          56 |         2048 |              6 | utf8_general_ci |
| systems_permission | MyISAM |          0 |              0 |           0 |         1024 |              1 | utf8_general_ci |
| systems_role       | MyISAM |          4 |             29 |         116 |         2048 | NULL           | utf8_general_ci |
| systems_user       | MyISAM |          5 |            177 |         888 |         4096 |              6 | utf8_general_ci |
+--------------------+--------+------------+----------------+-------------+--------------+----------------+-----------------+
10 rows in set 
{% endhighlight %}

### Column level

{% highlight bash %}

mysql> show full columns from ec_systems_user;
+--------------+------------------+-----------------+-------------------------+
| Field        | Type             | Collation       | .......                 |
+--------------+------------------+-------------------------------------------+
| userId       | int(11) unsigned |                 | .......                 |
| email        | varchar(50)      | utf8_general_ci | .......                 |
| password     | varchar(255)     | utf8_general_ci | .......                 |
| username     | varchar(50)      | utf8_general_ci | .......                 |
| roleName     | varchar(20)      | utf8_general_ci | .......                 | 
| isLocked     | int(1)           | NULL            | .......                 |
| registerTime | datetime         | NULL            | .......                 |
+--------------+------------------+-----------------+------+-----+---------+--+
7 rows in set

{% endhighlight %}

### modify the charset

	ALTER TABLE db_name.table_name CHARACTER SET utf8 COLLATE utf8_unicode_ci

