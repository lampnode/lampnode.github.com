---
layout: post
title: "如何在Linux上安装Rsync"
tagline: "How to Setup Rsync on Linux"
description: ""
category: Linux 
tags: [ Linux ]
---
{% include JB/setup %}

## 关于rsync

rsync是类unix系统下的数据镜像备份工具。它的特性如下：

* 可以镜像保存整个目录树和文件系统。
* 可以很容易做到保持原来文件的权限、时间、软硬链接等等。
* 无须特殊权限即可安装。
* 快速：第一次同步时 rsync 会复制全部内容，但在下一次只传输修改过的文件。rsync 在传输数据的过程中可以实行压缩及解压缩操作，因此可以使用更少的带宽。
* 安全：可以使用scp、ssh等方式来传输文件，当然也可以通过直接的socket连接。
* 支持匿名传输，以方便进行网站镜象。

## 环境要求

* 服务端主机 192.168.1.105 提供镜像服务
* 客户端主机 192.168.1.100 获取镜像内容

## 安装
### 服务端主机配置
#### 安装 xinedtd rsync
	
	[root@server ~]# yum -y install xinetd  rsync

#### 设置xinetd

修改 "disable = yes" to "disable = no" 在/etc/xinetd.d/rsync

	[root@server ~]# vi /etc/xinetd.d/rsync

修改该文件:

	service rsync
	{
	disable = no #原为yes,这里修改为no
	socket_type = stream
	wait = no
	user = root
	server = /usr/bin/rsync
	server_args = –daemon
	log_on_failure += USERID
	}

#### 重启 xinetd

	[root@server ~]#  /etc/init.d/xinetd start

#### 设置防火墙  iptables (开放 873)

rsync默认使用的是873端口，需要设置防火墙

{% highlight bash %}

[root@server]# iptables --list
Chain INPUT (policy DROP)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:http 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:https 
ACCEPT     icmp --  anywhere             anywhere            icmp echo-request 
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 

Chain FORWARD (policy DROP)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

[root@server]# iptables -A INPUT -p tcp --dport 873 -j ACCEPT

[root@server]# iptables --list
Chain INPUT (policy DROP)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:http 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:https 
ACCEPT     icmp --  anywhere             anywhere            icmp echo-request 
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:rsync 

Chain FORWARD (policy DROP)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

[root@server]# /etc/init.d/iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ] 
{% endhighlight %}


#### 设置 rsyncd.conf

	[root@server ~]# vi /etc/rsyncd.conf

设置样例如下:

{% highlight bash %}

# Global setup
hosts allow=192.168.0.102 192.168.0.100  
hosts deny=*
log file = /var/log/rsyncd.log
uid = root
gid = root

# Module setup
[itemA]
path = /var/ftp/itemA
auth users = admin
secrets file = /etc/rsyncd.secrets
read only= yes

[itemB]
path = /var/ftp/itemB
auth users = admin
secrets file = /etc/rsyncd.secrets
read only= yes

{% endhighlight %}

#### 设置 rsyncd.secrets

	[root@server ~]#  vi /etc/rsyncd.secrets

设置样例如下:		
		admin:1234 

#### 修改  rsynced.secrets的权限

	[root@server ~]# chown root:root /etc/rsyncd.secrets
	[root@server ~]# chmod 600 /etc/rsyncd.secrets


### 客户端设置

#### 安装rsync

	[root@client ~]# yum -y install rsync

#### 用法

##### 命令格式
	rsync [OPTION]... SRC DEST
	rsync [OPTION]... SRC [USER@]HOST:DEST
	rsync [OPTION]... [USER@]HOST:SRC DEST
	rsync [OPTION]... [USER@]HOST::SRC DEST
	rsync [OPTION]... SRC [USER@]HOST::DEST	
	rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]

对应于以上六种命令格式，rsync有六种不同的工作模式：

* 拷贝本地文件。当SRC和DES路径信息都不包含有单个冒号":"分隔符时就启动这种工作模式。如：rsync -a /data /backup
* 使用一个远程shell程序(如rsh、ssh)来实现将本地机器的内容拷贝到远程机器。当DST路径地址包含单个冒号":"分隔符时启动该模式。如：rsync -avz *.c foo:src
* 使用一个远程shell程序(如rsh、ssh)来实现将远程机器的内容拷贝到本地机器。当SRC地址路径包含单个冒号":"分隔符时启动该模式。如：rsync -avz foo:src/bar /data
* 从远程rsync服务器中拷贝文件到本地机。当SRC路径信息包含"::"分隔符时启动该模式。如：rsync -av root@172.16.78.192::www /databack
* 从本地机器拷贝文件到远程rsync服务器中。当DST路径信息包含"::"分隔符时启动该模式。如：rsync -av /databack root@172.16.78.192::www
* 列远程机的文件列表。这类似于rsync传输，不过只要在命令中省略掉本地机信息即可。如：rsync -v rsync://172.16.78.192/www

##### 主要参数

* -z, --compress 对备份的文件在传输时进行压缩处理
* -v, --verbose 详细模式输出 
* -q, --quiet 精简输出模式 
* -c, --checksum 打开校验开关，强制对文件传输进行校验 
* -a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD 
* --existing 仅仅更新那些已经存在于DST的文件，而不备份那些新创建的文件 
* --delete 删除那些DST中SRC没有的文件 
* --delete-excluded 同样删除接收端那些被该选项指定排除的文件 
* --delete-after 传输结束以后再删除 
* --config=FILE 指定其他的配置文件，不使用默认的rsyncd.conf文件 
* --port=PORT 指定其他的rsync服务端口  
* --password-file=FILE 从FILE中得到密码 

#####  例子1
	[root@client ~]# rsync -avz admin@192.168.1.105::backup /www



##### 例子2

With delete(Warnin:When using this parameter, it is recommended to use absolute path
Specify the local directory path to prevent empty the current directory)
	
	[root@client ~]# rsync -avz --delete admin@192.168.1.105::backup /www

##### 联合SSH

参看[使用Rsync经SSH备份数据](/Linux/using-rsync-with-ssh-to-backup-data/) 

## 常见错误分析

###### 问题

	@ERROR: chroot failed
	rsync error: error starting client-server protocol (code 5) at main.c(1522) [receiver=3.0.3]

原因：
服务器端的目录不存在或无权限。创建目录并修正权限可解决问题。

###### 问题

	@ERROR: auth failed on module tee
	rsync error: error starting client-server protocol (code 5) at main.c(1522) [receiver=3.0.3]

原因：
服务器端该模块（tee）需要验证用户名密码，但客户端没有提供正确的用户名密码，认证失败。提供正确的用户名密码解决此问题。

###### 问题

	@ERROR: Unknown module ‘tee_nonexists’
	rsync error: error starting client-server protocol (code 5) at main.c(1522) [receiver=3.0.3]


原因：
服务器不存在指定模块。提供正确的模块名或在服务器端修改成你要的模块以解决问题。

###### 问题

	password file must not be other-accessible
	continuing without password file
	Password:

原因：
这是因为rsyncd.pwd rsyncd.secrets的权限不对，应该设置为600。如：chmod 600 rsyncd.pwd

###### 问题

	rsync: failed to connect to 218.107.243.2: No route to host (113)
	rsync error: error in socket IO (code 10) at clientserver.c(104) [receiver=2.6.9]

原因：
对方没开机、防火墙阻挡、通过的网络上有防火墙阻挡，都有可能。关闭防火墙，其实就是把tcp udp的873端口打开。

###### 问题

	rsync error: error starting client-server protocol (code 5) at main.c(1524) [Receiver=3.0.7]

原因：
/etc/rsyncd.conf配置文件内容有错误。请正确核对配置文件。

###### 问题

	rsync: chown "" failed: Invalid argument (22)

原因：
权限无法复制。去掉同步权限的参数即可。(这种情况多见于Linux向Windows的时候)

###### 问题

	@ERROR: daemon security issue -- contact admin
	rsync error: error starting client-server protocol (code 5) at main.c(1530) [sender=3.0.6]

原因：
同步的目录里面有软连接文件，需要服务器端的/etc/rsyncd.conf打开use chroot = yes。掠过软连接文件。
