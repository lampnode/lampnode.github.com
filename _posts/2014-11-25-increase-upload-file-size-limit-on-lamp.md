---
layout: post
title: "Increase Upload File Size Limit on LAMP"
tagline: "Increase Upload File Size Limit on LAMP"
description: ""
category: PHP 
tags: [PHP, Apache, Linux]
---
{% include JB/setup %}

The PHP default installation limits on upload file size(2MB). This document is show you how to
increase upload file limit under apache web server.

## Modify the confiuration

### Edit php.ini

You should have permission to access and modify the php.ini file on the linux server.

	#sudo vim /etc/php.ini

Two PHP configuration options control the maximum upload size: "upload_max_filesize" and "post_max_size". find "post_max_size = 8M", update this value to:

	post_max_size = 30M

then, find "upload_max_filesize = 2M", this value sets the maximum size of an upload file.  update this value to:

	upload_max_filesize = 20M

Howerver, you also need to consider the time it takes to complate and upload, find "max_execution_time = 30", update this value to:

	max_execution_time = 300

In addition, manipulating or saving an uploaded image may also cause script time-outs, find "max_input_time = 60", update this value to:

	max_input_time = 300

then, find "memory_limit = 128M", update this value to:

	memory_limit = 256M

These options can be set in your server’s php.ini configuration file so that they apply to all your applications. Alternatively, if you’re using Apache, you can configure the settings in your application’s .htaccess file:

	php_value upload_max_filesize 20M
	php_value post_max_size 20M
	php_value max_input_time 300
	php_value max_execution_time 300

Or, you can define the constraints within your PHP application:

	ini_set('upload_max_filesize', '10M');
	ini_set('post_max_size', '10M');
	ini_set('max_input_time', 300);
	ini_set('max_execution_time', 300);


### Edit apache conf file

Apache limits requests with the Apache LimitRequestBody directive.

	#sudo vim /etc/httpd/conf.d/php.conf 

find "LimitRequestBody 524288"(512k), update this value to:

	LimitRequestBody 20971520 #20M*1024*1024

## Restart the server

To restart your Apache server once you’ve made this change, with this command:

	#sudo /etc/init.d/httpd restart
