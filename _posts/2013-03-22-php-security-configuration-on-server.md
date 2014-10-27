---
layout: post
title: "PHP Security Configuration On Server"
tagline: "PHP Security Configuration On Server"
description: ""
category: PHP
tags: [ Linux, PHP, Security ]
---
{% include JB/setup %}


The purpose of this document is to provide a quick and easy security guide for settting php configuration file.

## Essential parameters

### Forbidden expose_php

Default as:

	expose_php=On

Update to:

	expose_php=Off

If not to be forbidden, by using the curl command, it will expose the server information:


	$ curl -I http://www.cyberciti.biz/index.php

	HTTP/1.1 301 Moved Permanently
	Server: nginx
	Date: Fri, 22 Mar 2013 07:31:40 GMT
	Connection: keep-alive
	Keep-Alive: timeout=60
	Location: http://www.cyberciti.biz/
	Vary: Accept-Encoding
	X-Galaxy: Andromeda-2

### PHP Error Report

Disable display errors

	display_errors=Off

Export the errors to file：

	log_errors=On
	error_log=/var/log/httpd/php_scripts_error.log

### allow_url_fopen

	allow_url_fopen=Off
	allow_url_include=Off

### Disable unnecessary modules

#### View all module configuration files

	# cd /etc/php.d
	#ls
	cups.ini  fileinfo.ini  mysqli.ini  pdo.ini        pdo_sqlite.ini  snmp.ini     zip.ini
	curl.ini  json.ini      mysql.ini   pdo_mysql.ini  phar.ini        sqlite3.ini

#### Disable sqlite

	 #mv /etc/php.d/sqlite3.ini /etc/php.d/sqlite3.disable

### Enable sql safe mode

	sql.safe_mode=On
	magic_quotes_gpc=Off


### Setup Session path

        session.save_path="/var/lib/php/session"
        ; Set the temporary directory used for storing files when doing file upload
        upload_tmp_dir="/var/lib/php/session"

### Setup open_basedir

#### Method A

Add the following in the php.ini:

	open_basedir = /home/users/you/public_html:/tmp

#### Method B

Add the following in the httpd.conf:

      	<Directory "/var/www/html/sitename/public_html">
        	Options Indexes FollowSymLinks
                AllowOverride All
                Order allow,deny
                Allow from all
		php_admin_value open_basedir .:/tmp/:/var/www/html/www.example.com/
        </Directory>	

### Turn off magic_quotes_gpc

	magic_quotes_gpc = 0 

### Disable functions

	disable_functions = show_source, system, shell_exec, passthru, exec, phpinfo, popen, proc_open

### Limit the file and access paths permisson



#### Change the php permission

	#cd /var/www/html
	#find . -type f -name "*.php" -exec chmod 0444 {} \;

#### Special folder settings

##### Upload path

	
	#cd /var/www/html/public_html/upload
	#find . -type d -exec chmod 0755 {} \;

##### Cache path

	# chmod a+w /var/www/html/public_html/cache
	# echo 'deny from all' > /var/www/html/public_html/cache/.htaccess

### Protect apache, php, mysql configuration file:

	# chattr +i /etc/php.ini
	# chattr +i /etc/php.d/*
	# chattr +i /etc/my.ini
	# chattr +i /etc/httpd/conf/httpd.conf
	# chattr +i /etc/

### Install Mod_security

	# yum install mod_security

#### mod_security configuration files

* /etc/httpd/conf.d/mod_security.conf - main configuration file for the mod_security Apache module.
* /etc/httpd/modsecurity.d/ - all other configuration files for the mod_security Apache.
* /var/log/httpd/modsec_debug.log - Use debug messages for debugging mod_security rules and other problems.
* /var/log/httpd/modsec_audit.log - All requests that trigger a ModSecurity events (as detected) or a serer error are logged ("RelevantOnly") are logged into this file.


#### Reboot apache

	# service httpd restart

#### Testing

	# tail -f /var/log/httpd/error_log

	[Mon Apr 22 10:37:57 2013] [notice] caught SIGTERM, shutting down
	[Mon Apr 22 10:37:57 2013] [notice] suEXEC mechanism enabled (wrapper: /usr/sbin/suexec)
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity for Apache/2.7.3 (http://www.modsecurity.org/) configured.
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: APR compiled version="1.3.9"; loaded version="1.3.9"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: PCRE compiled version="7.8 "; loaded version="7.8 2008-09-05"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: LUA compiled version="Lua 5.1"
	[Mon Apr 22 10:37:58 2013] [notice] ModSecurity: LIBXML compiled version="2.7.6"


