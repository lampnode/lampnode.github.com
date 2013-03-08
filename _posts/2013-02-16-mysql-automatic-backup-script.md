---
layout: post
title: "Mysql自动备份脚本"
tagline: "Mysql automatic backup script"
description: ""
category: MySQL
tags: [MySQL]
---
{% include JB/setup %}

Mysql数据库备份的方式很多，如果是小数据库的话可以考虑用mysqldump命令备份.

## 特征

- 使用mysqldump对目标数据库执行全部备份任务
- 备份内容直接实现压缩
- 备份支持crond

## 使用方法

### 设置my.cnf
在当前用户创建my.cnf配置文件

	[robert@server ~]$vim ~/.my.cnf

添加如下内容:
{% highlight bash %}
[client]
pass=ROOT_PASSWD
user=root
[mysqldump]
pass=ROOT_PASSWD
user=root
{% endhighlight %}

### 安装ssh脚本

#### 下载脚本文件

为了便于管理，所有的crond脚本可以都放在一个目录下，如:
	
	[robert@server ~]#cd ~	
	[robert@server ~]#mkdir ~/crondScripts

下载并解压脚本文件

	[robert@server ~]# wget https://gist.github.com/lampnode/5113701/download -O mysql_backup_all.tar.gz
	[robert@server ~]# tar -xzvf mysql_backup_all.tar.gz

在解压目录里找到脚本文件，将脚本文件放到指定目录去，如~/crondScripts

#### 设置参数

##### EC_USER_DIR

指定备份目标目录,默认是/opt/site-bak


## 执行脚本
<script src="https://gist.github.com/lampnode/5113701.js"></script>

## mysqldump命令选项
mysqldump工具有大量的选项，部分选项如下表：
　　
### --add-drop-table

这个选项将会在每一个表的前面加上DROP TABLE IF EXISTS语句，这样可以保证导回MySQL数据库的时候不会出错，因为每次导回的时候，都会首先检查表是否存在，存在就删除

### --add-locks

这个选项会在INSERT语句中捆上一个LOCK TABLE和UNLOCK TABLE语句。这就防止在这些记录被再次导入数据库时其他用户对表进行的操作

### -c or - complete_insert

这个选项使得mysqldump命令给每一个产生INSERT语句加上列(field)的名字。当把数据导出导另外一个数据库时这个选项很有用。

### -f or -force 

使用这个选项，即使有错误发生，仍然继续导出
　　
### --full 

这个选项把附加信息也加到CREATE TABLE的语句中
　　
### -l or -lock-tables 

使用这个选项，导出表的时候服务器将会给表加锁。
　　
### -t or -no-create- info

这个选项使的mysqldump命令不创建CREATE TABLE语句，这个选项在您只需要数据而不需要DDL(数据库定义语句)时很方便。
　　
### -d or -no-data 

这个选项使的mysqldump命令不创建INSERT语句。在您只需要DDL语句时，可以使用这个选项。
