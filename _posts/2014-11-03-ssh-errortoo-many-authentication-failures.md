---
layout: post
title: "SSH Error:Too many authentication failures"
tagline: "SSH Error:Too many authentication failures"
description: ""
category: Linux 
tags: [ SSH, Linux ]
---
{% include JB/setup %}

SSH returns “too many authentication failures” error when you try to login remote linux host. This is a very common problem when you have many linux hosts and clients.

## Error Detailed

I attempted to connect, e.g.:

	ssh -p 10000 username@example.com

I was receiving the following error:

	Received disconnect from 10.0.0.1: 2: Too many authentication failures for username

## ssh-config: IdentitiesOnly

Specifies that ssh(1) should only use the authentication identity files configured in the ssh_config files, even if ssh-agent(1) offers more identities.  The argument to this keyword must be “yes” or “no”.  This option is intended for situations where ssh-agent offers many different identities.  The default is "no".

## Solutions

Running the same ssh command and, in addition, specifying IdentitiesOnly=yes:

	ssh -p 10000 -o IdentitiesOnly=yes username@example.com

