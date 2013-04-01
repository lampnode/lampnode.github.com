---
layout: post
title: "如何使用Zend_Mail实现快速发送邮件"
tagline: "HowTo use Zend_Mail to send e mail quickly"
description: ""
category: PHP 
tags: [PHP, Mail, Zend Framework ]
---
{% include JB/setup %}

## 关于Zend_Mail

Zend_Mail提供了通用化的功能来创作和发送文本以及兼容MIME标准的含有多个段的邮件消息。 Zend_Mail通过php内建的mail()函数或者直接通过SMTP连接来发送邮件。这里主要是介绍前一种使用方法。

## 测试环境

- CentOs 6.x
- Postfix 
- PHP 5.2.x

## 代码
一个简单邮件由一个或者几个收件人，一个主题，一个邮件主体和一个发件人组成。 下面的步骤，使用了PHP的mail()函数来发送邮件：
{% highlight php %}
<?php
require_once 'Zend/Mail.php';
$mail = new Zend_Mail();
$mail->setBodyText('This is the text of the mail.');
//不使用setFrom()的时候，将使用postfix的默认参来发送邮件
#$mail->setFrom('somebody@example.com', 'Some Sender'); 
$mail->addTo('somebody_else@example.com', 'Some Recipient');
$mail->setSubject('TestSubject');
$mail->send();
?>   
{% endhighlight %}

这种方法只能用户Linux环境(系统支持mail函数)，如果在Windows下使用的话，由于没有所支持的环境，PHP会报一个类似如下的错误:

	Unable to send mail. mail() [<a href='function.mail'>function.mail</a>]: &quot;sendmail_from&quot; not set in php.ini or custom &quot;From:&quot; header missing

