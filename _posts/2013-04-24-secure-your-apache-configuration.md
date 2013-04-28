---
layout: post
title: "保护你的Apache配置"
tagline: "Secure your Apache Configuration"
description: ""
category: Linux
tags: [ Apache, Linux ]
---
{% include JB/setup %}

## 隐藏Apache的敏感信息
隐藏Apache的版本号，和其他敏感信息。

默认情况下，许多Apache安装的时候，会暴露操作系统/正在运行的版本，甚至是安装在服务器上的Apache模块。攻击者可以利用此信息对自己有利的时候进行攻击。


有两个指令，你需要添加或编辑你的httpd.conf文件中：

	ServerSignature Off
	ServerTokens Prod

其中, ServerSignature由apache生成出现在页面的底部。例如 404页面，目录列表等。ServerTokens指令用于apache设置服务器的http respose header.当将其设置为prod的时候，HTTP header将显示:

	Server: Apache

## 确保Apache是运行在它自己的用户帐户和组

安装后的apache默认以以nobody用户身份运行,这是不安全的，需要你增加一个用户(组)来给apache作为用户使用。
我们使用 webservices作为apache运行的用户（组),设置步骤如下:

### 添加用户与组

	#groupadd webservices
	#useradd webservices -g webservices -d /dev/null -s /sbin/nologin
	useradd: warning: the home directory already exists.
	Not copying any file from skel directory into it.
	
	#tail /etc/passwd
	......
	webservices:x:501:501::/dev/null:/sbin/nologin	

### 修改apache的配置文件


	User webservices
	Group webservices

### 设置web目录权限

	#chmod -R webservice:webservice /var/www/html	

### 重启服务器

	$/etc/init.d/httpd restart

## 确保Web根目录以外的文件没有访问权限

我们不希望Apache能够访问其网站根出方的任何文件。因此，假设所有的网站都放在一个目录下（/web），你将其设置如下：

### 针对根目录的设置
	<Directory />
	  Order Deny,Allow
	  Deny from all
	  Options None
	  AllowOverride None
	</Directory>

### 针对web目录的设置


	<Directory /web>
	  Order Allow,Deny
	  Allow from all
	</Directory>


### Options 的项目
#### 关闭目录浏览

可以在Directory标签的Options，设置为None或者-Indexes


	Options -Indexes # or None


#### 关闭服务端引用

可以在Directory标签的Options，设置为None或者-Includes


	Options -Includes


#### 关闭CGI执行

如果你不使用CGI，那就关闭它，在Directory标签的Options，设置为 None 或者 -ExecCGI

	Options -ExecCGI

#### 禁止符号链接(symbolic links)

在Directory标签的Options，设置为 None 或者 -FollowSymLinks

	Options -FollowSymLinks

#### 关闭多个选项

如果您想一次关闭所有选项，可以使用:

	Options None

或者，您想选择性关闭:

	Options -ExecCGI -FollowSymLinks -Indexes

### AllowOverride的选项

#### 关闭支持.htaccess文件


	AllowOverride None

If you require Overrides ensure that they cannot be downloaded, and/or change the name to something other than .htaccess. For example we could change it to .httpdoverride, and block all files that start with .ht from being downloaded as follows:

	AccessFileName .httpdoverride
	<Files ~ "^\.ht">
	    Order allow,deny
	    Deny from all
	    Satisfy All
	</Files>

#### 阻止版本控制的目录的访问

##### CVS

	<DirectoryMatch /CVS/>
		Order Allow, Deny
		Deny from all
	</DirectoryMatch>

##### svn

	<Files ".svn">
	    Order allow,deny
	    Deny from all
	</Files>
	<DirectoryMatch "/\.svn/">
	    Order allow,deny
	    Deny from all
	</DirectoryMatch>

## 启用 mod_security

ModSecurity是一个入侵侦测与防护引擎，它主要是用于Web 应用程序，所以也被称为Web应用程序防火墙。

### Mod_security的功用:

- Simple filtering
- Regular Expression based filtering
- URL Encoding Validation
- Unicode Encoding Validation
- Auditing
- Null byte attack prevention
- Upload memory limits
- Server identity masking
- Built in Chroot support

### 安装

#### YUM

	#yum install mod_security

#### reboot 

	#/etc/init.d/httpd restart


### 使用Chroot环境

#### 标准途径

ModSecurity包含对Apache文件系统隔离，或叫chrooting的支持。Chrooting是将应用程序限制在文件系统指定部分的过程(jail)。一旦采用了chroot操作，应用程序就不能再访问jail外的内容。只有root用户可以越狱。

Chrooting过程的一个重要部分就是在监狱中不允许任何和root有关的东西（root进程或root suid命令）。这个思想是如果是一个攻击者试图通过web服务器闯入的话，他没有太多事情可作，因为他也在监狱里，没有办法逃出去。

应用程序不是必须支持chrooting。任何应用程序可以用chroot命令来被chroot。下列行：

        chroot /chroot/apache /usr/local/web/bin/apachectl start

将用/chroot/apache内的内容替换文件系统后再启动Apache。

不幸的是，事情不是这么简单。问题是应用程序通常需要共享库，和其他各种文件和命令来以便正常工作。所以，为了让它们工作，你必须拷贝需要的文件，使它们在监狱中可用。>这不是一个简单的任务（关于如何chroot Apache web服务器的详细介绍，请看这里http://penguin.epfl.ch/chroot.html）。

#### mod_security提供的方法

mod_security模块里加入了chrooting功能，使整个过程不那么复杂了。你使用手头的mod_security，你只需在配置文件中添加一行：

        secChrootDir /chroot/apache

你的web服务器就会被成功地chroot了。

除了简单以外，mod_security的chrooting还带来了另一个优势。与外部的chrooting（前边提到的）不同，mod_security的chrooting不需要在监狱中存在额外的文件。Chroot调用生在web服务器的初始化之后，派生（子进程）之前。因此，所有的共享库都已经被加载了，所有的web服务器模块都已经初始化了，所有的日志文件都已经打开了。你只需要把自己>在监狱里的数据。

Apache用于认证（authentication）的文件必须放在监狱内部，因为它们会在每次收到请求的时候被打开。


## 限制只有root才可以读取配置文件与执行文件


	chown -R root:root /usr/local/apache
	chmod -R o-rwx /usr/local/apache

## 应用参数调整
	
### 降低Timeout值

默认情况下，Timeouot 设置为300秒。您可以减少有助于减轻拒绝服务攻击的潜在影响。

	Timeout 45

### 限制请求

Apache有几个指令可以使你的限制请求的大小，这也可以用于减轻拒绝服务攻击的效果。


#### LimitRequestBody

此指令默认设置为无限制。如果您允许文件上传不大于1MB，可以将此设置类似：

	LimitRequestBody 1048576

如果你没有让文件上传，你可以设置更小。


#### LimitXMLRequestBody

如果您正在运行mod_dav的（通常用于subversion），那么你可能想要限制的XML请求主体的最大规模。


	LimitXMLRequestBody 10485760


#### 限制并发

Apache有一些配置设置，可用于调整处理并发请求。
Apache has several configuration settings that can be used to adjust handling of concurrent requests. 

- MaxClients 是设置服务请求将要创建子进程的最大数量。这可能设置得太高，如果你的服务器没有足够的内存来处理大量的并发请求。
- MaxSpareServers
- MaxRequestsPerChild

在Apache2,如下是很重要的调节，以满足您的操作系统和硬件。

- ThreadsPerChild
- ServerLimit
- MaxSpareThreads 



## 通过IP限制访问

根据网段:

	Order Deny,Allow
	Deny from all
	Allow from 176.16.0.0/16

根据IP:

	Order Deny,Allow
	Deny from all
	Allow from 127.0.0.1



