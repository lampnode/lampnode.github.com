---
layout: post
title: "SSH:login without password"
tagline: "SSH:login without password"
description: ""
category: Linux 
tags: [ Linux, SSH ]
---
{% include JB/setup %}

This document is show you how to login remote Linux server  without entering any passwords in simple steps.

We will use ssh-keygen and ssh-copy-id to finish this job.

## About ssh toolkit

Ssh-keygen creates the public and private keys. 

Ssh-copy-id copies the local-host public key to the authorized_keys file of remote linux host. ssh-copy-id also assigns proper permission to the remote-host home related file and directories, ~/.ssh, and ~/.ssh/authorized_keys.

## Steps

### To generate a pair of authentication keys

	$ ssh-keygen -t rsa

The sample output:

	Generating public/private rsa key pair.
	Enter file in which to save the key (/home/edwin/.ssh/id_rsa): 
	Created directory '/home/robert/.ssh'.
	Enter passphrase (empty for no passphrase): 
	Enter same passphrase again: 
	Your identification has been saved in /home/edwin/.ssh/id_rsa.
	Your public key has been saved in /home/edwin/.ssh/id_rsa.pub.
	The key fingerprint is:
	0d:03:60:6c:a8:ff:41:de:31:5e:f6:24:30:af:84:24 robert@lampnode.com

### Copy the public key to remote-host

Ssh-copy-id appends the keys to the remote-host’s .ssh/authorized_key.

	$ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.0.11

Or,

	$ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.0.11

Alternatively, you can paste in the keys using SSH:

	$cat ~/.ssh/id_rsa.pub | ssh root@192.168.0.11 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"

The sample output:
	
	The authenticity of host '192.168.0.11 (192.168.0.11)' can't be established.
	RSA key fingerprint is fa:7f:30:f1:28:8c:c2:da:c9:3e:c4:39:0e:9c:0a:68.
	Are you sure you want to continue connecting (yes/no)? yes
	/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
	/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
	root@192.168.0.11's password: 

	Number of key(s) added: 1

	Now try logging into the machine, with:   "ssh 'root@192.168.0.11'"
	and check to make sure that only the key(s) you wanted were added.

### Login to remote-host without entering the password

	robert@lampnode:~$ ssh root@192.168.0.11
	Last login: Mon Nov  3 12:40:12 2014 from 192.168.0.7
	

All done, have fun!
