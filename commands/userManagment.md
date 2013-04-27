---
layout: page
title: "Useradd/usermod/userdel"
description: ""
---
{% include JB/setup %}

## 基础知识

### 用户帐号文件

- /etc/paddwd 帐号以及相关信息，均存放在该文件内
- /etc/shadow 密码保存位置
- /etc/group 用户组文件存放位置。
- /etc/gshadow 用户组密码存放位置

### 使用的Shell

- /sbin/nologin 不能登录的系统账户shell定位
- /bin/bash 可以登录的非系统用户，使用的bash shell.

## useradd -- 添加新用户

### 使用范围

useradd命令用来建立用户帐号和创建用户的起始目录，使用权限是超级用户。

### 格式

	useradd [-d home] [-s shell] [-c comment] 
		[-m [-k template]] [-f inactive] [-e expire ] 
		[-p passwd] [-r] name

### 参数
* -c <备注> 加上备注文字

* -d <登入目录> 　指定用户登入时的启始目录。

* -e <expire_date>　帐号终止日期。日期的指定格式为MM/DD/YY。
 
* -f inactive_days　帐号过期几日后永久停权。当值为0时帐号则立刻被停权。而当值为-1时则关闭此功能，预设值为-1
 
* -g initial_group　group名称或以数字来做为使用者登入起始群组(group)。群组名须为现有存在的名称。群组数字也须为现有存在的群组。预设的群组数字为1。
 
* -G group,[...]　定义此使用者为此一堆groups的成员。每个群组使用","区格开来，不可以夹杂空白字元。群组名同-g选项的限制。定义值为使用者的起始群组。
 
* -m　使用者目录如不存在则自动建立。如使用-k选项skeleton_dir内的档案将复制至使用者目录下。然而在/etc/skel目录下的档案也会复制过去取代。任何在skeleton_diror/etc/skel的目录也相同会在使用者目录下一一建立。The-k同-m不建立目录以及不复制任何档案为预设值。
 
* -M　不建立使用者目录，即使/etc/login.defs系统档设定要建立使用者目录。
 
* -n　预设值使用者群组与使用者名称会相同。此选项将取消此预设值。
 
* -r　此参数是用来建立系统帐号。系统帐号的UID会比定义在系统档上/etc/login.defs.的UID_MIN来的小。注意useradd此用法所建立的帐号不会建立使用者目录，也不会在乎纪录在/etc/login.defs.的定义值。如果你想要有使用者目录须额外指定-m参数来建立系统帐号。这是REDHAT额外增设的选项。
 
* -s shell　使用者登入后使用的shell名称。预设为不填写，这样系统会帮你指定预设的登入shell。

* -u uid　使用者的ID值。必须为唯一的ID值，除非用-o选项。数字不可为负值。预设为最小不得小于999而逐次增加。0~999传统上是保留给系统帐号使用。改变预设值当-D选项出现时，useradd秀出现在的预设值，或是藉由命令列的方式更新预设值。可用选项为∶
 
### 例子

#### 添加一个用户，使用默认组

	[root@localhost home]# useradd tom
	[root@localhost home]# tail /etc/passwd	
	......
	tom:x:501:501::/home/tom:/bin/bash
	[root@localhost home]# ls -al /home/
	total 16
	drwxr-xr-x.  4 root  root  4096 Apr 27 13:32 .
	dr-xr-xr-x. 25 root  root  4096 Apr 27 08:26 ..
	drwx------   4 tom   tom   4096 Apr 27 13:32 tom


#### 添加一个用户，使用现有的组

	[root@localhost home]# useradd tomson -g tom
	[root@localhost home]# tail /etc/passwd
	......
	tom:x:501:501::/home/tom:/bin/bash
	tomson:x:502:501::/home/tomson:/bin/bash
	[root@localhost home]# ls -al /home/
	total 20
	drwxr-xr-x.  5 root   root  4096 Apr 27 13:35 .
	dr-xr-xr-x. 25 root   root  4096 Apr 27 08:26 ..
	drwx------   4 tom    tom   4096 Apr 27 13:32 tom
	drwx------   4 tomson tom   4096 Apr 27 13:35 tomson

#### 添加一个用户，主目录放在/var,并限制其登录

	[root@localhost home]# useradd -d /var/www -s /sbin/nologin webmaster
	useradd: warning: the home directory already exists.
	Not copying any file from skel directory into it.
	[root@localhost home]# tail /etc/passwd
	......
	tom:x:501:501::/home/tom:/bin/bash
	tomson:x:502:501::/home/tomson:/bin/bash
	webmaster:x:503:503::/var/www:/sbin/nologin
	[root@localhost home]# ls -al /home/
	total 20
	drwxr-xr-x.  5 root   root  4096 Apr 27 13:35 .
	dr-xr-xr-x. 25 root   root  4096 Apr 27 08:26 ..
	drwx------   4 tom    tom   4096 Apr 27 13:32 tom
	drwx------   4 tomson tom   4096 Apr 27 13:35 tomson
	[root@localhost home]# ls -al /var/www/
	total 24
	drwxr-xr-x.  6 root      root 4096 Apr 15 13:27 .
	drwxr-xr-x. 23 root      root 4096 Mar 14 15:45 ..
	drwxr-xr-x.  2 root      root 4096 Feb 22 19:20 cgi-bin
	drwxr-xr-x.  3 root      root 4096 Apr  9 16:34 error
	drwxr-xr-x.  3 root      root 4096 Apr  9 16:36 icons
	drwxr-xr-x   2 webalizer root 4096 Apr 16 09:27 usage

** 注意: **

- 对于新创建的用户，如果没有设置密码的情况下，账户密码处于锁定状态，用户是无法登录系统的。

## usermod --  设置用户属性

### 命令格式

	usermod [option] username

### 例子

####  改变用户名

	usermod -l newUserName oldUsername

例如:

	[root@localhost home]# usermod -l jack tom
	[root@localhost home]# tail /etc/passwd
	......
	tomson:x:502:501::/home/tomson:/bin/bash
	webmaster:x:503:503::/var/www:/sbin/nologin
	jack:x:501:501::/home/tom:/bin/bash

可见，原tom的信息修改为了jack,但是目录没有改变。查看home

	[root@localhost home]# ls -al /home/
	total 20
	drwxr-xr-x.  5 root   root  4096 Apr 27 13:35 .
	dr-xr-xr-x. 25 root   root  4096 Apr 27 08:26 ..
	drwx------. 43 edwin  edwin 4096 Apr 22 12:12 edwin
	drwx------   4 jack   tom   4096 Apr 27 13:32 tom
	drwx------   4 tomson tom   4096 Apr 27 13:35 tomson

/home/tom是存在的，只是用户改变为jack, 属组没有变化.如果想将其目录也修改掉，可以使用如下命令:


	usermod -d /new/directory username

操作如下:

	[root@localhost home]# usermod -d /home/jack jack
	[root@localhost home]# tail /etc/passwd
	......
	tomson:x:502:501::/home/tomson:/bin/bash
	webmaster:x:503:503::/var/www:/sbin/nologin
	jack:x:501:501::/home/jack:/bin/bash
	[root@localhost home]# mv /home/tom /home/jack
	[root@localhost home]# ls -al
	total 20
	drwxr-xr-x.  5 root   root  4096 Apr 27 13:46 .
	dr-xr-xr-x. 25 root   root  4096 Apr 27 08:26 ..
	drwx------   4 jack   tom   4096 Apr 27 13:32 jack
	drwx------   4 tomson tom   4096 Apr 27 13:35 tomson

#### 锁定/解锁账户

对账户进行临时锁定操作，可以使用-L参数。

	usermod -L username

Linux锁定账户，是通过在密码文件(/etc/shadow)的密码字段增加"!"实现的。反之，

	usermod -U username

操作如下:

	[root@localhost home]# usermod -L jack
	[root@localhost home]# tail -l /etc/shadow
	......
	jack:!$6$ByxUFhZj$UYvFocLOMIsDBbuO/hLFtOdICcDLNBIBggGSgCxVY6TmSLQx936T9a3tg7LQ7s33y7XGw/tLEqRtrFVYbvTuV0:15822:0:99999:7:::
	[root@localhost home]# usermod -U jack
	[root@localhost home]# tail -l /etc/shadow
	......
	jack:$6$ByxUFhZj$UYvFocLOMIsDBbuO/hLFtOdICcDLNBIBggGSgCxVY6TmSLQx936T9a3tg7LQ7s33y7XGw/tLEqRtrFVYbvTuV0:15822:0:99999:7:::

## 删除账户

	userdel [ -r ] username


-r为可选项，其意义是一并删除用户目录。

## 用户密码

### 修改账户密码

	passwd [ username ]

注意:只有root账户才可以设置指定账户的密码。

### 锁定/解锁账户密码

锁定账户密码只有root的可以操作。

	passwd -l username

解锁:
	passwd -u username

### 查询密码状态

	passwd -S username

	[root@localhost home]# passwd -l jack
	Locking password for user jack.
	passwd: Success
	[root@localhost home]# passwd -S jack
	jack LK 2013-04-27 0 99999 7 -1 (Password locked.)
	[root@localhost home]# passwd -u jack
	Unlocking password for user jack.
	passwd: Success

### 删除账户密码

	passwd -d username

	[root@localhost home]# cat /etc/shadow | grep jack
	jack:$6$ByxUFhZj$UYvFocLOMIsDBbuO/hLFtOdICcDLNBIBggGSgCxVY6TmSLQx936T9a3tg7LQ7s33y7XGw/tLEqRtrFVYbvTuV0:15822:0:99999:7:::
	[root@localhost home]# passwd -d jack
	Removing password for user jack.
	passwd: Success
	[root@localhost home]# cat /etc/shadow | grep jack
	jack::15822:0:99999:7:::
