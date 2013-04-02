---
layout: post
title: "如何启用MySQL数据库服务器的远程访问"
tagline: "HowTo enable remote access to MySQL database server"
description: ""
category: MySQL
tags: [ MySQL, Linux]
---
{% include JB/setup %}

预设的MySQL服务器只能让本机联机，其他人如果想要从别的机器连到MySQL服务器需要更改如下设置。

## 步骤

###  查看/编辑my.cnf

使用vim打开 /etc/my.cnf:

	# vim /etc/my.cnf

查看bind-address参数设置情况，格式如下:

	bind-address=YOUR-SERVER-IP

如果要开放所有的机器联机，只要改成下面这个设定值就可以了

	bind-address=0.0.0.0
 
如果要限定某网卡可以与MySQL服务器建立联机，可以改成下面的设定，意思是允许192.168.0.1这个ip的网卡，与MySQL建立联机

	bind-address=192.168.0.1

参看:[MySQL 5.1 Reference Manual::Server Command Options](http://dev.mysql.com/doc/refman/5.1/en/server-options.html)

> The MySQL server listens on a single network socket for TCP/IP connections. This socket is bound to a single address, but it is possible for an address to map onto multiple network interfaces. The default address is 0.0.0.0. To specify an address explicitly, use the --bind-address=addr option at server startup, where addr is an IPv4 address or a host name. If addr is a host name, the server resolves the name to an IPv4 address and binds to that address.

> The server treats different types of addresses as follows:

> If the address is 0.0.0.0, the server accepts TCP/IP connections on all server host IPv4 interfaces.

> If the address is a “regular” IPv4 address (such as 127.0.0.1), the server accepts TCP/IP connections only for that particular IPv4 address.

> If you intend to bind the server to a specific address, be sure that the mysql.user grant table contains an account with administrative privileges that you can use connect to that address. Otherwise, you will not be able to shut down the server. For example, if you bind to 0.0.0.0, you can connect to the server using all existing accounts. But if you bind to 127.0.0.1, the server accepts connections only on that address. In this case, first make sure that the 'root'@'127.0.0.1' account is present in the mysql.user table so that you can still connect to the server to shut it down.

### 重启mysql

# /etc/init.d/mysql restart


### 设置远程访问IP

这里假设需要用户(ruser)在主机192.168.0.8连接本数据库foo.

#### 创建数据库与授权用户

	mysql> CREATE DATABASE foo;
	mysql> GRANT ALL ON foo.* TO ruser@'192.168.0.8' IDENTIFIED BY 'PASSWORD';

#### 对当前已经存在的数据库进行用户授权

	mysql> update db set Host='192.168.0.8' where Db='edb';
	mysql> update user set Host='192.168.0.8' where user='ruser';



### 设置防火墙

需要设置iptables,开放3306端口

#### 对所有访问开放3306

	iptables -A INPUT -i eth0 -p tcp --dport 3306 -j ACCEPT

#### 只针对192.168.0.122开放3306端口


	iptables -A INPUT -i eth0 -s 192.168.0.122  -p tcp --dport 3306 -j ACCEPT


#### 针对网段 192.168.1.0/24开放3306

	iptables -A INPUT -i eth0 -s 192.168.1.0/24 -p tcp --dport 3306 -j ACCEPT

#### 保存设置

	service iptables save

### 测试

$ mysql -u webadmin –h 65.55.55.2 –p

