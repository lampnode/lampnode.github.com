---
layout: post
title: "使用SSH Keygen实现SSH无密码登录"
tagline: "SSH Passwordless Login Using SSH Keygen"
description: ""
category: Linux
tags: [Linux]
---
{% include JB/setup %}

## 概述
1. 让两个linux机器之间使用ssh不需要用户名和密码。采用了数字签名RSA或者DSA来完成这个操作
2. 模型分析
假设 A （192.168.0.1）为客户机器，B（192.168.0.2）为目标机；

## 目的
A机器ssh登录B机器无需输入密码；
加密方式选 rsa|dsa均可以，默认dsa

## 方法
### Step 1: Create Authentication SSH-Kegen Keys on – (192.168.1.1)
First login into server 192.168.1.1 with user tecmint and generate a pair of public keys using following command.
	
	$ ssh-keygen -t rsa

Generating public/private rsa key pair.
{% highlight bash %}


Enter file in which to save the key (/home/tecmint/.ssh/id_rsa): [Press enter key]
Created directory '/home/tecmint/.ssh'.
Enter passphrase (empty for no passphrase): [Press enter key]
Enter same passphrase again: [Press enter key]
Your identification has been saved in /home/tecmint/.ssh/id_rsa.
Your public key has been saved in /home/tecmint/.ssh/id_rsa.pub.
The key fingerprint is:
af:bc:25:72:d4:04:65:d9:5d:11:f0:eb:1d:89:50:4c tecmint@tecmint.com
The key's randomart image is:
+--[ RSA 2048]----+
|        ..oooE.++|
|         o. o.o  |
|          ..   . |
|         o  . . o|
|        S .  . + |
|       . .    . o|
|      . o o    ..|
|       + +       |
|        +.       |
+-----------------+
{% endhighlight %}

### Step 2: Create .ssh Directory on – 192.168.1.2
Use SSH from server 192.168.1.1 to connect server 192.168.1.2 using sheena as user and create .ssh directory under it, using following command.
{% highlight bash %}
$ ssh sheena@192.168.1.2 mkdir -p .ssh
{% endhighlight %}

The authenticity of host '192.168.1.2 (192.168.1.2)' can't be established.

{% highlight bash %}
RSA key fingerprint is d6:53:94:43:b3:cf:d7:e2:b0:0d:50:7b:17:32:29:2a.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.1.2' (RSA) to the list of known hosts.
sheena@192.168.1.2's password: [Enter Your Password Here]
{% endhighlight %}

### Step 3: Upload Generated Public Keys to – 192.168.1.2

Use SSH from server 192.168.1.1 and upload new generated public key (id_rsa.pub) on server 192.168.1.2 under sheena‘s .ssh directory as a file name authorized_keys.

{% highlight bash %}
$ cat .ssh/id_rsa.pub | ssh sheena@192.168.1.2 'cat >> .ssh/authorized_keys'
sheena@192.168.1.2's password: [Enter Your Password Here]
{% endhighlight %}

### Step 4: Set Permissions on – 192.168.1.2
Due to different SSH versions on servers, we need to set permissions on .ssh directory and authorized_keys file.

{% highlight bash %}
$ ssh sheena@192.168.1.2 "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
sheena@192.168.1.2's password: [Enter Your Password Here]
{% endhighlight %}

### Step 5: Login from 192.168.1.1 to 192.168.1.2 Server without Password
From now onwards you can log into 192.168.1.2 as sheena user from server 192.168.1.1 as tecmint user without password.

{% highlight bash %}
$ ssh sheena@192.168.1.2
{% endhighlight %}
