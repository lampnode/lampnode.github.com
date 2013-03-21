---
layout: post
title: "如何使用rkhunter保护服务器"
tagline: "HowTo use rkhunter to protect the server"
description: ""
category: Linux
tags: [ Linux, Security ]
---
{% include JB/setup %}

[rkhunter](http://www.rootkit.nl/)是Linux下的一款开源入侵检测工具。rkhunter具有比chrootkit更为全面的扫描范围。除rootkit特征码扫描外，rkhunter还支持端口扫描，常用开源软件版本和文件变动情况检查等。

## 安装

### YUM安装

安装rkhunter,需要设置EPEL( [在CentOS上如何启用 EPEL Repository](/Linux/how-to-enable-epel-repository-for-centos/)  )

	$yum install rkhunter -y

### 参数

#### --checkall (or -c)

检查系统并执行所有测试。

#### --createlogfile*

建立Log(预设产生于/var/log/rkhunter.log)

#### --cronjob

加入系统排程 (会自动拿掉彩色输出)

#### --help (or -h)
显示说明及相关用法

#### --nocolors*
不要使用颜色为输出型式(一些Term Type对颜色或延长的显示符号会有问题)

#### --report-mode*
若用 crontab 或其他用法时，如header/footer则不显示
--skip-keypress*
(不采互动)也就是不要每个测试后等待提示出现，按下 Enter 才能继续

#### --quick*
执行快的扫瞄(代替充分的扫瞄) 略过一些测试而执行某些加强的测试(对正常扫瞄而言，较不适当)。

#### --update
更新 hashes database

#### --version
显示版本并离开

#### --versioncheck
检查最新的版本


## 更新rkhunter的数据库

	$rkhunter --update
	$rkhunter --list

## 为基本系统程序建立校对样本

	$rkhunter --propupd
	[ Rootkit Hunter version 1.3.8 ]
	File created: searched for 165 files, found 136
## 检测

### 基本方法

	$rkhunter -c

### 检测二进制命令

	$krootkit ps pwd ls  

### 检查所有，只提示被感染文件加 -q  

	$chkrootkit -q  

### 制定检测其他root目录，可以先把要检测的系统挂到/mnt/root下。  
	
	$chkrootkit -r /mnt/root  

## 邮件提醒

添加rkhunter.sh到"/etc/cron.daily/"

	vim /etc/cron.daily/rkhunter.sh

添加如下内容到文件 rkhunter.sh

{% highlight bash %}
#!/bin/sh
(
/usr/local/bin/rkhunter --versioncheck
/usr/local/bin/rkhunter --update
/usr/local/bin/rkhunter --cronjob --report-warnings-only
) | /bin/mail -s 'Rkhunter Daily Run Service' your@email.com
{% endhighlight %}

修改文件权限

	$chmod 755 /etc/cron.daily/rkhunter.sh

## 调试问题

### PATH设置问题

如果出现类似错误,如
	
	Invalid BINDIR configuration option: Invalid directory found: ...

说明你的PATH变量有问题，请检查相关配置

