---
layout: post
title: "在 CentOs 6.x安装ntfs-3g"
tagline: "Install ntfs 3g on CentOs 6.x"
description: ""
category: Linux
tags: [ CentOS ]
---
{% include JB/setup %}

NTFS-3G 是一个开源的软件，可以实现 Linux、Free BSD、Mac OSX、NetBSD 和 Haiku 等操作系统中的 NTFS 读写支持。它可以安全且快速地读写 Windows 系统的 NTFS 分区，而不用担心数据丢失。

本文讲解如何在CentOS安装NTFS-3G来实习那挂载NTFS分区。

## 下载rpm文件包

64位系统
 
	[root@edwin]#  wget http://downloads.naulinux.ru/pub/SLCE/6x/x86_64/CyrEd/RPMS/ntfs-3g-2011.4.12-5.el6.x86_64.rpm
 
## 安装rpm文件包

 
	[root@edwin]#  rpm -ivh ntfs-3g-2011.4.12-5.el6.x86_64.rpm
