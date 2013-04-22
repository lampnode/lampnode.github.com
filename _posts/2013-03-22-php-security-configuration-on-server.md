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

### 禁止不必要的模块

#### 查看所有模块配置文件

	# cd /etc/php.d
	#ls
	cups.ini  fileinfo.ini  mysqli.ini  pdo.ini        pdo_sqlite.ini  snmp.ini     zip.ini
	curl.ini  json.ini      mysql.ini   pdo_mysql.ini  phar.ini        sqlite3.ini

#### 禁止sqlite

假设sqlite的配置文件在/etc/php.d,可以使用如下命令:

	 #mv /etc/php.d/sqlite3.ini /etc/php.d/sqlite3.disable

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

#### 文件与目录的属组

Apache不能使用root来执行，例如我们使用apache这个用户/组来执行web文件，所以:

	# chown -R apache:apache /var/www/html/

#### 文件与目录的基本设置

针对/var/www/html,我们先全部设置为0444(只读):

	chmod -R 0444 /var/www/html/

然后调整其子目录的权限，可以设置为 0445

	#cd /var/www/html
	#find . -type d -print0 | xargs -0 -I {} chmod 0445 {}	

或者
	#cd /var/www/html
	#find . -type d -exec chmod 0445 {} \;

#### 针对php文件的设置

	#cd /var/www/html
	#find . -type f -name "*.php" -exec chmod 0444 {} \;

#### 特殊文件夹的设置

##### 可上传文件夹

针对软件用于存储图片，文档的文件夹，需要设置权限如下:
	
	#cd /var/www/html/public_html/upload
	#find . -type d -exec chmod 0755 {} \;

##### 软件缓存文件夹

	# chmod a+w /var/www/html/public_html/cache
	# echo 'deny from all' > /var/www/html/public_html/cache/.htaccess

### 保护apache, php, mysql的配置文件

	# chattr +i /etc/php.ini
	# chattr +i /etc/php.d/*
	# chattr +i /etc/my.ini
	# chattr +i /etc/httpd/conf/httpd.conf
	# chattr +i /etc/

### 安装 Mod_security

	# yum install mod_security

#### mod_security configuration files

* /etc/httpd/conf.d/mod_security.conf - main configuration file for the mod_security Apache module.
* /etc/httpd/modsecurity.d/ - all other configuration files for the mod_security Apache.
* /var/log/httpd/modsec_debug.log - Use debug messages for debugging mod_security rules and other problems.
* /var/log/httpd/modsec_audit.log - All requests that trigger a ModSecurity events (as detected) or a serer error are logged ("RelevantOnly") are logged into this file.


#### 重启apache

	# service httpd restart

#### 测试是否执行

	# tail -f /var/log/httpd/error_log

	[Mon Apr 22 10:37:57 2013] [notice] caught SIGTERM, shutting down
	[Mon Apr 22 10:37:57 2013] [notice] suEXEC mechanism enabled (wrapper: /usr/sbin/suexec)
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity for Apache/2.7.3 (http://www.modsecurity.org/) configured.
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: APR compiled version="1.3.9"; loaded version="1.3.9"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: PCRE compiled version="7.8 "; loaded version="7.8 2008-09-05"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: LUA compiled version="Lua 5.1"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: LIBXML compiled version="2.7.6"

## 可选设置

### 控制post大小

	post_max_size=1K

