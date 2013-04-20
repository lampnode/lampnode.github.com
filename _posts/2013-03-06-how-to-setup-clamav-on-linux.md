---
layout: post
title: "如何在Linux上设置ClamAV"
tagline: "How to setup ClamAV on Linux"
description: ""
category: Linux
tags: [ Linux, Security ]
---
{% include JB/setup %}

ClamAV AntiVirus是一个类UNIX系统上使用的反病毒软件包。主要应用于邮件服务器，采用多线程后台操作，可以自动升级病毒库。
ClamAv主要是在命令行下的查毒软件，因为它不将杀毒作为主要功能，默认只能查出您计算机内的病毒，但是无法清除，至多删除文件。

## 在CentOs安装

### 下载 rpm packages

我们可以从网站 [http://pkgs.repoforge.org/clamav/](http://pkgs.repoforge.org/clamav/)下载最新的安装包。主要包含3个文件，clamav-db,clamav 和 clamd。

下载的时候注意系统的版本:
 
#### For CentOs 5 64bit

	wget http://pkgs.repoforge.org/clamav/clamav-db-0.97.7-1.el5.rf.x86_64.rpm
	wget http://pkgs.repoforge.org/clamav/clamav-0.97.7-1.el5.rf.x86_64.rpm
	wget http://pkgs.repoforge.org/clamav/clamd-0.97.7-1.el5.rf.x86_64.rpm

#### For CentOs 6 64bit
 
	wget http://pkgs.repoforge.org/clamav/clamav-db-0.97.7-1.el6.rf.x86_64.rpm
        wget http://pkgs.repoforge.org/clamav/clamav-0.97.7-1.el6.rf.x86_64.rpm
        wget http://pkgs.repoforge.org/clamav/clamd-0.97.7-1.el6.rf.x86_64.rpm
	

### 安装

安装顺序不能改变:

	rpm -ivh clamav-db-xxxxxx.x86_64.rpm
	rpm -ivh clamav-xxxxxxxxx.x86_64.rpm
	rpm -ivh clamd-xxxxxxxxxx.x86_64.rpm
 
### 启用 clamd and freshclam

	service clamd start
	freshclam --daemon
 
### 自动启用  freshclam

	echo "/usr/bin/freshclam --daemon" >> /etc/rc.d/rc.local


## 基本用法

### 扫描文件
 
	clamscan file
 
### 扫描路径


扫描所有用户的主目录就使用

	clamscan -r /home

扫描您计算机上的所有文件并且显示所有的文件的扫描结果

	clamscan -r /  
 
 
 
### 扫描数据流(Data flow)
 
	cat testfile | clamscan -
 
### 扫描邮件路径
 
	clamscan -r --mbox /var/spool/mail
 
### 保存扫描日志
 
	clamscan -r -i --mbox /var/spool/mail>error.log
 
	clamscan -r -i /home>error.log
 
