---
layout: post
title: "Howto set up public and private keys with ssh keygen"
tagline: "Howto set up public and private keys with ssh keygen"
description: ""
category: Linux 
tags: [ Linux, SSH ]
---
{% include JB/setup %}

The purpose of this document is to describe how to manage SSH keys with ssh-keygen.


### Create RSA key pair

	$mkdir kyes
	$cd keys/
	$ssh-keygen -b 2048 -t rsa -f example_rsa

Sample outputs:

	Generating public/private rsa key pair.
	Enter passphrase (empty for no passphrase): 
	Enter same passphrase again: 
	Your identification has been saved in example_rsa.
	Your public key has been saved in example_rsa.pub.
	The key fingerprint is:
	f8:dd:da:32:8e:df:b6:69:0e:59:dd:b9:2f:2b:ff:7a user@example.com
	The key`s randomart image is:
	+--[ RSA 2048]----+
	|                 |
	|                 |
	|                 |
	|       .     . ..|
	|      . S   . ...|
	|       . . +    .|
	|        . + .  . |
	| o      .o+**++*o|
	+-----------------+

The public key is now located in "/home/demo/keys/example_rsa.pub", The private 
key (identification) is now located in "/home/demo/keys/example_rsa". List all of keys:

	$ls
	
Sample outputs:

	-rw-------. 1 root root 1743 Jun  6 17:45 example_rsa
	-rw-r--r--. 1 root root  405 Jun  6 17:45 example_rsa.pub



