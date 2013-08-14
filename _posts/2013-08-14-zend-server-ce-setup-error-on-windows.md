---
layout: post
title: "Windows系统下Zend Server CE安装问题"
tagline: "Zend Server CE setup error on windows"
description: ""
category: PHP
tags: [PHP, Zend]
---
{% include JB/setup %}

Zend Server Community Edition (CE) is a free Web Application Server that is simple to install and easy to use. It is an ideal solution for anyone experimenting with PHP or running PHP applications in production where a commercial support is not needed.

## 安装

* 操作系统:Windows xp sp3 中文版
* Zend server版本: ZendServer-CE-php-5.2.17-5.6.0-SP1-Windows_x86



## 排错

### 配置文件乱码造成启动失败

安装过程中会有以下问题(这个问题只是在中文系统下才有)

安装过程没有问题，但是在第一次运行 ZendServer 时，出错了：在打开网址 

	http://localhost:10081/ZendServer

 时，报告：

	500 Internal Server Error

Apache应该是正常的，php没起来。打开 Apache 日志， 发现下面的提示：

	[error] Zend Enabler cannot load because of a problem in its configuration file: XML parse error on line 1 column 3 - processing instruction name expected
 
打开 Zend Enabler 的 XML 配置文件 

	c:/Zend/ZendServer/etc/ZendEnablerConf.xml

首行第一个字符是乱码,改成“<?xml ”字符保存，重启 apache 服务器。即可

### 端口冲突造成Apache不能启动

有时候，其他程序会占用80端口，造成Apache启动失败，解决如下:

在命令窗口中输入netstat -a -o 参数：
* -a：显示所有活动的 TCP 连接以及计算机侦听的 TCP 和 UDP 端口。
* -o：显示活动的 TCP 连接并包括每个连接的进程 ID (PID)。

可以在 Windows 任务管理器中的“进程”选项卡上找到基于 PID 的应用程序。该参数可以与-a、-n 和   结合使用

结果显示为：


	C:\Documents and Settings\Robot>netstat -a -o

	Active Connections

	  Proto  Local Address          Foreign Address        State           PID
	  TCP    0.0.0.0:80      	 edwinoffice:0         LISTENING       1912
	  TCP    edwinoffice:epmap      edwinoffice:0          LISTENING       1080
	  TCP    edwinoffice:microsoft-ds  edwinoffice:0       LISTENING       4
	  TCP    edwinoffice:1688       edwinoffice:0          LISTENING       1980
	  TCP    edwinoffice:8051       edwinoffice:0          LISTENING       3796
	  TCP    edwinoffice:10081      edwinoffice:0          LISTENING       1912
	  TCP    edwinoffice:12171      edwinoffice:0          LISTENING       3796
	  TCP    edwinoffice:1066       edwinoffice:0          LISTENING       2172
	  TCP    edwinoffice:10246      localhost:10081        TIME_WAIT       0
	  TCP    edwinoffice:10253      localhost:10081        TIME_WAIT       0
	  TCP    edwinoffice:netbios-ssn  edwinoffice:0          LISTENING       4
	  TCP    edwinoffice:1108       114.112.93.100:http    CLOSE_WAIT      3396
	  TCP    edwinoffice:3963       hg-in-f125.1e100.net:5222  ESTABLISHED     2036
	  TCP    edwinoffice:7966       192.168.0.7:10618      ESTABLISHED     5628
	  TCP    edwinoffice:8221       192.168.0.7:10618      ESTABLISHED     5628

找到Local Address那个占用80的应用，Kill就可以了
