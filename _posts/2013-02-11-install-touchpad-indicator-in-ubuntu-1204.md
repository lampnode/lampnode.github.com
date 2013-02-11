---
layout: post
title: "在Ubuntu 12.04上安装配置Touchpad Indicator"
tagline: "Install Touchpad Indicator in Ubuntu 12.04"
description: "Install Touchpad Indicator in Ubuntu 12.04"
category: Linux
tags: [Ubuntu]
---
{% include JB/setup %}

在Thinkpad系列笔记本上安装Ubuntu 系统，必不可少的会遇到Touchpad 的问题，我是比较讨厌Trackpoint 跟它同时使用，所以安装Touchpad-indicator来管理它.

## Installation

安装Touchpad-indicator需要使用的第三方的库：PPA, 安装方法如下

	sudo add-apt-repository ppa:atareao/atareao

然后可以直接安装 touchpad indicator:

	sudo apt-get update && sudo apt-get install touchpad-indicator

## Usage

安装好的Touchpad-indicator会在Applications菜单里，一般是放在 Accessories 这个子菜单里.



