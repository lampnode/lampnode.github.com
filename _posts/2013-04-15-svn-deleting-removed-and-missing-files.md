---
layout: post
title: "SVN: 删除已经移除或者丢失的文件"
tagline: "SVN: Deleting removed and missing files"
description: ""
category: Linux
tags: [ Subversion, Linux ]
---
{% include JB/setup %}

SVN命令行工具不是那么的完善，所以我们得考虑用其他的系统命令来完成一些复杂的应用.

## 删除丢失的文件

对于递归的多个文件出现"!", 解决方法是使用svn status输，使用通道联用grep，awk和xargs的，具体如下：

svn status | grep "^\!" | awk '{print $2}' | xargs svn rm

同样，可以使用如下命令，增加所有带有"?"标识的文件.

svn status | grep "^\?" | awk '{print $2}' | xargs svn add
