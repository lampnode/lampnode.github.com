---
layout: post
title: "在Ubuntu上对Samba进行基本设置"
tagline: "Basic Samba Setup On Ubuntu 10.04"
description: ""
category: Linux
tags: [ Ubuntu ]
---
{% include JB/setup %}

The purpose of this article is to explain how to do a basic Samba setup on the new version. All USERNAME stands for your username on your Ubuntu system.

## Install samba

First, you’ll need to install Samba. Fire up a Terminal window and use this command:
 
	sudo apt-get install samba
 
## Create user for smb

Follow the default prompts to install Samba. Now, Samba uses a separate set of passwords than the standard Linux system accounts (stored in /etc/samba/smbpasswd), so you’ll need to create a Samba password for yourself with this command:
 
	sudo smbpasswd -a USERNAME
 
(USERNAME, of course, is your actual username.)

## Create the share path

Begin by creating a folder named ‘test’ on your home folder; we’ll use that for our test shared folder (you can create other shared folders using the same method):
 
	mkdir /home/USERNAME/test
 
## Config

Next, make a safe backup copy of the original smb.conf file to your home folder, in case you make an error:
 
	sudo cp /etc/samba/smb.conf ~
 
Now use your text editor of choice to edit smb.conf:

### Global

In Authentication, you should set up the following options:

{% highlight bash %} 
security = user
valid users = USERNAME
{% endhighlight %}

### Share path
 
	sudo gedit /etc/samba/smb.conf
 
Once smb.conf has loaded, add this to the very end of the file:

{% highlight bash %} 
[test]
path = /home/USERNAME/test
comment = Home  media
public = yes
writable = yes
browseable = yes
display charset = UTF-8
unix charset = UTF-8
dos charset = cp936
create mask = 0755
directory mask = 0700

{% endhighlight %}
 
Once you have input the changes, save smb.conf, exit the text editor, and restart Samba with this command:
 
	sudo restart smbd
 
### UFW setup

To setup the following ports for smb server:
 
{% highlight bash %}
sudo ufw allow proto tcp to any port 137 from 192.168.0.0/24
sudo ufw allow proto tcp to any port 138 from 192.168.0.0/24
sudo ufw allow proto tcp to any port 139 from 192.168.0.0/24
sudo ufw allow proto tcp to any port 445 from 192.168.0.0/24
{% endhighlight %}
 
Checking the ufw status:

{% highlight bash %} 
$ sudo ufw status
Status: active
 
To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
135/tcp                    ALLOW       192.168.0.0/24
137/tcp                    ALLOW       192.168.0.0/24
138/tcp                    ALLOW       192.168.0.0/24
139/tcp                    ALLOW       192.168.0.0/24
445/tcp                    ALLOW       192.168.0.0/24

{% endhighlight %}
