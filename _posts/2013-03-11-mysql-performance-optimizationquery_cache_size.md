---
layout: post
title: "MySQL 性能调优:query_cache_size"
tagline: "MySQL Performance Optimization:query_cache_size"
description: ""
category: MySQL 
tags: [ MySQL ]
---
{% include JB/setup %}

查询缓存的设置，在MyISAM数据库引擎中，意义还是比较大的。

## 工作原理
查询缓存的工作原理

- 把select语句按照一定的hash规则生成唯一的key，select的结果生成value，即 key=>value。所以对于cache而言，select语句是区分大小写的，也区分空格的。两个select语句必须完完全全一致，才能够获取到同一个cache。
- 生成cache之后，只要该select中涉及到的table有任何的数据变动(insert，update，delete操作等),相关的所有cache都会被删除。因此只有数据很少变动的table，引入mysql 的cache才较有意义。

mysql的cache功能只适用于下列场合：数据变动较少，select较多的table。在数据库写入量或是更新量也比较大的系统，该参数不适合分配过大。而且在高并发，写入量大的系统，建议把该功能禁掉。


## 查看Mysql的query cache

### qcache
{% highlight bash %}
mysql> show global status like 'qcache%';
+-------------------------+-----------+
| Variable_name           | Value     |
+-------------------------+-----------+
| Qcache_free_blocks      | 166296    | 
| Qcache_free_memory      | 462222720 | 
| Qcache_hits             | 197260498 | 
| Qcache_inserts          | 93518106  | 
| Qcache_lowmem_prunes    | 8758976   | 
| Qcache_not_cached       | 15284700  | 
| Qcache_queries_in_cache | 350719    | 
| Qcache_total_blocks     | 868015    | 
+-------------------------+-----------+
8 rows in set (0.00 sec)
{% endhighlight %}

- Qcache_free_blocks：缓存中相邻内存块的个数。数目大说明可能有碎片。FLUSH QUERY CACHE会对缓存中的碎片进行整理，从而得到一个空闲块。
- Qcache_free_memory：缓存中的空闲内存。
- Qcache_hits：每次查询在缓存中命中时就增大
- Qcache_inserts：每次插入一个查询时就增大。命中次数除以插入次数就是不中比率。
- Qcache_lowmem_prunes：缓存出现内存不足并且必须要进行清理以便为更多查询提供空间的次数。这个数字最好长时间来看;如果这个数字在不断增长，就表示可能碎片非常严重，或者内存很少。(上面的 free_blocks和free_memory可以告诉您属于哪种情况)
- Qcache_not_cached：不适合进行MySQL查询缓存变量，通常是由于这些查询不是 SELECT 语句或者用了now()之类的函数。
- Qcache_queries_in_cache：当前缓存的查询(和响应)的数量。
- Qcache_total_blocks：缓存中块的数量。


### query_cache

{% highlight bash %}
mysql> show variables like 'query_cache%';
+------------------------------+------------+
| Variable_name                | Value      |
+------------------------------+------------+
| query_cache_limit            | 1048576    | 
| query_cache_min_res_unit     | 4096       | 
| query_cache_size             | 1073741824 | 
| query_cache_type             | ON         | 
| query_cache_wlock_invalidate | OFF        | 
+------------------------------+------------+
5 rows in set (0.00 sec)
{% endhighlight %}

- query_cache_limit：超过此大小的查询将不缓存
- query_cache_min_res_unit：缓存块的最小大小
- query_cache_size：查询缓存大小
- query_cache_type：缓存类型，决定缓存什么样的查询，示例中表示不缓存 select sql_no_cache 查询
- query_cache_wlock_invalidate：当有其他客户端正在对MyISAM表进行写操作时，如果查询在query cache中，是否返回cache结果还是等写操作完成再读表获取结果。
- query_cache_min_res_unit的配置是一柄”双刃剑”，默认是4KB，设置值大对大数据查询有好处，但如果你的查询都是小数据查询，就容易造成内存碎片和浪费费。

## 性能监控

### 查询缓存碎片率

	查询缓存碎片率 = Qcache_free_blocks / Qcache_total_blocks * 100%

如果查询缓存碎片率超过20%，可以用FLUSH QUERY CACHE整理缓存碎片，或者试试减小query_cache_min_res_unit，如果你的查询都是小数据量的话。

### 查询缓存利用率

	查询缓存利用率 = (query_cache_size - Qcache_free_memory) / query_cache_size * 100%

查询缓存利用率在25%以下的话说明query_cache_size设置的过大，可适当减小;查询缓存利用率在80%以上而且Qcache_lowmem_prunes > 50的话说明query_cache_size可能有点小，要不就是碎片太多。

### 查询缓存命中率

	查询缓存命中率 = (Qcache_hits - Qcache_inserts) / Qcache_hits * 100%

### Qcache_lowmem_prunes

该参数值对于检测查询缓存区的内存大小设置是否，有非常关键性的作用，其代表的意义为：查询缓存去因内存不足而不得不从查询缓存区删除的查询缓存信息

### query_cache_min_res_unit
    
内存块分配的最小单元非常重要，设置过大可能增加内存碎片的概率发生，太小又可能增加内存分配的消耗，为此在系统平稳运行一个阶段性后，可参考公式的计算值：
查询缓存最小内存块 = (query_cache_size – Qcache_free_memory) / Qcache_queries_in_cache

### 实例:

	查询缓存碎片率 = 20.46%，
	查询缓存利用率 = 62.26%，
	查询缓存命中率 = 1.94%，

命中率很差，可能写操作比较频繁吧，而且可能有些碎片。

## 调试建议

### query_cache_size

	query_cache_size = 1024M;

设置不要超过物理内存的20%

### 配置query_cache_type，同时改写程序。

query_cache_type 

- 0 代表不使用缓冲
- 1 代表使用缓冲
- 2 代表根据需要使用。

设置 1 代表缓冲永远有效，如果不需要缓冲，就需要使用如下语句：

	SELECT SQL_NO_CACHE * FROM my_table WHERE ...

如果设置为 2 ，需要开启缓冲，可以用如下语句：

	SELECT SQL_CACHE * FROM my_table WHERE ...


最简单又可靠的做法是：把query_cache_type设置为2，然后在需要提高select速度的地方，使用：

	SELECT SQL_CACHE * FROM...
    

