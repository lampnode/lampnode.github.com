---
layout: post
title: "How to install and config Termux on Android 5.x or later"
tagline: "How to install and config Termux on Android 5.x or later"
description: ""
category: Android 
tags: [ Linux, Android ]
---
{% include JB/setup %}

[Termux](https://termux.com/) is an Android terminal emulator and Linux environment app that works directly with no rooting or setup required. A minimal base system is installed automatically - additional packages are available using the APT package manager.

## Install and setup

Download Termux app and install it.Open Termux and wait for its complete installation. then, you need use the following command:

    apt update


### Config editor

    export EDITOR=vi

### Add new apt source

    deb [arch=all,arm] http://mirrors.tuna.tsinghua.edu.cn/termux stable main

If your android is not a ARM CPU, the contents of the above `[ ]` will be different.

### enable https

    apt install apt-transport-https


## Install apps

we can use  apt command to insall apps .To know how to use apt , click on Help in Termux app  (Long press in Termux Terminal window will bring menu )

### list avaliable apps

To get list of available packages,use this command:

    apt list

if you want to install python, use the following command:

    apt install python

If you want to remove python, use:

    apt remove python

To see installed packages, use this command:

    apt list –installed 



