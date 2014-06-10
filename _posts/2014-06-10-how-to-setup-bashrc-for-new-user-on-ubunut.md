---
layout: post
title: "How to setup .bashrc for new user on Ubunut"
tagline: "How to setup .bashrc for new user on Ubunut"
description: ""
category: Linux 
tags: [Linux, Ubuntu, Bash ]
---
{% include JB/setup %}

If the file named ".bashrc" on the user home directory is not existed after you add a new user on Ubuntu, you should follow the steps by steps to configure it.

### Copy ".bashrc" from other user`s home directory

	$sudo cp /root/.bashrc ~/

### Test this file is work or not

	$source ~/.bashrc

### Enable it automatically when you login by SSH

	$vim ~/.bash_profile

Then, add the following content to this file:

	if [ -f ~/.bashrc ]; then
		. ~/.bashrc
	fi
	


