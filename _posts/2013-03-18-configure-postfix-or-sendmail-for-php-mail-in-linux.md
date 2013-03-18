---
layout: post
title: "在Linux上为PHP的mail函数配置Postfix或者Sendmail"
tagline: "Configure Postfix or Sendmail for PHP mail() in Linux"
description: ""
category: Linux
tags: [PHP, Postfix, Linux ]
---
{% include JB/setup %}

实际上，为PHP的mail函数配置Postfix或者Sendmail的方法是一样的。两者都是执行"/usr/sbin/sendmail"程式。

## 设置PHP
编辑php.ini文件

	; For Unix only.  You may supply arguments as well (default: "sendmail -t -i").
	; http://php.net/sendmail-path
	sendmail_path = "/usr/sbin/sendmail -t -i"
 

保存后并重启httpd服务才可生效。

## 测试
通过如下命令测试:

	echo Hello | mail -s Test  my@gmail.com
