---
layout: post
title: "如何在CentOS上安装设置postifx与dovecot"
tagline: "How to setup postifx and dovecot on CentOs"
description: ""
category: Linux
tags: [CentOs, Postfix ]
---
{% include JB/setup %}

## Install

### install by yum

	[root@server ]#yum install postfix dovecot system-switch-mail -y 
	
### Configure postfix

	[root@server]# vim /etc/postfix/main.cf

{% highlight bash %}
myhostname = localhost  //76行，将等号后面的部分改写为本机主机名  
mydomain = server.com   //82行，设置域名  
myorigin = $mydomain   //97行，把$myhostname改为$mydomain  
inet_interfaces = all  //112行，把后面的localhost改成all  
mydestination = $myhostname, localhost.$mydomain, localhost,$mydomain //163行，把前面的注释拿掉，并加一下$mydomain  
mynetworks = 192.168.0.0/24, 127.0.0.0/8  //263行，设置内网和本地IP  
local_recipient_maps =  //209行，把前面的注释拿掉。  
smtpd_banner = $myhostname ESMTP unknow //568行，把前面的注释拿掉，然后把$mail_name ($mail_version)改成unknow  
  
//在main.cf文件的底部加上以下内容  
smtpd_sasl_auth_enable = yes     //使用SMTP认证  
broken_sasl_auth_clients = yes   //让不支持RFC2554的smtpclient也可以跟postfix做交互。  
smtpd_sasl_local_domain = $myhostname  // 指定SMTP认证的本地域名  
smtpd_sasl_security_options = noanonymous //取消匿名登陆方式  
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination //设定邮件中有关收件人部分的限制  
smtpd_sasl_security_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination //设置允许范围  
message_size_limit = 15728640     //邮件大小  
mailbox_transport=lmtp:unix:/var/lib/imap/socket/lmtp   //设置连接cyrus-imapd的路径 
{% endhighlight %}


### switch from sendmail to postfix
	
	[root@server ]# system-switch-mail

### Remove sendmail

	[root@server ]# yum remove sendmail


