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
假设 A （192.168.1.1）为客户机器(Client)，B（192.168.1.2）为目标机(Server)；

## 目的
A机器ssh登录B机器无需输入密码；
加密方式选 rsa|dsa均可以，默认dsa

## 方法
### Step 1: 在Client (192.168.1.1) 创建 Authentication SSH-Kegen Keys
First login into client 192.168.1.1 with user edwin and generate a pair of public keys using following command.
	
	$ ssh-keygen -t rsa

Generating public/private rsa key pair.
{% highlight bash %}

Enter file in which to save the key (/home/edwin/.ssh/id_rsa): [Press enter key]
Created directory '/home/edwin/.ssh'.
Enter passphrase (empty for no passphrase): [Press enter key]
Enter same passphrase again: [Press enter key]
Your identification has been saved in /home/edwin/.ssh/id_rsa.
Your public key has been saved in /home/edwin/.ssh/id_rsa.pub.
The key fingerprint is:
af:bc:25:72:d4:04:65:d9:5d:11:f0:eb:1d:89:50:4c edwin@lampnode.com
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


### Step 2: Copy the public key to remote-host

#### 方法1

##### Copy the public key to remote-host using ssh-copy-id

{% highlight bash %} 
$ ssh-copy-id -i ~/.ssh/id_rsa.pub robert@192.168.1.2

robert@192.168.1.2's password:
Now try logging into the machine, with "ssh 'remote-host'", and check in:
ssh/authorized_keys
to make sure we haven't added extra keys that you weren't expecting.
{% endhighlight %}


#### 方法2

##### 在 Server(192.168.1.2)上创建.ssh
Use SSH from server 192.168.1.1 to connect server 192.168.1.2 using robert as user and create .ssh directory under it, using following command.

{% highlight bash %}
$ ssh robert@192.168.1.2 mkdir -p .ssh
{% endhighlight %}

The authenticity of host '192.168.1.2 (192.168.1.2)' can't be established.

{% highlight bash %}

RSA key fingerprint is d6:53:94:43:b3:cf:d7:e2:b0:0d:50:7b:17:32:29:2a.
Are you sure you want to continue connecting (yes/no)? yes

Warning: Permanently added '192.168.1.2' (RSA) to the list of known hosts.
robert@192.168.1.2's password: [Enter Your Password Here]
{% endhighlight %}

##### 上传公共 Keys到 Server (192.168.1.2)

Use SSH from Client 192.168.1.1 and upload new generated public key (id_rsa.pub) on server 192.168.1.2 under robert‘s .ssh directory as a file name authorized_keys.

{% highlight bash %}

$ cat .ssh/id_rsa.pub | ssh robert@192.168.1.2 'cat >> .ssh/authorized_keys'
robert@192.168.1.2's password: [Enter Your Password Here]

{% endhighlight %}

##### 在 Server （192.168.1.2）设置权限
Due to different SSH versions on servers, we need to set permissions on .ssh directory and authorized_keys file.

{% highlight bash %}
	$ ssh rpbert@192.168.1.2 "chmod 600 .ssh; chmod 660 .ssh/authorized_keys"
	robert@192.168.1.2's password: [Enter Your Password Here]
{% endhighlight %}

### Step 3: 测试

From now onwards you can log into 192.168.1.2 as robert user from server 192.168.1.1 as tecmint user without password.

{% highlight bash %}
	$ ssh robert@192.168.1.2
{% endhighlight %}
