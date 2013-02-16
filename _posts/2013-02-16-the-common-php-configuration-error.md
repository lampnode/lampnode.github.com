---
layout: post
title: "常见的PHP配置错误"
tagline: "The Common PHP configuration error"
description: ""
category: PHP 
tags: [PHP,Debug]
---
{% include JB/setup %}

在生产服务器上，一般PHP的报错是关闭的，如果出现PHP程式异常或者错误，页面是不显示的，第一处理措施应该去查看服务器端httpd的错误信息，只要保证虚拟机配置正确，PHP的报错信息一般会记录在虚拟机的日志里面，Linux的日志一般存放在如下目录:

	/var/log/httpd


## 上传错误

### upload_tmp_dir 配置不正确

如果没有正确的upload_tmp_dir设置，PHP会报一个如下错误:

	PHP Warning: File upload error - unable to create a temporary file in Unknown on line 0

解决的方法就是去掉 upload_tmp_dir 前面的分号然后设置临时文件目录,并且保证Httpd有访问权限

## Date设置错误

### 错误信息
	PHP Warning: date() [function.date]: It is not safe to rely on the system's timezone settings. You are *required* to use the date.timezone setting or the date_default_timezone_set() function. In case you used any of those methods and you are still getting this warning, you most likely misspelled the timezone identifier. We selected 'UTC' for '8.0/no DST' instead in...

从 PHP 5.1.0 ，当对使用date（）等函数时，如果timezone设置不正确，在每一次调用时间函数时,都会产生E_NOTICE 或者 E_WARNING 信息。而又在php5.1.0 中，date.timezone这个选项，默认情况下是关闭的，无论用什么php命令都是格林威治标准时间，但是PHP5.3 中好像如果没有设置也会强行抛出了这个错误的,解决此问题，只要本地化一下，就行了。以下 是两种方法(任选一种都 行)：

#### 在页头使用 date_default_timezone_set()设置
	date_default_timezone_set('PRC'); //东八时区
	echo date('Y-m-d H:i:s');
#### 修改php.ini。

打开php5.ini查找date.timezone 去掉前面的分号　= 后面加XXX，重启http服务（如apache2或iis等）即可。XXX可以任意正确的值。例如：Asia/Chongqing ，Asia/Shanghai ，Asia/Urumqi
