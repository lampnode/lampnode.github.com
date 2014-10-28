---
layout: post
title: "To optimize the MySQL database through show status"
tagline: "To optimize the MySQL database through show status"
description: ""
category: mysql 
tags: [ MySQL ]
---
{% include JB/setup %}

Here are quick commands that are useful to check, optimize , enhance the performance and health of your MySQL 
systems.

## How to check variables and status on mysql

	mysql> show variables;
	
	mysql> show global status; 

## Detailed

### Slow queries

	
	mysql> show variables like '%slow%';
	+---------------------+-------------------------+
	| Variable_name       | Value                   |
	+---------------------+-------------------------+
	| log_slow_queries    | ON                      |
	| slow_launch_time    | 2                       |
	| slow_query_log      | ON                      |
	| slow_query_log_file | /var/log/mysql.slow.log |
	+---------------------+-------------------------+
	4 rows in set (0.00 sec)


	mysql> show global status like '%slow%'; 
	+---------------------+--------+
	| Variable_name       | Value  |
	+---------------------+--------+
	| Slow_launch_threads | 0      |
	| Slow_queries        | 116039 |
	+---------------------+--------+
	2 rows in set (0.00 sec)

Related my.cnf params:

	log-slow-queries=/var/log/slow-query.log           
	long_query_time=10                                                               
	log-queries-not-using-indexes


### Connections

	mysql> show variables like 'max_connections';  
	+-----------------+-------+
	| Variable_name   | Value |
	+-----------------+-------+
	| max_connections | 500   |
	+-----------------+-------+
	1 row in set (0.00 sec)

	mysql>  show global status like 'max_used_connections';  
	+----------------------+-------+
	| Variable_name        | Value |
	+----------------------+-------+
	| Max_used_connections | 30    |
	+----------------------+-------+


max_used_connections / max_connections * 100% = 6% (Better is < 85%)


### Key buffer size

	mysql>  show variables like 'key_buffer_size';  
	+-----------------+-----------+
	| Variable_name   | Value     |
	+-----------------+-----------+
	| key_buffer_size | 268435456 |
	+-----------------+-----------+
	1 row in set (0.00 sec)

	mysql> show global status like 'key_read%';  
	+-------------------+----------+
	| Variable_name     | Value    |
	+-------------------+----------+
	| Key_read_requests | 41828178 |
	| Key_reads         | 16055    |
	+-------------------+----------+
	2 rows in set (0.00 sec)
 

key_cache_miss_rate ＝ Key_reads / Key_read_requests * 100% = 0.038% ( 0.01 <  better < 0.1, if the key_cache_miss_rate is less than 0.01%, it allocates too much, you should reduce it )


### Key blocks

	mysql> show global status like 'key_blocks_u%';  
	+-------------------+--------+
	| Variable_name     | Value  |
	+-------------------+--------+
	| Key_blocks_unused | 198009 |
	| Key_blocks_used   | 16333  |
	+-------------------+--------+
	2 rows in set (0.00 sec)

Key_blocks_used / (Key_blocks_unused + Key_blocks_used) * 100% = 7.62% (< 80% is better )


### Create tmp file/tables

	mysql> show global status like 'created_tmp%'; 
	+-------------------------+--------+
	| Variable_name           | Value  |
	+-------------------------+--------+
	| Created_tmp_disk_tables | 370591 |
	| Created_tmp_files       | 149    |
	| Created_tmp_tables      | 378585 |
	+-------------------------+--------+
	3 rows in set (0.00 sec)

Created_tmp_disk_tables / Created_tmp_tables * 100% = 102.51% ( < 25 is better )


	mysql> show variables where Variable_name in ('tmp_table_size', 'max_heap_table_size'); 
	+---------------------+-----------+
	| Variable_name       | Value     |
	+---------------------+-----------+
	| max_heap_table_size | 16777216  |
	| tmp_table_size      | 268435456 |
	+---------------------+-----------+
	2 rows in set (0.00 sec)

You should add tmp_table_size. Related my.cnf params:

	tmp_table_size = 512M
	max_heap_table_size= 512M

### Open tables

	mysql> show global status like 'open%tables%'; 
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| Open_tables   | 1675  |
	| Opened_tables | 1682  |
	+---------------+-------+
	2 rows in set (0.00 sec)	


	mysql> show variables like '%table_open_cache%';  
	+------------------+--------+
	| Variable_name    | Value  |
	+------------------+--------+
	| table_open_cache | 131072 |
	+------------------+--------+
	1 row in set (0.00 sec)

Open_tables / Opened_tables * 100% = 99.58% ( > = 85% is better )
Open_tables / table_open_cache * 100% = 1.27% (<= 95% is better )


### Threads

	mysql> show global status like 'Thread%';  
	+-------------------+-------+
	| Variable_name     | Value |
	+-------------------+-------+
	| Threads_cached    | 0     |
	| Threads_connected | 2     |
	| Threads_created   | 60246 |
	| Threads_running   | 2     |
	+-------------------+-------+
	4 rows in set (0.00 sec) 


	mysql> show variables like 'thread_cache_size';  
	+-------------------+-------+
	| Variable_name     | Value |
	+-------------------+-------+
	| thread_cache_size | 0     |
	+-------------------+-------+
	1 row in set (0.00 sec)


If it is found the "Threads_created" value is too large, it showed that the mySQL server is constantly creating new processes(threads). A lot of system resources will also be occupied. You can improve the thread_cache_size value.

Add the following param to my.cnf in the mysqld section

	thread_cache_size = 64

### Query cache

	
	mysql> show global status like 'qcache%';
	+-------------------------+-----------+
	| Variable_name           | Value     |
	+-------------------------+-----------+
	| Qcache_free_blocks      | 14        |
	| Qcache_free_memory      | 536707904 |
	| Qcache_hits             | 157       |
	| Qcache_inserts          | 329       |
	| Qcache_lowmem_prunes    | 0         |
	| Qcache_not_cached       | 1         |
	| Qcache_queries_in_cache | 35        |
	| Qcache_total_blocks     | 102       |
	+-------------------------+-----------+
	8 rows in set (0.00 sec)

To be sure the  query cache is turned on. The query_cache_type variable should be set to ON, and the query_cache_size should be non-zero.

	mysql> show variables like 'query_cache%';  
	+------------------------------+-----------+
	| Variable_name                | Value     |
	+------------------------------+-----------+
	| query_cache_limit            | 2097152   |
	| query_cache_min_res_unit     | 4096      |
	| query_cache_size             | 536870912 |
	| query_cache_type             | ON        |
	| query_cache_wlock_invalidate | OFF       |
	+------------------------------+-----------+
	5 rows in set (0.00 sec)

#### Cache blocks

	Qcache_free_blocks / Qcache_total_blocks * 100%  = 13.72 % ( < 20% is better)

#### Cache used

To calculate the percentage used value for the query cache you can use the following formula

	(Query_cache_size – Qcache_free_memory) / query_cache_size * 100% = 0.03% 

 * If < 25%, you should reduce the query_cache_size.

 * If  >80%, and Qcache_lowmem_prunes > 50, your should improve the query_cache_size.

	
### Sort usage

	mysql>  show global status like 'sort%';  
	+-------------------+-------+
	| Variable_name     | Value |
	+-------------------+-------+
	| Sort_merge_passes | 5     |
	| Sort_range        | 1     |
	| Sort_rows         | 2446  |
	| Sort_scan         | 154   |
	+-------------------+-------+
	4 rows in set (0.00 sec)

### Open files

	mysql> show global status like 'open_files';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| Open_files    | 100   |
	+---------------+-------+
	1 row in set (0.00 sec)


	mysql> show variables like 'open_files_limit';  
	+------------------+--------+
	| Variable_name    | Value  |
	+------------------+--------+
	| open_files_limit | 262654 |
	+------------------+--------+
	1 row in set (0.00 sec)


Open_files / open_files_limit * 100% = 0.038 ( < = 75% is better)


### Table locks

	mysql> show global status like 'table_locks%';  
	+-----------------------+-------+
	| Variable_name         | Value |
	+-----------------------+-------+
	| Table_locks_immediate | 11790 |
	| Table_locks_waited    | 4     |
	+-----------------------+-------+
	2 rows in set (0.00 sec)

	
Table_locks_immediate / Table_locks_waited =  737 ( If > 5000, you should use INNODB.)

### handler reading

	mysql> show global status like 'handler_read%';  
	+-----------------------+------------+
	| Variable_name         | Value      |
	+-----------------------+------------+
	| Handler_read_first    | 4          |
	| Handler_read_key      | 553301     |
	| Handler_read_next     | 1013       |
	| Handler_read_prev     | 57595      |
	| Handler_read_rnd      | 1819       |
	| Handler_read_rnd_next | 3484095836 |
	+-----------------------+------------+
	6 rows in set (0.00 sec)

	mysql> show global status like 'com_select';  
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| Com_select    | 4628  |
	+---------------+-------+
	1 row in set (0.00 sec)


Handler_read_rnd_next / Com_select = 742829

If > 4000, you should improve the value of read_buffer_size( >= 8M, default is 8K )
