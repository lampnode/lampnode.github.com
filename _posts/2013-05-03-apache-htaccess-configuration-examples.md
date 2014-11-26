---
layout: post
title: "Apache .htaccess配置例子"
tagline: "Apache htaccess configuration examples"
description: ""
category: Apache
tags: [ Apache, Linux ]
---
{% include JB/setup %}

### 设置错误文档

常用的客户端请求错误返回代码：
	401 Authorization Required
	403 Forbidden
	404 Not Found
	405 Method Not Allowed
	408 Request Timed Out
	411 Content Length Required
	412 Precondition Failed
	413 Request Entity Too Long
	414 Request URI Too Long
	415 Unsupported Media Type

常见的服务器错误返回代码：
	
	500 Internal Server Error

一般情况下，可以专门设立一个目录，例如errors放置这些页面。然后再.htaccess中，加入如下的指令：

	ErrorDocument 404 /errors/notfound.html
	ErrorDocument 500 /errors/internalerror.html

一条指令一行。上述第一条指令的意思是对于404，也就是没有找到所需要的文档的时候得显示页面为/errors目录下的notfound.html页面。

### 实现域名跳转

	RewriteEngine on
	RewriteCond %{HTTP_HOST} ^oldDomain.com [NC]
	RewriteRule ^(.*)$ http://www.newDomain.com/$1 [L,R=301]

或者:

	RewriteEngine on
	RewriteCond %{HTTP_HOST} ^www.oldDomain.com [NC]
	RewriteRule ^(.*)$ http://www.newDomain.com/$1 [L,R=301]


### 改变缺省的首页文件

	DirectoryIndex filename.html index.cgi index.pl default.htm

### 阻止IP列表

	allow from all
	deny from 145.186.14.122
	deny from 124.15

### 阻止目录浏览

	Options All -Indexes

### 保护服务器上的文件被存取

	deny from all

### 阻止存取.htaccess 文件

	order allow,deny
	deny from all

### 防盗链

	RewriteEngine On
	#Replace ?example\.com/ with your site url
	RewriteCond %{HTTP_REFERER} !^http://(.+\.)?example\.com/ [NC]
	RewriteCond %{HTTP_REFERER} !^$
	#Replace /images/nohotlink.jpg with your "don't hotlink" image url
	RewriteRule .*\.(jpe?g|gif|bmp|png)$ /images/nohotlink.jpg [L]

### 重定向移动设备 

	RewriteEngine On
	RewriteCond %{REQUEST_URI} !^/m/.*$
	RewriteCond %{HTTP_ACCEPT} "text/vnd.wap.wml|application/vnd.wap.xhtml+xml" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "acs|alav|alca|amoi|audi|aste|avan|benq|bird|blac|blaz|brew|cell|cldc|cmd-" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "dang|doco|eric|hipt|inno|ipaq|java|jigs|kddi|keji|leno|lg-c|lg-d|lg-g|lge-" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT}  "maui|maxo|midp|mits|mmef|mobi|mot-|moto|mwbp|nec-|newt|noki|opwv" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "palm|pana|pant|pdxg|phil|play|pluc|port|prox|qtek|qwap|sage|sams|sany" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "sch-|sec-|send|seri|sgh-|shar|sie-|siem|smal|smar|sony|sph-|symb|t-mo" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "teli|tim-|tosh|tsm-|upg1|upsi|vk-v|voda|w3cs|wap-|wapa|wapi" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "wapp|wapr|webc|winw|winw|xda|xda-" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "up.browser|up.link|windowssce|iemobile|mini|mmp" [NC,OR]
	RewriteCond %{HTTP_USER_AGENT} "symbian|midp|wap|phone|pocket|mobile|pda|psp" [NC]
	#------------- The line below excludes the iPad
	RewriteCond %{HTTP_USER_AGENT} !^.*iPad.*$
	#-------------
	RewriteCond %{HTTP_USER_AGENT} !macintosh [NC] #*SEE NOTE BELOW
	RewriteRule ^(.*)$ /m/ [L,R=302] 
