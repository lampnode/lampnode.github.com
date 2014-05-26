---
layout: post
title: "Howto install full packages php5 on Ubuntu 14.04 LTS"
tagline: "Howto install full packages php5 on Ubuntu 14.04 LTS"
description: ""
category: PHP 
tags: [ Ubuntu, PHP, Apache ]
---
{% include JB/setup %}

The purpose of this document is to guide how to install full packages php5 on Ubuntu 14.04 LTS.

### Install apache

	$sudo apt-get install apache2

#### Enable rewrite
	
	$sudo a2enmod rewrite

#### Update apache to 2.4

The apache is 2.4 as default on Ubuntu 14.04 LTS, if you change default document root, the apache should
report the following error:

	Apache2: 'AH01630: client denied by server configuration'

You have to check allow and deny rules. Please check out 
[http://httpd.apache.org/docs/2.4/upgrading.html](http://httpd.apache.org/docs/2.4/upgrading.html)

A Sample configuration for directory:

	<Directory "/path/to/www/root">
		Options Indexes FollowSymLinks
		AllowOverride All
		#Order allow,deny
		#Allow from all
		Require all granted
	</Directory>

### Install php5 with missing packages


#### basic

	$sudo apt-get install php5 php5-common

####  enable curl

	$sudo apt-get install curl libcurl3 libcurl3-dev php5-curl

### Enable GD

	$sudo apt-get install php5-gd

### Enable XSLT

	$sudo apt-get install php5-xsl


#### Install sqlite if need

	$sudo apt-get install sqlite php5-sqlite


### Restart apache

	$sudo service apache2 restart
