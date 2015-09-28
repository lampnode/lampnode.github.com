---
layout: post
title: "如何在CentOS上安装设置postifx"
tagline: "How to setup postifx on CentOs"
description: ""
category: Linux
tags: [CentOs, Postfix ]
---
{% include JB/setup %}
## 基本知识

在设置Postfix之前，需要对[Mail server的基础知识](/Linux/the-basics-of-the-mail-server/)进行一些了解。



## Install

postfix是CentOS常用的邮件服务器软件。以下配置示例假设要配置的域名是server.com，邮件服务器主机名是mail.server.com(域名server.com需要增加一条MX记录，指向mail.server.com)

	server.com      MX preference = 5, mail exchanger = mail.server.com


### 安装相关软件包

	[root@server ]#yum install postfix dovecot system-switch-mail -y 

### Remove sendmail

        [root@server ]# yum remove sendmail

或者

	[root@server ]# rpm -e sendmail
	
### 配置 postfix

Postfix的配置项目比较多，不过基本配置或者说必须设定的配置，有如下几项:主机名称设定,发送来源的主机名称设定,收件的主机名称设定,Relay 基础设置等。

使用编辑器，打开Postfix的主配置文件:

	[root@server]# vim /etc/postfix/main.cf

所需修改参数如下:

#### 主机名称设定

主机名称设定包含myhostname与mydomain两个参数的设置，这个非常重要，而且最好与DNS的相关配置相对应。

##### myhostname

myhostname参数是指系统的主机名称（如我的服务器主机名称是mail.server.com）

	myhostname = mail.server.com

##### mydomain

mydomain参数是指email服务器的域名，请确保为正式域名

	mydomain = server.com

#### 发送来源的主机名称设定

myorigin参数指定本地发送邮件中来源和传递显示的域名。在我们的例子中是我的域名。我们的邮件
地址是user@server.com而不是user@mail.server.com。

	myorigin = $mydomain  (send mail as "user@$mydomain")

当设定为 

	myorigin = $myhostname (send mail as "user@$myhostname")

我们的邮件地址是user@mail.server.com而不是user@server.com。

#### 收件的主机名称设定

mydestination参数指定哪些邮件地址允许在本地发送邮件。这是一组被信任的允许通过服务器发送或传递邮件的IP地址
用户试图通过发送从此处未列出的IP地址的原始服务器的邮件将被拒绝

	mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

这里添加了$mydomain

#### Relay 基础设置

这里包含inet_interfaces mynetworks_style mynetworks relay_domains等参数

##### inet_interfaces

inet_interfaces参数设置网络接口以便Postfix能接收到邮件。

	inet_interfaces = all

##### inet_protocols

注意ipv4的大小写.

	inet_protocols = ipv4

如果使用all的话，会有如下报错：

	sendmail: warning: inet_protocols: IPv6 support is disabled: Address family 
	not supported by protocol
	sendmail: warning: inet_protocols: configuring for IPv4 support only
	postdrop: warning: inet_protocols: IPv6 support is disabled: Address family 
	not supported by protocol
	postdrop: warning: inet_protocols: configuring for IPv4 support only

##### mynetworks

mynetworks参数指定受信任SMTP的列表，具体的说，受信任的SMTP客户端允许通过Postfix传递邮件。

	mynetworks =  127.0.0.0/8  (safe: authorize local machine only)

Examples:

	mynetworks_style = subnet  (default: authorize subnetworks)
	mynetworks_style = host    (safe: authorize local machine only)
	mynetworks = 127.0.0.0/8 168.100.189.2/32 (authorize local machine) 

**请注意:**
 - 如果你没有设定 mynetworks 的话，一定要将 mynetworks_style 设定为 host, 不然你的 IP 所在的子域的 IP 会被自动的认为是合法的.
 - 如果是专职的发信服务器,需要设置为: mynetworks =  127.0.0.0/8, 否则会报类似错误(其中 user@example.com是收件人):

	javax.mail.SendFailedException: Invalid Addresses
		at com.sun.mail.smtp.SMTPTransport.rcptTo(SMTPTransport.java:1294) ~[mail-1.4.1.jar:1.4.1]
		at com.sun.mail.smtp.SMTPTransport.sendMessage(SMTPTransport.java:635) ~[mail-1.4.1.jar:1.4.1]
		at javax.mail.Transport.send0(Transport.java:189) ~[mail-1.4.1.jar:1.4.1]
		at javax.mail.Transport.send(Transport.java:118) ~[mail-1.4.1.jar:1.4.1]
		at org.easycore.mail.sender.ExpressMailSender.sendMail(ExpressMailSender.java:69) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.mail.sender.AbstractMailSender.send(AbstractMailSender.java:110) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.mail.sender.ExpressMailSender.send(ExpressMailSender.java:25) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.mail.MailSender.send(MailSender.java:100) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.app.jourcore.cmd.EmailCommand.execute(EmailCommand.java:64) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.cli.toolkit.cmd.CommandExecutor.run(CommandExecutor.java:30) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.app.jourcore.JourcoreToolkit.execute(JourcoreToolkit.java:85) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.cli.toolkit.AbstractToolkit.run(AbstractToolkit.java:81) [JourcoreToolkit.jar:5.09.21]
		at org.easycore.app.jourcore.JourcoreToolkit.main(JourcoreToolkit.java:34) [JourcoreToolkit.jar:5.09.21]
	Caused by: com.sun.mail.smtp.SMTPAddressFailedException: 554 5.7.1 <user@example.com>: Relay access denied


##### Relay_domains

relay_domains是系统传递邮件的目的域名列表。如果留空，我们保证了我们的邮件服务器不对不信任的网络开放。

	relay_domains =   (safe: never forward mail from strangers)

Other Examples:

	relay_domains = $mydestination (default)
	relay_domains = $mydomain (forward mail to my domain and subdomains)

#### 可选设置

##### home_mailbox

	home_mailbox = Maildir/

##### mail_spool_directory

设置mail_spool_directory，/data是之前挂载的数据盘(尽量避免使用系统磁盘)，mail目录需要通过mkdir命令创建

	mail_spool_directory = /data/mail

## 测试Postfix

### 测试是否启动服务
	
	service postfix status
	master (pid 4073) is running...

如果没有使用service postfix start启动

### 检测smtp端口是否已经监听

	netstat -an | grep 25
	tcp 0 0 0.0.0.0:25 0.0.0.0:* LISTEN

### 设置postfix开机启动

	chkconfig postfix on

## 邮件别名设置

设置邮件别名可以使多个用户收到来自一个用户（如root）发送的邮件。

### 配置邮件别名
邮件别名的配置文件在/etc/aliases里，格式如下：

	# 要接收 root 的电邮的人
	root:           john
	# 用户别名
	jsmith:         john
	j.smith:        john

例1：重新发送邮件到另一用户

	root:root,james

上面的例子表示，root用户的邮件对于用户james和root都可以接收到。


### 使用"newaliases"命令激活邮件别名功能

当我们编辑/etc/aliases文件后，必须执行"newaliases"命令来更新别名数据库。

### DNS配置

虽然不加DNS解析也能把邮件发出去，但会被大多数邮件服务器当作垃圾邮件。根据我们的实际经验，需要添加三条DNS解析记录：A记录:、MX记录、TXT记录。

### Test

	echo "mail content" | mail -s test admin@example.com

## 常用辅助工具

### 显示待寄邮件的队列

mailq可列出待寄邮件的清单，包括邮件ID，邮件大小，邮件保存时间，寄信人，收信人，以及邮件无法寄出的原因，提供管理员参考的信息。mailq实际上是执行sendmail -bp指令.

	$ mailq

样例输出：

	-Queue ID- --Size-- ----Arrival Time---- -Sender/Recipient-------
	80B1016047F     3411 Sun Sep 27 08:30:38  websrvs@cerebromed.com
	(host relay.uni-example1.com[168.192.100.212] said: 451 4.1.8 Fix reverse DNS for 168.192.220.232 (in reply to MAIL FROM command))
                                         guido.jch@example2.com
	.....

### 清除邮件队列

#### 全部删除

	$ postsuper -d ALL
	postsuper: Deleted: 69 messages

#### 删除个例

	$postsuper -d Queue_ID


