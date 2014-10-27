---
layout: post
title: "MySQL:Configutaion Optimization and Tuning Guide"
tagline: "MySQL:Configutaion Optimization and Tuning Guide"
description: ""
category: MySQL
tags: [ MySQL ]
---
{% include JB/setup %}

Mysql is one of the most used databases. The purpose of this article is how to optimize mysql server.

## Check information about current values

We can obtain information about the currently set values by running the following command  when connected to a MySQL server:

	SHOW VARIABLES;
	SHOW STATUS;


## How to hange the Mysql configuration

The configuation of mysql is stored in the my.cnf file. In general, you will find config file at "/etc/my.cnf". When the file is changed, you should restart the mysql server to reload the changes.

## Detail of configuraion

### General

#### skips

	skip-external-locking

On, old version:

        skip-locking

if you used this param on the newly version, the following warnning message will show in your mysql log:

	[Warning] ‘–skip-locking’ is deprecated and will be removed in a future release. Please use ‘–skip-external-locking’ instead.


#### name-resolve


        skip-name-resolve

#### Max connections

If you are facing the "Too many connections" error, max_connections is to low.

        max_connections = 512

max_connect_errors 默认为10，意义是A主机连接mysql服务器出现10次或更多连接错误，就会出现屏蔽掉A发起的任何连接，也就是A服务器不能再访问mysql了。

可以有效的防止网络攻击，但是如果我们的程序连接串有误造成的站点服务器无法访问mysql的现象，就必须使用flush hosts或者重启mysql解决此的问题

        max_connect_errors = 100

#### 修改线程数

CPU逻辑线程数的2-4倍，我们搭载的CPU为8核心 × 2

        thread_concurrency = 16

### For innodb

In InnoDB, having a long PRIMARY KEY wastes a lot of disk space because its value must be stored with every secondary index record.

	innodb_buffer_pool_size = 378M  #default value (128M)
	innodb_log_file_size = 64M      #default value is 48MB
	innodb_file_per_table=1		#is enabled (=1)
	innodb_flush_method = O_DIRECT	#

### For myISAM


#### key_buffer_size

Index blocks for MyISAM tables are buffered and are shared by all threads. key_buffer_size is the size of the buffer used for index blocks. 

Note: MyISAM itself caches only indexes, not data. So if possible the value of this setting should cover the size of all your indexes.

You should set it up to be 25% to 50% of available memory. 

        key_buffer_size = 256M #256M for 4G ROM
	
### table_cache

所有线程打开的表的数目。增大该值可以增加mysqld需要的文件描述符的数量。默认值是64.

	table_cache = 128K

### sort_buffer_size

Sort_Buffer_Size是一个connection级参数，在每个connection第一次需要使用这个buffer的时候，一次性分配设置的内存。并不是越大越好，由于是connection级的参数，过大的设置+高并发可能会耗尽系统内存资源。

NOTE: 这个参数修改需谨慎，建议不做修改。

### read buffer size

读查询操作所能使用的缓冲区大小。和sort_buffer_size一样，该参数对应的分配内存也是每连接独享。

        read_buffer_size = 4M #Default is 64K

### max_allowed_packet

客户端和服务器均有自己的max_allowed_packet变量，因此，如你打算处理大的信息包，必须增加客户端和服务器上的该变量。一般情况下，服务器默认max-allowed-packet为1MB

	max_allowed_packet = 4M #Default is 1048576(1M)

### thread stack

	thread_stack = 256K	



### query cache

Query cache is used to chace SELECT results and later return them without actural executing the same query once again. If you have log of identical queries and rarely changing table, haveing cache enabled the result in significant speed improments.

        query_cache_type=1 #1=enabled
        query_cache_size=512M 
        query_cache_limit = 128M #Default is 1M


#### tmp table size

The maximum size of internal in-memory temporary tables.  if you do many advanced GROUP BY queries and you have lots of memory. 

        tmp_table_size=256M #Default is 16M, Optimize range is 64-256M
 

#### max heap table size

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. This variable is also used in conjunction with tmp_table_size to limit the size of internal in-memory tables.

        max_heap_table_size = 32M


### LOGGING

	slow-query-log= 1	#1 is enable
	slow_query_log_file=/var/log/mysql.slow.log
	log-queries-not-using-indexes
	long_query_time = 10 #5-10 is better

