---
layout: post
title: "如何配置Apache虚拟机"
tagline: "How To Setup Apache Virtual Host Configuration"
description: ""
category: Apache 
tags: [ Httpd ]
---
{% include JB/setup %}


虚拟主机 (Virtual Host) 是在同一台机器搭建属于不同域名或者基于不同 IP 的多个网站服务的技术. 可以为运行在同一物理机器上的各个网站指配不同的 IP 和端口, 也可让多个网站拥有不同的域名.

## 设置步骤

### 配置

打开文件 /etc/httpd/conf/httpd.conf, 搜索 VirtualHost example, 在其后面根据你的需求增加如下代码:

{% highlight bash %}

	<VirtualHost *:80>
	    ServerAdmin edwin.chain@gmail.com
	    DocumentRoot "/your/doc/base/path"
	    ServerName www.yourdomain.com
	    ServerAlias yourdomain.com yourdomain.org
	    ErrorLog "logs/yourdomain.com-error.log"
	    CustomLog "logs/yourdomain.com-access.log" common
	    <Directory "/your/doc/base/path">
		Options Indexes FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	    </Directory>
	</VirtualHost>

{% endhighlight %}

### 重启服务

	service httpd restart
