---
layout: post
title: "手动安装 Zend Server"
tagline: "Manually Installing Zend Server"
description: ""
category: Linux 
tags: [ ZendServer, CentOs, Ubuntu, PHP ]
---
{% include JB/setup %}

 
## 安装 
### Ubuntu


#### 设置软件源

在文件" /etc/apt/sources.list" 增加如下一行:

	deb http://repos.zend.com/zend-server/deb server non-free


导入 Zend repository的 public key:

	# wget http://repos.zend.com/zend.key -O- |sudo apt-key add -

同步软件源:

	# sudo apt-get update


#### 安装

##### Install Zend Server CE

	# sudo apt-get install zend-server-php-5.x

##### Install Zend Server


	# sudo apt-get install zend-server-php-5.x

### CentOs/RHEL/Fedora

### 设置YUM源

创建文件"/etc/yum.repos.d/zend.repo",并添加如下内容:

	[Zend]
	name=Zend Server
	baseurl=http://repos.zend.com/zend-server/rpm/$basearch
	enabled=1
	gpgcheck=1
	gpgkey=http://repos.zend.com/zend.key

	[Zend_noarch]
	name=Zend Server - noarch
	baseurl=http://repos.zend.com/zend-server/rpm/noarch
	enabled=1
	gpgcheck=1
	gpgkey=http://repos.zend.com/zend.key


#### 安装

##### Zend Server CE

	yum install zend-server-ce-php-5.x

##### Install Zend Server  


	# yum install zend-server-php-x

##### 清理软件包

	# yum clean all

## 设置管理界面

After installing, a completion notification will appear, with a notice that the servers have started. To access the Administration Interface (Web) open your browser at:
 
	https://localhost:10082/ZendServer
 
or
 
	http://localhost:10081/ZendServer.
 
Upon initial log in, you will be prompted to define your password.


## 安装后配置

### 系统环境配置
To add the install/path/bin directory to your $PATH environment variable for all users:

Log in as root or use sudo to execute the following commands.Using a text editor, open /etc/profile.  Add the following lines to the end of the file

	
	PATH=$PATH:/install/path/bin
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:install/path/lib


Replace install_path with your Zend Server installation path.

Save the file.In order for this to take effect, close and reopen your shell or run the following command:

	source /etc/profile

You can now run the PHP binary provided by Zend Server without typing its full path.

### 虚拟主机设置

参看 [如何配置Apache虚拟机](/Apache/how-to-setup-apache-virtual-host-configuration/)

