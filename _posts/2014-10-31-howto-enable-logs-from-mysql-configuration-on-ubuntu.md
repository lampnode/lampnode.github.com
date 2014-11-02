---
layout: post
title: "Howto enable logs from MySQL configuration On Ubuntu"
tagline: "Howto enable logs from MySQL configuration On Ubuntu"
description: ""
category: MySQL 
tags: [ MySQL, Ubuntu ]
---
{% include JB/setup %}

The query profiling of MySQL server is a useful method when you want to analyze the database performance. This document will show you
some usefull query profiling technology on MySQL server. 


## Managing the configuration

Check out the configuration:

	mysql> show variables like '%log%';

Logging parameters are located under [mysqld] section in the my.cnf file.

	$sudo vim /etc/mysql/my.cnf

## Enable Logs from files

All log files are NOT enabled by default MySQL setup on Ubuntu. Default Debian setup sends Error log to syslog. The other log files are not enabled.

	# * Logging and Replication
	#
	# Both location gets rotated by the cronjob.
	# Be aware that this log type is a performance killer.
	# As of 5.1 you can enable the log at runtime!
	#general_log_file        = /var/log/mysql/mysql.log
	#general_log             = 1
	#
	# Error logging goes to syslog due to /etc/mysql/conf.d/mysqld_safe_syslog.cnf.
	#
	# Here you can see queries with especially long duration
	#log_slow_queries       = /var/log/mysql/mysql-slow.log
	#long_query_time = 2
	#log-queries-not-using-indexes
	#
	# The following can be used as easy to replay backup logs or for replication.
	# note: if you are setting up a replication slave, see README.Debian about
	#       other settings you may need to change.
	#server-id              = 1
	#log_bin                        = /var/log/mysql/mysql-bin.log
	expire_logs_days        = 10
	max_binlog_size         = 100M
	#binlog_do_db           = include_database_name
	#binlog_ignore_db       = include_database_name


### Error Log

Default Debian setup sends Error log to syslog. If you do not want the error log to the syslog.
You can comment the following lines in the file "/etc/mysql/conf.d/mysqld_safe_syslog.cnf"

	[mysqld_safe]
	syslog

Then, add in /etc/mysql/my.cnf the following lines:
 
	[mysqld_safe]
	log_error=/var/log/mysql/mysql_error.log
 
	[mysqld]
	log_error=/var/log/mysql/mysql_error.log


### General Query Log

To enable General Query Log, uncomment (or add) the relevant lines

	general_log_file        = /var/log/mysql/mysql.log
	general_log             = 1

### Slow Query Log

To enable Slow Query Log, uncomment (or add) the relevant lines

	log_slow_queries       = /var/log/mysql/mysql-slow.log
	long_query_time = 2
	log-queries-not-using-indexes
	
## Restart MySQL server after changes

	$sudo service mysql restart

## Enable logs at runtime

If you want to change the log configuration without restarting the server:

To enable logs at runtime, login to mysql client:

	$mysql -u root -p

	mysql> SET GLOBAL general_log = 'ON';
 	mysql> SET GLOBAL slow_query_log = 'ON';
	
To disable logs at runtime, login to mysql client:

        $mysql -u root -p
        
        mysql> SET GLOBAL general_log = 'OFF';
        mysql> SET GLOBAL slow_query_log = 'OFF';

## Display log results

	$sudo tail -f /path/to/your/log/file