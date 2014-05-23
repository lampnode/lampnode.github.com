---
layout: post
title: "Mysql automatic backup script"
tagline: "Mysql automatic backup script"
description: ""
category: MySQL
tags: [ MySQL, Linux ]
---
{% include JB/setup %}

There are many ways to complate the bakup task for mySQL database. If your database is small, use mysqldump is a good choice.

The mysqldump is a backup program originally written by Igor Romanenko. It can be used to dump a database or a collection of databases for backup. The dump 
typically contains SQL statements to create the table, populate it, or both.

## Features

- Implement a backup of all databases (not including database mysql)
- SQL files will be compressed in real time by gzip
- Support crond

## Usage

### Store your mysql password in .my.cnf

Store your password in an option file, you can list your password in the [client] and [mysqldump] section of the .my.cnf file in your home directory:

	[robert@server ~]$vim ~/.my.cnf

Content example:

{% highlight bash %}
[client]
pass=ROOT_PASSWD
user=root
[mysqldump]
pass=ROOT_PASSWD
user=root
{% endhighlight %}

*** NOTE ***: It will not work well if you do not quote your password when the password contains characters such as "=" or ";". The mysql will report the following error:

	MySQL ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)

To keep the password safe, the file should not be accessible to anyone but yourself. To ensure this, set the file access mode to 400 or 600. For example:

	[robert@server ~]$chmod 600 .my.cnf

### Setup bash script

#### Download the script

In order to facilitate the management, all the crond script are placed in a directory, such as:
	
	[robert@server ~]#cd ~
	[robert@server ~]#mkdir ~/crondScripts

Download and unzip the script file:

	[robert@server ~]# wget https://gist.github.com/lampnode/5113701/download -O mysql_backup_all.tar.gz
	[robert@server ~]# tar -xzvf mysql_backup_all.tar.gz

Find the script file in upzip directory, and move this script file to the "crondScripts" directory. 

#### setting params

##### EC_USER_DIR

To specify the backup destination directory, the default is "/opt/site-bak". Note this directory permissions.

## script content
 
<script src="https://gist.github.com/lampnode/5113701.js"></script>

## About mysqldump

mysqldump offer a lot of options, the options are often used in the following table:
　　
#### --add-drop-table

dd a DROP TABLE statement before each CREATE TABLE statement.

#### --add-locks

Surround each table dump with LOCK TABLES and UNLOCK TABLES statements. This results in faster inserts when the dump file is reloaded.

#### -c or - complete_insert

Use complete INSERT statements that include column names.

#### -f or -force 

continue even if an SQL error occurs during a table dump. One use for this option is to cause mysqldump to continue executing even when it 
encounters a view that has become invalid because the definition refers to a table that has been dropped. Without --force, 
mysqldump exits with an error message. With --force, mysqldump prints the error message, but it also writes an SQL comment 
containing the view definition to the dump output and continues executing.

　　
#### -l or -lock-tables 

For each dumped database, lock all tables to be dumped before dumping them. The tables are locked with READ LOCAL to permit concurrent 
inserts in the case of MyISAM tables. 
　　
　　
#### -d or -no-data 

Do not write any table row information (that is, do not dump table contents). This is useful if you want to dump only the CREATE TABLE statement for the table (for example, to create an empty copy of the table by loading the dump file).


