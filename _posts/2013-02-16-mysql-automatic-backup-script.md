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
