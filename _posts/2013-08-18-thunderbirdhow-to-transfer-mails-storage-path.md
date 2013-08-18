---
layout: post
title: "Thunderbird转移邮件存储路径 "
tagline: "Thunderbird:How to transfer mails storage path"
description: ""
category: Software
tags: [Thunderbird]
---
{% include JB/setup %}

默认安装的Thunderbird，邮件和设置都保存在

C:\Users\username\Appdata\Roaming\Thunderbird\Profile

默认设置不利于数据保存，当重装系统时候迁移数据是个麻烦事，所以希望把这个路径给改到非系统盘。
 
 
### 设置方法
 
通过修改Profile文件，让Thunderbird自己去读取我们制定的位置,profile文件的路径为：

	C:\Users\username\AppData\Roaming\Thunderbird\profiles.ini

如果比较了解这个文件的内容可以通过文本编辑器直接修改参数。如果不是很清楚，我们可以通过使用

	thunderbird.exe -p
 
命令，调用Thunderbird user profile manager来管理和修改profiles

