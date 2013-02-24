---
layout: post
title: "手动安装 Zend Server"
tagline: "Manually Installing Zend Server"
description: ""
category: Linux 
tags: [ Zend Server ]
---
{% include JB/setup %}

Install Zend Server, the first thing you have to do is to setup the repository for downloading the Zend Server package.
 
 
## Ubuntu

### To setup the environment

Define a repository by opening the following file: /etc/apt/sources.list and adding the line:

	deb http://repos.zend.com/zend-server/deb server non-free


Add Zend's repository public key by running:

	# wget http://repos.zend.com/zend.key -O- |sudo apt-key add -

To synchronize with Zend's repository run:

	# sudo apt-get update


### To install

#### Install Zend Server CE

	# sudo apt-get install zend-server-php-5.2

#### Install Zend Server
Once the repository is set up, run the appropriate command according to PHP support you require (5.2 ,5.3  5.4):

	# sudo apt-get install zend-server-php-5.2

## CentOs/RHEL/Fedora

### To setup the environment:

Set up your Zend Server repository by creating:/etc/yum.repos.d/zend.repo and adding the following content:

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

Now you can use 'yum' to handle installations or any other tool that supports the RPM packaging format.

###To install

#### Install Zend Server CE

Once the environment is setup, run the appropriate command according to the product version and PHP support you require: To install Zend Server Community Edition with PHP 5.2 run:
 
	yum install zend-server-ce-php-5.2
 
To install Zend Server Community Edition with PHP 5.3 run:
 
 	yum install zend-server-ce-php-5.3

#### Install Zend Server  

Once the environment is setup, run the appropriate command according to the PHP version support you require (5.2 or 5.3):

	# yum install zend-server-php-<PHP Version>

To clean your packages cache and ensure retrieval of updates from the web, run:

	# yum clean all

## Login Web administration interface

After installing, a completion notification will appear, with a notice that the servers have started. To access the Administration Interface (Web) open your browser at:
 
	https://localhost:10082/ZendServer
 
or
 
	http://localhost:10081/ZendServer.
 
Upon initial log in, you will be prompted to define your password.


## Post Installation Configuration

To add the install/path/bin directory to your $PATH environment variable for all users:

Log in as root or use sudo to execute the following commands.Using a text editor, open /etc/profile.  Add the following lines to the end of the file

	
	PATH=$PATH:/install/path/bin
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:install/path/lib


Replace install_path with your Zend Server installation path.

Save the file.In order for this to take effect, close and reopen your shell or run the following command:

	source /etc/profile

You can now run the PHP binary provided by Zend Server without typing its full path.
