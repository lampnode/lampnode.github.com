---
layout: post
title: "How to setup .bashrc for new user on Ubunut"
tagline: "How to setup .bashrc for new user on Ubunut"
description: ""
category: Linux 
tags: [Linux, Ubuntu, Bash ]
---
{% include JB/setup %}

Accoring to the bash man page, The .bashrc is executed for interactive non-login shells. What is a non-login shell. If you have already logged into your linux and open a new terminal window inside GNOME/KDE, then the .bashrc is executed before the 
windows command prompt. .bashrc is also run when you start a new bash instance by typing /bin/bash in a terminal. But, it can 
not work when you login via ssh remotely.

## Howto setup .bashrc

If the file named ".bashrc" on the user home directory is not existed after you add a new user on Ubuntu, you should follow the steps by steps to configure it.



### Copy ".bashrc" from other user`s home directory

	$sudo cp /root/.bashrc ~/

### Test this file is work or not

	$source ~/.bashrc

But when you login via SSH from remote linux or shell client, the .bashrc as a no-login shell configration can not be executed. So, we need the following steps to fix this problem.

### Enable it automatically when you login by SSH

According to the bash man page, .bash_profile is executed for login shells. It means when you login via ssh, .bash_profile
 is executed to configurae your shell before the initial command prompt.

	$vim ~/.bash_profile

Then, add the following lines to .bash_profile:

	if [ -f ~/.bashrc ]; then
		. ~/.bashrc
	fi
	
Now when you login to your machine from a console .bashrc will be called.



