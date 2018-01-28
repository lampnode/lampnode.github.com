---
layout: post
title: "Install pycharm by Ubuntu make"
tagline: "Install pycharm by Ubuntu make"
description: ""
category: 
tags: [Ubuntu, Python ]
---
{% include JB/setup %}

Ubuntu make(Ubuntu Developer Tools Center) is a open source software for developers to manage kinds of IDE, such as Pycharm.

## Install


	sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
	sudo apt-get update
	sudo apt-get install ubuntu-make


### Install pycharm


	sudo umake ide pycharm

or

	sudo umake ide pycharm-professional
	
