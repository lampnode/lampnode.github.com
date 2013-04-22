---
layout: post
title: "Linux下的symbolic links 与hard links"
tagline: "Understanding Linux symbolic and hard links"
description: ""
category: Linux
tags: [ Linux ]
---
{% include JB/setup %}

## 创建链接

### 创建一个hard link

	# ln install.log install.log_link
	# ls -la
	-rw-r--r--.  2 root  root   49837 Sep 24  2012 install.log
	-rw-r--r--.  2 root  root   49837 Sep 24  2012 install.log_link

硬连接的特点:

* Hard links cannot link directories.
* Cannot cross file system boundaries.

### 创建一个软连接

	#ln -s file.tar.gz file.tar.gz.link
	#ls -ali
	261273 -rw-r--r--   1 root  root    1255 Mar 15 09:38 file.tar.gz
	261262 lrwxrwxrwx   1 root  root      15 Apr 22 11:32 file.tar.gz.link -> iptables.tar.gz

软连接的特点:

* To create links between directories.
* Can cross file system boundaries.

## 删除链接

链接源被移动或删除,两者的区别

* Symbolic links are not updated.
* Hard links always refer to the source, even if moved or removed.

### 实验

#### 组建测试环境

	[edwin@localhost ~]$ cd foo/
	[edwin@localhost foo]$ ls
	[edwin@localhost foo]$ cp /etc/httpd/conf/httpd.conf file1
	[edwin@localhost foo]$ ls
	file1
	[edwin@localhost foo]$ ls -ali
	total 44
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:38 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186087 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:38 file1

#### 链接创建测试

	[edwin@localhost foo]$ ln -s file1 file1.softLink
	[edwin@localhost foo]$ ls -ali
	total 44
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:39 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186087 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:38 file1
	1186088 lrwxrwxrwx   1 edwin edwin     5 Apr 22 11:39 file1.softLink -> file1

可见软连接相当于一个快捷方式，与源文件没有共同的inod，我们在看看硬连接:


	[edwin@localhost foo]$ cp file1 file2
	[edwin@localhost foo]$ ln file2 file2.hardLink
	[edwin@localhost foo]$ ls -ali
	total 116
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:40 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186087 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:38 file1
	1186088 lrwxrwxrwx   1 edwin edwin     5 Apr 22 11:39 file1.softLink -> file1
	1186089 -rw-r--r--   2 edwin edwin 34424 Apr 22 11:40 file2
	1186089 -rw-r--r--   2 edwin edwin 34424 Apr 22 11:40 file2.hardLink

硬连接的inod信息与源文件是一致的。

#### 链接删除测试

	[edwin@localhost foo]$ rm file1.softLink 
	[edwin@localhost foo]$ rm file2.hardLink 
	[edwin@localhost foo]$ ls -ali
	total 80
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:41 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186087 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:38 file1
	1186089 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:40 file2

#### 链接源文件删除测试

重建链接案例

	[edwin@localhost foo]$ ln file2 file2.hardLink
	[edwin@localhost foo]$ ln -s file1 file1.softLink
	[edwin@localhost foo]$ ls -ali
	total 116
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:42 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186087 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:38 file1
	1186088 lrwxrwxrwx   1 edwin edwin     5 Apr 22 11:42 file1.softLink -> file1
	1186089 -rw-r--r--   2 edwin edwin 34424 Apr 22 11:40 file2
	1186089 -rw-r--r--   2 edwin edwin 34424 Apr 22 11:40 file2.hardLink

删除链接的源文件:

	[edwin@localhost foo]$ rm file1
	[edwin@localhost foo]$ rm file2
	[edwin@localhost foo]$ ls -ali
	total 44
	1186086 drwxrwxr-x   2 edwin edwin  4096 Apr 22 11:42 .
	 652808 drwx------. 43 edwin edwin  4096 Apr 22 11:38 ..
	1186088 lrwxrwxrwx   1 edwin edwin     5 Apr 22 11:42 file1.softLink -> file1
	1186089 -rw-r--r--   1 edwin edwin 34424 Apr 22 11:40 file2.hardLink

软连接在shell下显示红色，并有警示闪烁。

	[edwin@localhost foo]$ cat file1.softLink 
	cat: file1.softLink: No such file or directory
	[edwin@localhost foo]$ cat file2.hardLink
	Dispaly the file2 content here

可见,删除源文件则软连接会失效，硬连接依旧存在; 本质区别在与inod的不同，硬连接是与物理文件直接相连的，是访问这个文件的另外一个入口，它与源文件没有任何差别，不使用硬盘容量，复制则是开辟一个新的硬盘空间并在里面填充了一样的内容，它的inod自然也就不同了，而软连接只是一个保存了源文件路径的文件，原文件的不存在了，这个路径也就错了，软连接也就失效了。

### 修改测试

#### 创建测试环境

	[edwin@localhost foo]$ vim file1 
	[edwin@localhost foo]$ ls
	file1
	[edwin@localhost foo]$ vim file2 
	[edwin@localhost foo]$ ls

#### 创建链接

	[edwin@localhost foo]$ ln -s file1 file1.softlink
	[edwin@localhost foo]$ ln file2 file2.hardlink
	[edwin@localhost foo]$ ls -ali
	total 20
	1186086 drwxrwxr-x   2 edwin edwin 4096 Apr 22 12:05 .
	 652808 drwx------. 43 edwin edwin 4096 Apr 22 12:04 ..
	1186088 -rw-rw-r--   1 edwin edwin   16 Apr 22 12:04 file1
	1186087 lrwxrwxrwx   1 edwin edwin    5 Apr 22 12:05 file1.softlink -> file1
	1186090 -rw-rw-r--   2 edwin edwin   16 Apr 22 12:04 file2
	1186090 -rw-rw-r--   2 edwin edwin   16 Apr 22 12:04 file2.hardlink

##### 修改软连接内容

	[edwin@localhost foo]$ vim file1.softlink 
	[edwin@localhost foo]$ ls -ali
	total 20
	1186086 drwxrwxr-x   2 edwin edwin 4096 Apr 22 12:06 .
	 652808 drwx------. 43 edwin edwin 4096 Apr 22 12:06 ..
	1186088 -rw-rw-r--   1 edwin edwin   27 Apr 22 12:06 file1
	1186087 lrwxrwxrwx   1 edwin edwin    5 Apr 22 12:05 file1.softlink -> file1
	1186090 -rw-rw-r--   2 edwin edwin   16 Apr 22 12:04 file2
	1186090 -rw-rw-r--   2 edwin edwin   16 Apr 22 12:04 file2.hardlink

#### 修改硬连接内容

修改链接内容

	[edwin@localhost foo]$ vim file2.hardlink 
	[edwin@localhost foo]$ ls -ali
	total 20
	1186086 drwxrwxr-x   2 edwin edwin 4096 Apr 22 12:06 .
	 652808 drwx------. 43 edwin edwin 4096 Apr 22 12:06 ..
	1186088 -rw-rw-r--   1 edwin edwin   27 Apr 22 12:06 file1
	1186087 lrwxrwxrwx   1 edwin edwin    5 Apr 22 12:05 file1.softlink -> file1
	1186090 -rw-rw-r--   2 edwin edwin   31 Apr 22 12:06 file2
	1186090 -rw-rw-r--   2 edwin edwin   31 Apr 22 12:06 file2.hardlink
	[edwin@localhost foo]$ cat file2
	Files2 content(M by hardlink)

	[edwin@localhost foo]$ cat file2.hardlink 
	Files2 content(M by hardlink)

可见，链接内容与源文件是一致的;我们再来修改源文件内容:

	[edwin@localhost foo]$vim file2
	[edwin@localhost foo]$ ls -ali
	total 20
	1186086 drwxrwxr-x   2 edwin edwin 4096 Apr 22 12:12 .
	 652808 drwx------. 43 edwin edwin 4096 Apr 22 12:12 ..
	1186088 -rw-rw-r--   1 edwin edwin   27 Apr 22 12:06 file1
	1186087 lrwxrwxrwx   1 edwin edwin    5 Apr 22 12:05 file1.softlink -> file1
	1186090 -rw-rw-r--   2 edwin edwin   51 Apr 22 12:12 file2
	1186090 -rw-rw-r--   2 edwin edwin   51 Apr 22 12:12 file2.hardlink
	[edwin@localhost foo]$ cat file2
	Files2 content(M by hardlink)(M by original file)

	[edwin@localhost foo]$ cat file2.hardlink 
	Files2 content(M by hardlink)(M by original file)

可见，源文件内容修改后，链接内容也是同步变化的.

