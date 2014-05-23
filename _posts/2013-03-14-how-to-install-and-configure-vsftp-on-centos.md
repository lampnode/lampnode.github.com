---
layout: post
title: "如何在CentOS中安装与配置Vsftp"
tagline: "How to install and configure vsftp on CentOs"
description: ""
category: Linux 
tags: [ FTP, Linux, CentOs ]
---
{% include JB/setup %}

## 安装 

使用chkconfig --list 来查看是否装有vsftpd服务；使用yum命令直接安装：

### YUM安装	

	yum -y install vsftpd 

### 可选设置

修改默认的日志文件:创建日志文件：

	touch /var/log/vsftpd.log 

这样简单的两个命令就完成了vsftp的安装，但是如果你现在想这样ftp://your_ip来访问的话，那还不行，还需要配置权限！ 

## 启动与配置自启动

启动ftp服务：

	service vsftpd start
	chkconfig --level 2345 vsftpd on

## 配置vsftp服务 

编辑/etc/vsftpd/vsftpd.conf文件，配置vsftp服务： 

	#vim /etc/vsftpd/vsftpd.conf 

### 配置样例
功能:支持匿名访问(Read Only)，同时本地用户可以管理ftp文件

	anonymous_enable=YES		#匿名用户设置
	local_enable=YES		#支持本地用户(必须)		
	write_enable=YES		#支持本地用户(必须)
	local_umask=022			
	anon_upload_enable=NO		#匿名用户设置
	anon_mkdir_write_enable=NO	#匿名用户设置
	dirmessage_enable=YES		
	xferlog_enable=YES		#日志
	connect_from_port_20=YES	
	#chown_uploads=YES
	#chown_username=whoever
	xferlog_file=/var/log/xferlog	#日志
	xferlog_std_format=YES		#日志
	#idle_session_timeout=600
	#data_connection_timeout=120
	#nopriv_user=ftpsecure
	#async_abor_enable=YES
	ascii_upload_enable=YES
	ascii_download_enable=YES
	#deny_email_enable=YES
	#banned_email_file=/etc/vsftpd/banned_emails
	
	#Chroot相关设置，注意/etc/vsftpd/chroot_list是否存在,否则会报错
	chroot_local_user=YES		
	chroot_list_enable=YES
	chroot_list_file=/etc/vsftpd/chroot_list
	
	
	listen=YES
	pam_service_name=vsftpd
	userlist_enable=YES
	tcp_wrappers=YES

### 设置说明

	anonymous_enable=NO #设定不允许匿名访问 
	local_enable=YES #设定本地用户可以访问。注：如使用虚拟宿主用户，在该项目设定为NO的情况下所有虚拟用户将无法访问。 
	chroot_list_enable=YES #使用户不能离开主目录 
	xferlog_file=/var/log/vsftpd.log #设定vsftpd的服务日志保存路径。注意，该文件默认不存在。必须要手动touch出来 
	ascii_upload_enable=YES #允许使用ASCII模式上传 
	ascii_download_enable=YES #设定支持ASCII模式的上传和下载功能。 
	pam_service_name=vsftpd #PAM认证文件名。PAM将根据/etc/pam.d/vsftpd进行认证 

### 修改默认目录

默认配置下，匿名用户登录 vsftpd 服务后的根目录是 /var/ftp/；假设要把 vsftpd 服务的登录根目录调整为 /vae/www/html，可加入如下三行：

	local_root=/var/www/html

任何一个用户ftp登录到这个服务器上都会chroot到/var/www/html目录下。

## 防火墙设置

### Add rules

	iptables -A INPUT -p tcp --sport 1024:65535 --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 21 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
	iptables -A OUTPUT -p tcp --sport 20 --dport 1024:65535 -m state --state ESTABLISHED,RELATED -j ACCEPT
	iptables -A INPUT -p tcp --sport 1024:65535 --dport 20 -m state --state ESTABLISHED -j ACCEPT

### 修改iptables-config

	vi /etc/sysconfig/iptables-config

增加如下项目
	
	IPTABLES_MODULES="ip_conntrack_ftp"

## 用户管理

### 添加用户

假设设置用户ftpuser,这里要求用户只能用ftp登录，禁止ssh登录，同时修改其默认登录目录到 /var/www

	 #useradd ftpuser -r -m -g ftp -d /var/www/ -s /sbin/nologin
	 #passwd ftpuser
	
### 修改用户目录

	#usermod  -d /var/www/  ftpuser

## Debug

### Error A

	vsftpd 500 OOPS: cannot change directory:/home/ftp/%user%

try change some lines in file "/etc/sysconfig/iptables-config"

	IPTABLES_MODULES="ip_conntrack_netbios_ns ip_conntrack_ftp ip_nat_ftp"

then restart iptables: 
	
	#service iptables restart

