---
layout: post
title: "How to install xdotool on CentOS"
tagline: "How to install xdotool on CentOS"
description: ""
category: Linux
tags: [ Linux, CentOS, xdotool ]
---
{% include JB/setup %}

The xdotool is an simpulate tool for keybord input and mouse activity. It depends X11 XTEST extension and other Xlib functions. You can install by apt-get on Ubuntu. But On CentOS,  the installation is not so easy.

## Installation
		
You need download and setup the Nux Dextop repository before install xdotool. 

### Download

Download the latest nux-dextop-release rpm from:

	http://li.nux.ro/download/nux/dextop/el6/x86_64/

### Setup NUX dextop

Install nux-dextop-release rpm:

	# rpm -Uvh nux-dextop-release*rpm

### Install xdtool

Install xdotool rpm package:

	# yum install xdotool


### How to use xdotool

The following articles should help you to know xdotool well:

 - [xdotool: Script your mouse](http://tuxradar.com/content/xdotool-script-your-mouse)

