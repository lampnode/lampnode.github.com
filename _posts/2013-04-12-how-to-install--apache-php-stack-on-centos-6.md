---
layout: post
title: "如何在CentOS 6上安装Apache与PHP"
tagline: "How to Install Apache PHP stack on CentOS 6"
description: ""
category: Linux 
tags: [ Linux, PHP, Apache ]
---
{% include JB/setup %}

## Install Apache

	yum install httpd
	service httpd start
	chkconfig httpd on

## Install PHP

	yum install php php-mysql
