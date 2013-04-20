---
layout: post
title: "服务器PHP安全配置"
tagline: "PHP Security Configuration On Server"
description: ""
category: PHP
tags: [ Linux, PHP, Security ]
---
{% include JB/setup %}

PHP的安全设置，主要是修改 php.ini(一般位于/etc/php.ini)中的相关参数。主要参数如下:

## 必须设置参数

### 禁止expose_php

默认为 

	expose_php=On

修改为 

	expose_php=Off

如果不禁止的话，通过使用curl命令，可以暴露服务器信息:

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

### PHP错误信息设置

关闭显示错误

	display_errors=Off

将错误信息输出到指定文件：

	log_errors=On
	error_log=/var/log/httpd/php_scripts_error.log

### 禁止远端代码执行

	allow_url_fopen=Off
	allow_url_include=Off

### 启动sql安全模式

	sql.safe_mode=On
	magic_quotes_gpc=Off


### 设置 Session path

        session.save_path="/var/lib/php/session"
        ; Set the temporary directory used for storing files when doing file upload
        upload_tmp_dir="/var/lib/php/session"

### 设置open_basedir

#### 方法1

在php.ini里直接设置


	open_basedir = /home/users/you/public_html:/tmp

#### 方法2

在httpd.conf中设置

	

### 关闭magic_quotes_gpc

	magic_quotes_gpc = 0 

### 禁止高危PHP函数

	disable_functions = show_source, system, shell_exec, passthru, exec, phpinfo, popen, proc_open

### 限制文件与路径的访问权限

Apache不能使用root来执行，例如我们使用apache这个用户/组来执行web文件，所以:

	# chown -R apache:apache /var/www/html/

其中 /var/www/html是DocumentRoot的子目录, 其中的文件的权限是0444(只读):

	chmod -R 0444 /var/www/html/

其子目录的权限设置为 0445

	#find /var/www/html/ -type d -print0 | xargs -0 -I {} chmod 0445 {}	

## 可选设置

### 控制post大小

	post_max_size=1K

