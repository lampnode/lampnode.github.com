---
layout: page
title: "ssh/scp"
description: ""
---
{% include JB/setup %}

## ssh

SSH是一个非常伟大的远程登录与管理工具。

### 格式

	ssh [-l login_name ] hostname | user@hostname [command ]

	ssh [-afgknqstvxACNTX1246 ] [-b bind_address ] [-c cipher_spec ] [-e escape_char ] [-i identity_file ] [-l login_name ] [-m mac_spec ] [-o option ] [-p port ] [-F configfile ] [-L port host hostport ] [-R port host hostport ] [-D port ] hostname | user@hostname [command ]

### 例子

####  复制SSH密钥到目标主机，开启无密码SSH登录

##### 创建密钥

	ssh-keygen -t rsa

##### 复制到远程服务器

	ssh-copy-id user@remote_host

#### 建立ssh 隧道

##### 环境

- 本地网络:192.168.1.0/24
- 远端服务器: example.com  开放端口:20000 用户:edwin
- 本地代理服务器:192.168.1.8(agentServer.com) 用户:root
- 本地测试机: workspace.com

##### 步骤

在本地代理服务器建立一个ssh通道

	[root@#agentServer.com]#ssh -CNfg -L 0.0.0.0:10000:localhost:20000 edwin@example.com -P 20000

通过本地代理服务器连接 example.com

	[robert@workspace.com]$ssh  root@192.168.1.8 -p 10000

#### 通过SSH将MySQL数据库复制到新服务器
   
	mysqldump –add-drop-table –extended-insert –force –log-error=error.log -uUSER -pPASS OLD_DB_NAME | ssh -C user@newhost "mysql -uUSER -pPASS NEW_DB_NAME"

## scp

scp是 secure copy的缩写, scp是linux系统下基于ssh登陆进行安全的远程文件拷贝命令。linux的scp命令可以在linux服务器之间复制文件和目录.

scp在网络上不同的主机之间复制文件，它使用ssh安全协议传输数据，具有和ssh一样的验证机制，从而安全的远程拷贝文件。

### 格式

	scp [-1246BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
	[-l limit] [-o ssh_option] [-P port] [-S program]
	[[user@]host1:]file1 [...] [[user@]host2:]file2


### 参数


* -1 强制scp命令使用协议ssh1
* -2 强制scp命令使用协议ssh2
* -4 强制scp命令只使用IPv4寻址
* -6 强制scp命令只使用IPv6寻址
* -B 使用批处理模式（传输过程中不询问传输口令或短语）
* -C 允许压缩。（将-C标志传递给ssh，从而打开压缩功能）
* -p 保留原文件的修改时间，访问时间和访问权限。
* -q 不显示传输进度条。
* -r 递归复制整个目录。
* -v 详细方式显示输出。scp和ssh(1)会显示出整个过程的调试信息。这些信息用于调试连接，验证和配置问题。
* -c cipher 以cipher将数据传输进行加密，这个选项将直接传递给ssh。
* -F ssh_config 指定一个替代的ssh配置文件，此参数直接传递给ssh。
* -i identity_file 从指定文件中读取传输时使用的密钥文件，此参数直接传递给ssh。
* -l limit 限定用户所能使用的带宽，以Kbit/s为单位。
* -o ssh_option 如果习惯于使用ssh_config(5)中的参数传递方式，
* -P port  注意是大写的P, port是指定数据传输用到的端口号
* -S program 指定加密传输时所使用的程序。此程序必须能够理解ssh(1)的选项。

### 例子

#### 从本地服务器复制到远程服务器

##### 复制文件
命令格式：

	scp local_file remote_username@remote_ip:remote_folder

或者

	scp local_file remote_username@remote_ip:remote_file

或者

	scp local_file remote_ip:remote_folder

或者

	scp local_file remote_ip:remote_file

第1,2个指定了用户名，命令执行后需要输入用户密码，第1个仅指定了远程的目录，文件名字不变，第2个指定了文件名
第3,4个没有指定用户名，命令执行后需要输入用户名和密码，第3个仅指定了远程的目录，文件名字不变，第4个指定了文件名

实例：

	scp /home/linux/soft/scp.zip root@www.mydomain.com:/home/linux/others/soft
	scp /home/linux/soft/scp.zip root@www.mydomain.com:/home/linux/others/soft/scp2.zip
	scp /home/linux/soft/scp.zip www.mydomain.com:/home/linux/others/soft
	scp /home/linux/soft/scp.zip www.mydomain.com:/home/linux/others/soft/scp2.zip

##### 复制目录

命令格式：

	scp -r local_folder remote_username@remote_ip:remote_folder

或者
	
	scp -r local_folder remote_ip:remote_folder

第1个指定了用户名，命令执行后需要输入用户密码；
第2个没有指定用户名，命令执行后需要输入用户名和密码；

例子：

	scp -r /home/linux/soft/ root@www.mydomain.com:/home/linux/others/
	scp -r /home/linux/soft/ www.mydomain.com:/home/linux/others/

上面 命令 将 本地 soft 目录 复制 到 远程 others 目录下，即复制后远程服务器上会有/home/linux/others/soft/ 目录

#### 从远程服务器复制到本地服务器

从远程复制到本地的scp命令与上面的命令雷同，只要将从本地复制到远程的命令后面2个参数互换顺序就行了。

例如：
	
	scp root@www.mydomain.com:/home/linux/soft/scp.zip /home/linux/others/scp.zip
	scp www.mydomain.com:/home/linux/soft/ -r /home/linux/others/


