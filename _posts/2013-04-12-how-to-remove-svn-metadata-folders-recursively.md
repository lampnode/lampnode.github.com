---
layout: post
title: "如何删除全部.svn metadata 文件夹"
tagline: "How to remove .svn metadata folders recursively"
description: ""
category: Linux
tags: [ Linux, Subversion ]
---
{% include JB/setup %}

如果想将项目中的.svn控制文件加去掉，在Linux下，可以这样操作:

## 方法

假设有文件夹project里使用svn作为版本控制工具，现将其.svn去掉:

	cd project
	find . -type d -name '.svn' -exec rm -rfv {} \;


参数介绍:

* -type b/d/c/p/l/f #查是块设备、目录、字符设备、管道、符号链接、普通文件
* -name filename #查找名为filename的文件
