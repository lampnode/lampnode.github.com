---
layout: post
title: "在CentOS上如何启用 EPEL Repository"
tagline: "How to Enable EPEL Repository for CentOS"
description: ""
category: Linux 
tags: [ CentOs, YUM ]
---
{% include JB/setup %}

## EPEL简介

EPEL的全称叫 Extra Packages for Enterprise Linux 。EPEL是由 Fedora 社区打造，为 RHEL 及衍生发行版如 CentOS、Scientific Linux 等提供高质量软件包的项目。装上了 EPEL之后，就相当于添加了一个第三方源。

如果你知道rpmfusion.org的话，拿 rpmfusion 做比较还是很恰当的，rpmfusion 主要为桌面发行版提供大量rpm包，而EPEL则为服务器版本提供大量的rpm包，而且大多数rpm包在官方 repository 中是找不到的。

另外一个特点是绝大多数rpm包要比官方repository 的rpm包版本要来得新，比如我前些日子在CentOS上安装的php，RHEL为了稳定性还在延用5.1.6版，我记得这是去年上半年的版本，而php 的最新版本已经到5.3.2，如果在php5.1.6的基础上安装phpmyadmin，则会提示php版本过低，这时候，EPEL中提供的较新php rpm就能很方便的派上用场了。



## 如何使用 EPEL Repository

首先，你需要使用wget下载文件，使用RPM安装EPEL库 （请确保您必须是root用户）

### RHEL/CentOS 6 32-Bit

	wget http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
	rpm -ivh epel-release-6-8.noarch.rpm

### RHEL/CentOS 6 64-Bit

	wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	rpm -ivh epel-release-6-8.noarch.rpm

###  RHEL/CentOS 5 32-Bit

	wget http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
	rpm -ivh epel-release-5-4.noarch.rpm

###  RHEL/CentOS 5 64-Bit
	
	wget http://download.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
	rpm -ivh epel-release-5-4.noarch.rpm

## 验证 EPEL Repo

您需要运行下面的命令来验证EPEL存储库启用。一旦你运行了该命令，你会看到EPEL存储库。
	
	$yum repolist

	Loaded plugins: downloadonly, fastestmirror, priorities
	Loading mirror speeds from cached hostfile
	 * base: centos.aol.in
	 * epel: ftp.cuhk.edu.hk
	 * extras: centos.aol.in
	 * rpmforge: be.mirror.eurid.eu
	 * updates: centos.aol.in
	Reducing CentOS-5 Testing to included packages only
	Finished
	1469 packages excluded due to repository priority protections
	repo id                           repo name                                                      status
	base                              CentOS-5 - Base                                               2,718+7
	epel Extra Packages for Enterprise Linux 5 - i386 4,320+1,408
	extras                            CentOS-5 - Extras                                              229+53
	rpmforge                          Red Hat Enterprise 5 - RPMforge.net - dag                      11,251
	repolist: 19,075


## 使用EPEL Repo

您需要使用yum命令搜索并安装软件包。例如，我们需要安装的zabbix，让我们看看它是不是属于EPEL。

	$yum --enablerepo=epel info zabbix

	Available Packages
	Name       : zabbix
	Arch       : i386
	Version    : 1.4.7
	Release    : 1.el5
	Size       : 1.7 M
	Repo : epel
	Summary    : Open-source monitoring solution for your IT infrastructure
	URL        : http://www.zabbix.com/
	License    : GPL
	Description: ZABBIX is software that monitors numerous parameters of a network.

通过epel repo安装Zabbix包时需要使用参数–enablerepo=epel 

	yum --enablerepo=epel install zabbix


Note: The epel configuration file is located under /etc/yum.repos.d/epel.repo.

