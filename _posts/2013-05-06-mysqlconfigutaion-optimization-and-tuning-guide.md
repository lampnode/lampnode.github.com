---
layout: post
title: "MySQL:Configutaion优化和调优指南"
tagline: "MySQL:Configutaion Optimization and Tuning Guide"
description: ""
category: MySQL
tags: [ MySQL ]
---
{% include JB/setup %}

## 配置优化


### skip设置

#### 推荐

避免MySQL的外部锁定，减少出错几率增强稳定性

        skip-locking


#### 可选

禁止MySQL对外部连接进行DNS解析，使用这一选项可以消除MySQL进行DNS解析的时间

        skip-name-resolve

### 修改最大连接数

        # 最大链接值从100增加到512
        max_connections = 512

max_connect_errors 默认为10，意义是A主机连接mysql服务器出现10次或更多连接错误，就会出现屏蔽掉A发起的任何连接，也就是A服务器不能再访问mysql了。
可以有效的防止网络攻击，但是如果我们的程序连接串有误造成的站点服务器无法访问mysql的现象，就必须使用flush hosts或者重启mysql解决此的问题

        # 错误链接从10改到100
        max_connect_errors = 100

### 修改线程数

CPU逻辑线程数的2-4倍，我们搭载的CPU为8核心 × 2

        thread_concurrency = 16

### 数据缓存设置

#### 读索引快慢

主要用于mysiam表的索引，影响读索引的快慢。

        key_buffer = 1024M

每次读索引的大小

        key_cache_block_size= 2014


#### query cache

查询缓存区的工作模式:0, 禁用查询缓存区; 1，启用查询缓存区(默认设置); 2，"按需分配"模式，只响应SELECT SQL_CACHE命令。

        query_cache_type=1

查询缓存大小

        query_cache_size=512M

允许临时存放在查询缓存区里的查询结果的最大长度(默认设置是1M)

        query_cache_limit = 128M


#### tmp table size

mysql 的配置文件中，tmp_table_size 的默认大小是 32M。如果一张临时表超出该大小，MySQL产生一个 The table tbl_name is full
形式的错误，如果你做很多高级 GROUP BY 查询，增加 tmp_table_size 值.

        tmp_table_size=512M

它规定了内部内存临时表的最大值，每个线程都要分配。（实际起限制作用的是tmp_table_size和max_heap_table_size的最小值。）
        mysql> show variables like "tmpdir";
        +---------------+-------+
        | Variable_name | Value |
        +---------------+-------+
        | tmpdir        | /tmp/ |
        +---------------+-------+

优化查询语句的时候，要避免使用临时表，如果实在避免不了的话，要保证这些临时表是存在内存中的。如果需要的话并且你有很多group by语句，
并且你有很多内存，增大tmp_table_size(和max_heap_table_size)的值。这个变量不适用与用户创建的内存表(memory table).

你可以比较内部基于磁盘的临时表的总数和创建在内存中的临时表的总数（Created_tmp_disk_tables和Created_tmp_tables），一般的比例关系是:

        Created_tmp_disk_tables/Created_tmp_tables<5%

#### max heap table size

这个变量定义了用户可以创建的内存表(memory table)的大小.这个值用来计算内存表的最大行数值。这个变量支持动态改变，即set @max_heap_table_size=#,
但是对于已经存在的内存表就没有什么用了，除非这个表被重新创建(create table)或者修改(alter table)或者truncate table。
服务重启也会设置已经存在的内存表为全局max_heap_table_size的值。

这个变量和tmp_table_size一起限制了内部内存表的大小。

        max_heap_table_size = 32M


### 慢查询日志

日志存放位置设置

        log-slow-queries=/var/lib/mysql/slowquery.log

记录大约2秒的查询

        long_query_time=2

记录没有使用索引的查询

        log_queries_not_using_indexs =1


***注意*** 如果开启了log_queries_not_using_indexes选项，slow query日志会充满过多的垃圾日志记录，这些快且高效的全表扫描查询(表小)会冲掉真正有用的slow queries记录。比如select * from category这样的查询也被记录下来
