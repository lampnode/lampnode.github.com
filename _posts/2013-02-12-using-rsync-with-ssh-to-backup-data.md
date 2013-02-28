---
layout: post
title: "使用Rsync经SSH备份数据"
tagline: "Using Rsync with SSH to backup data"
description: ""
category: Linux 
tags: [CentOs]
---
{% include JB/setup %}

## 系统要求

在常驻模式（daemon mode）下，rsync默认监听TCP端口873。SSH情况下，rsync用户端执行程式必须同时在本地和远程机器上安装。

需要安装这些软件包：

- rsync
- openssh
- cron

## 使用方法

### 备份 

不带 delete 参数
 
	$ rsync -avz -e ssh remoteuser@remotehost:/remote/dir /local/dir/ 
 
### 镜像数据 

带 delete 参数

By default, rsync will only copy files and directories, but not remove them from the destination copy when they are removed from the source. To keep the copies exact, include the --delete flag:
 
	$ rsync -avz ssh  --delete remoteuser@remotehost:/remote/dir /local/dir/

### 使用密钥

#### 生成密钥

	$ ssh-keygen -t dsa -b 1024 -f rsync.key
	Generating public/private dsa key pair
	Enter passphrase (empty for no passphrase): [Enter without any input]
	Enter same passphrase again: [Enter without any input]
	Your identification has been saved in yenjinc.info-key. 
	Your public key has been saved in yenjinc.info-key.pub. 
	The key fingerprint is: 
	41:29:60:49:40:c3:a0:8f:2f:74:4e:40:64:a5:42:db edwin@client.local 

这时候会产生2个文件:
rsync.key
rsync.key.pub

#### 将公钥加入远端服务器

	$ scp rsync.key.pub robert@remote.server.com:~/.ssh/ 
	$ ssh robert@remote.server
	$ cd .ssh
	$ cat rsync.key.put >>  authorized_keys
	$ chmod 600  authorized_keys

#### 测试是否可以无密码登录远端服务器
	
	$ssh -i rsync.key robert@remote.server

#### 测试备份

	$ rsync -avz -e "ssh -i rsync.key" robert@remote.server:~/backup/ /backup/ 


### rsync + ssh + No Password + Crontab 

#### 创建执行脚本

脚本文件为 /home/edwin/crontabScript/rsync.sh,内容如下
	
{% highlight bash %}
#!/bin/bash 
RSYNC=/sw/bin/rsync 
SSH=/usr/bin/ssh 
KEY=/your/path/to/rsync.key
USER=robert 
HOST=remote.server
REMOTE_DIR=/home/robert/backup/ 
LOCAL_DIR=/Users/robert/backup/ 

# rsync+ssh+crontab command 
$RSYNC -avz -e "$SSH -i $KEY"  $USER@$HOST:$REMOTE_DIR $LOCAL_DIR 
{% endhighlight %}

#### 设置crontab

	$crontab -e
	20 1 * * * /home/edwin/crontabScript/rsync.sh


## 相关文章
* [如何在Linux上安装Rsync](/Linux/how-to-setu
p-rsync-on-linux/index.html)
 
