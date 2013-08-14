---
layout: post
title: "ModSecurity错误: Request body is larger than the configured limit"
tagline: "ModSecurity: Request body is larger than the configured limit"
description: ""
category: apache
tags: [ Apache ]
---
{% include JB/setup %}

安装了ModSecurity的httpd,在上传大文件的时候会报如下错误:

	Request body is larger than the configured limit (134217728).

这个错误主要是由于请求的主题的默认大小超过了ModSecurity的限制所造成，解决这个问题，有两种办法:

参考: http://httpd.apache.org/docs/2.0/mod/core.html#limitrequestbody

## 添加.htaccess

修改如下参数:

	LimitRequestBody 0 ## unlimited up to 2GB
	LimitRequestBody 2097152 ## 2 MB, decent default for many cases.

and save this file. If you increased the size correctly the page should now be working.

## 或者修改modsecurity的配置文件

	vim /etc/httpd/conf.d/mod_security.conf

同样修改如上2个参数即可。
