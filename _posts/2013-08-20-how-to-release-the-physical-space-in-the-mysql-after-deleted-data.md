---
layout: post
title: "在mysql删除数据后如何释放物理空间"
tagline: "How to release the physical space in the MySQL after deleted data"
description: ""
category: mysql
tags: [MySQL]
---
{% include JB/setup %}

当您的库中删除了大量的数据后，您可能会发现数据文件尺寸并没有减小。这是因为删除操作后在数据文件中留下碎片所致。OPTIMIZE TABLE 是指对表进行优化。如果已经删除了表的一大部分数据，或者如果已经对含有可变长度行的表（含有 VARCHAR 、 BLOB 或 TEXT 列的表）进行了很多更改，就应该使用 OPTIMIZE TABLE 命令来进行表优化.

### 使用方法
执行前查看一下.MYD,.MYI文件的大小

        [root@lampnode]# ls |grep visit |xargs -i du {}
		282080    system_log.MYD
		126024    system_log.MYI
		12    system_log.frm

执行如下命令即可.

	mysql> optimize table system_log;
	+------------------------+----------+----------+----------+  
	| Table                  | Op       | Msg_type | Msg_text |  
	+------------------------+----------+----------+----------+  
	| lampnode.system_log	 | optimize | status   | OK       |  
	+------------------------+----------+----------+----------+  
	1 row in set (1 min 21.05 sec)  


查看一下.MYD,.MYI文件的大小

	[root@lampnode]# ls |grep visit |xargs -i du {}  
		182080    system_log.MYD                  
		66024    system_log.MYI
		12    system_log.frm 

### 总结
如果您已经删除了表的一大部分，或者如果您已经对含有可变长度行的表（含有VARCHAR, BLOB或TEXT列的表）进行了很多更改，则应使用 OPTIMIZE TABLE。被删除的记录被保持在链接清单中，后续的INSERT操作会重新使用旧的记录位置。您可以使用OPTIMIZE TABLE来重新 利用未使用的空间，并整理数据文件的碎片。

OPTIMIZE TABLE只对MyISAM, BDB和InnoDB表起作用。注意，在OPTIMIZE TABLE运行过程中，MySQL会锁定表。
 
