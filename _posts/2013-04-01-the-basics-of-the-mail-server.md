---
layout: post
title: "邮件服务器的基础知识"
tagline: "The basics of the mail server"
description: ""
category: Linux
tags: [ Linux, Mail ]
---
{% include JB/setup %}


## 电子邮件的传输流程

### 基本构成

#### MUA ( Mail User Agent )

MUA是一个邮件系统的客户端程序，它提供了阅读、发送和接受电子邮件的用户接口。MUA也是用户和MTA之间的接口。常用软件：outlook、foxmail.MUA至少具有如下3个功能： 撰写邮件, 显示邮件, 处理邮件.

#### MTA：Mail Transfer Agent

MTA主要负责邮件的存贮和转发，常用软件：windows下的exchange 和linux下的sendmail、qmail、postfix

MTA功能：

- 接受和传递由客户端发送的邮件
- 维护邮件队列，以便客户端不必一直等到邮件真正发送出去
- 接收客户的邮件，并将邮件放置在缓冲区存储，知道用户链接从而收取邮件
- 有选择的转发和拒绝转发接受到的、目的地为另一个主机的消息


#### MDA ( Mail Delivery Agent )

主要的功能就是将MTA接收的信件依照信件的流向（送到哪里）将该信件放置到本机账户下的邮件文件中（收件箱），或者再经由MTA将信件送到下个MTA。如果信件的流向是到本机，这个邮件代理的功能就不只是将由MTA传来的邮件放置到每个用户的收件箱，它还可以具有邮件过滤（filtering）与其他相关功能。

### 流程

了解了MUA，MTA与MDA之后，下面说说如何将信寄出去。可以分为几个步骤。假设当前我们有个发信人Tom（tom@server1.com）要发送一封邮件给Anna( anna@server1.com ) 与Jack(jack@server2.com )

#### Step 1: 发信人利用MUA寄信到MTA

Tom使用Outlook,写了一封电子邮件，同时发送给Anna与Jack.

#### Step 2: MTA处理MUA发出的信件

- 如果是本域的邮件(anna@server1.com)，直接交由本域的MDA
- 如果是外域的邮件(jack@server2.com)，MTA将该邮件转送出去，到达目标MTA，再有该MTA转给自己的MDA

#### Step 3: MDA处理分发邮件

MDA根据邮件的用户信息，分发到目标用户的MailBox

- anna@server1.com转给了用户Anna的Mailbox，等待Anna使用MUA获取本邮件
- jack@server2.com转给了用户Jack,等待Jack使用MUA获取本邮件

#### Step 4: 收信人MUA接收邮件

Anna与Jack使用Outlook收取邮件。

## 使用协议

### SMTP (Simple Mail Transfer Protocol )

简单邮件传输协议,它是一组用于由源地址到目的地址传送邮件的规则，由它来控制信件的中转方式。SMTP协议属于TCP/IP协议族，它帮助每台计算机在发送或中转信件时找到下一个目的地。SMTP 是一种TCP协议支持的提供可靠且有效电子邮件传输的应用层协议。SMTP 是建立在 TCP上的一种邮件服务，主要用于传输系统之间的邮件信息并提供来信有关的通知。

在传输文件过程中使用端口：25

SMTP的命令和响应都是基于文本，以命令行为单位，换行符为CR/LF。响应信息一般只有一行，由一个3位数的代码开始，后面可附上很简短的文字说明。

SMTP要经过建立连接、传送邮件和释放连接3个阶段。具体为：

- 建立TCP连接。
- 客户端向服务器发送HELLO命令以标识发件人自己的身份，然后客户端发送MAIL命令。
- 服务器端以OK作为响应，表示准备接收。
- 客户端发送RCPT命令。
- 服务器端表示是否愿意为收件人接收邮件。
- 协商结束，发送邮件，用命令DATA发送输入内容。
- 结束此次发送，用QUIT命令退出。

SMTP服务器基于DNS中的邮件交换（MX）记录路由电子邮件。电子邮件系统发邮件时是根据收信人的地址后缀来定位邮件服务器的。SMTP通过用户代理程序（UA）完成邮件的编辑、收取和阅读等功能；通过邮件传输代理程序（MTA）将邮件传送到目的地。

### POP3 ( Post Office Protocol Version 3 )

是TCP/IP协议族中的一员，由RFC1939 定义。本协议主要用于支持使用客户端远程管理在服务器上的电子邮件。提供了SSL加密的POP3协议被称为POP3S。

POP3协议默认端口：110

POP 协议支持“离线”邮件处理。其具体过程是：邮件发送到服务器上，电子邮件客户端调用邮件客户机程序以连接服务器，并下载所有未阅读的电子邮件。这种离线访问模式是一种存储转发服务，将邮件从邮件服务器端送到个人终端机器上，一般是 PC机或 MAC。一旦邮件发送到 PC 机或 MAC上，邮件服务器上的邮件将会被删除。但目前的POP3邮件服务器大都可以“只下载邮件，服务器端并不删除”，也就是改进的POP3协议。 

## 邮件转发 Mail relay

设置好一个email服务器以后，该服务器将具有一个或若干个域名，这时email服务器将监听25号端口，等待远程的发送邮件的请求。网络上其他的mail服务器或者请求发送邮件的MUA(Mail User Agent,如outlook express、foxmail等等)会连接email服务器的25号端口，请求发送邮件，SMTP会话过程一般是从远程标识自己的身份开始，过程如下：

	HELO server1.com
	250 server1.com
	MAIL FROM：jack@server1.com
	250 OK
	RCPT TO: anna@server1.com

邮件的接收者anna@server1.com是本地域名，这时候本地系统接受它：
250 OK
如果不是本地域名，将拒绝接受它:
553 sorry,.that domain isnot in my domain list of allowed recphosts

第一种情况下，本地email服务器是允许relay的，它接收并同意传递一个目的地址不属于本地域名的邮件；而第二种情况则不接收非本地邮件。 

Email一般都有一个配置文件，其决定了是否接受一个邮件。只有当一个RCPT TO命令中的接收者地址的域名存在于该文件中时，才接受该邮件,否则就拒绝该邮件。若该文件不存在，则所有的邮件将被接受。当一个邮件服务器不管邮件接收者和邮件接收者是谁，而是对所有邮件进行转发(relay)，则该邮件服务器就被称为开放转发(open relay)的。当email服务器没有设置转发限制时，其是开放转发的。


 


