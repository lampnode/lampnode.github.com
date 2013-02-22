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

### 网站部署结构

#### IP访问

针对IP访问要预留出一个设置，便于其访问，一般使用默认即可,所以 "/var/www/html"保留即可.

#### 域名访问

服务器上的主要服务基本上都是基于域名访问的，如果使用IP不是一个明智的方法。所以，良好的部署基于域名访问的网站是不可或却的服务器部署策略。部署的主要注意事项：


* 网站应放在非系统硬盘上，便于备份与系统应急恢复
* 网站应该具有统一的目录结构
* 网站的管理用户避免使用ROOT



### 虚拟机配置

打开文件 /etc/httpd/conf/httpd.conf, 搜索 VirtualHost example, 在其后面根据你的需求增加如下代码:

{% highlight bash %}

	<VirtualHost *:80>
	    #ServerAdmin your.mail@domain.com
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
