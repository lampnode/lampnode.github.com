---
layout: post
title: "服务器PHP安全配置"
tagline: "PHP Security Configuration On Server"
description: ""
category: PHP
tags: [ Linux, PHP, Security ]
---
{% include JB/setup %}

## 环境

- php.ini 位于/etc/php.ini


## 禁止expose_php

 	$vim /etc/php.ini

	expose_php=Off

如何不禁止的话，通过使用curl命令，可以暴露服务器信息:

	$ curl -I http://www.cyberciti.biz/index.php

输入样例:

	HTTP/1.1 301 Moved Permanently
	Server: nginx
	Date: Fri, 22 Mar 2013 07:31:40 GMT
	Connection: keep-alive
	Keep-Alive: timeout=60
	Location: http://www.cyberciti.biz/
	Vary: Accept-Encoding
	X-Galaxy: Andromeda-2

## 记录所有PHP错误

关闭显示错误

	display_errors=Off

将错误信息输出到指定文件：

	log_errors=On
	error_log=/var/log/httpd/php_scripts_error.log

## 禁止远端代码执行

	allow_url_fopen=Off
	allow_url_include=Off

## 启动sql安全模式

	sql.safe_mode=On
	magic_quotes_gpc=Off


## 控制post大小

	post_max_size=1K

## 禁止高危PHP函数

	disable_functions =exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source

## 设置 Session path

	session.save_path="/var/lib/php/session"
	; Set the temporary directory used for storing files when doing file upload
	upload_tmp_dir="/var/lib/php/session"

## 找出后门程序

可以使用Unix/Linux grep命令，搜索c99或r57外壳：

	# grep -iR 'c99' /var/www/html/
	# grep -iR 'r57' /var/www/html/
	# find /var/www/html/ -name \*.php -type f -print0 | xargs -0 grep c99
	# grep -RPn "(passthru|shell_exec|system|base64_decode|fopen|fclose|eval)" /var/www/html/
