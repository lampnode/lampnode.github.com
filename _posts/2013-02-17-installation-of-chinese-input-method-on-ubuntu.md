---
layout: post
title: "在Ubuntu上安装中文输入法"
tagline: "Installation of Chinese input method on Ubuntu"
description: ""
category: Linux
tags: [Ubuntu]
---
{% include JB/setup %}

## Ubuntu 12.10

### 安装语言包

我们选择“Language Support”-->Install/Remove Languages，安装简体中文语言包。

### 安装IBus框架

在终端输入以下命令：

	sudo apt-get install ibus ibus-clutter ibus-gtk ibus-gtk3 ibus-qt4

启动IBus框架，在终端输入：

	im-switch -s ibus

安装完IBus框架后注销系统，保证更改立即生效。


### 安装拼音引擎
 
有下面几种常用选择：
IBus拼音
	sudo apt-get install ibus-pinyin

谷歌拼音输入法
	sudo apt-get install ibus-googlepinyin
Sun拼音输入法	
	sudo apt-get install ibus-sunpinyin

### 设置IBus框架  

	ibus-setup

此时，IBus Preference设置被打开。我们在Input Method选项卡中，选择自己喜欢的输入方式，并配置自己喜欢的快捷键即可

