---
layout: page
title: "groupadd/groupdel/gpasswd"
description: ""
---
{% include JB/setup %}

## 基础知识

用户组是用户的集合，用户与用户组属于多对多关系。一个用户可以同时属于多个组，一个用户组可以同时包含多个不同的用户。

## 创建用户组

	groupadd [ -r ] groupName

如果带有-r参数，创建的用户组属于系统用户组，其GID小于500；反之，大于500.

	[root@localhost home]# groupadd teachers
	[root@localhost home]# groupadd -r students
	[root@localhost home]# tail -l /etc/group
	......
	teachers:x:504:
	students:x:491:

## 修改用户组属性

### 修改用户名称

	groupmod -n newGroupName oldGroupName

修改名称，GID不变

### 重设GID

	groupmod -g new_GID groupName

例如:

	[root@localhost home]# groupmod -g 505 teachers
	[root@localhost home]# tail -l /etc/group | grep teachers
	teachers:x:505:


## 删除用户组

	groupdel groupName

**注意:** 如果要删除的用户组不是摸个账户的私有用户组，无法删除。如果要删除，需要先删除引用该用户组的所有账户，然后才可以删除该账户。

## 用户操作

### 添加用户到指定用户组

	gpasswd -a username groupName

例如:

	[root@localhost home]# groupadd coders
	[root@localhost home]# gpasswd -a jeffrey coders
	gpasswd: user 'jeffrey' does not exist
	[root@localhost home]# useradd jeffrey
	[root@localhost home]# gpasswd -a jeffrey coders
	Adding user jeffrey to group coders
	[root@localhost home]# id jeffrey
	uid=504(jeffrey) gid=504(jeffrey) groups=504(jeffrey),506(coders)

### 从指定用户组移除用户

 	gpasswd -d username groupName


	[root@localhost home]# useradd alice
	[root@localhost home]# gpasswd -a alice coders
	Adding user alice to group coders
	[root@localhost home]# tail /etc/group | grep coders
	coders:x:506:jeffrey,alice
	[root@localhost home]# gpasswd -d alice coders
	Removing user alice from group coders
	[root@localhost home]# tail /etc/group | grep coders
	coders:x:506:jeffrey
