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
