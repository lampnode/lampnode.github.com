---
layout: post
title: "Howto send email from Ubuntu with Gmail"
tagline: "Howto send email from Ubuntu with Gmail"
description: ""
category: Linux 
tags: [ Linux, Ubuntu, Gmail ]
---
{% include JB/setup %}

The purpose of this document is show you how to send email form Ubuntu with Gmail. There is a package designed just 
for this mission: ssmtp. So, if you want to send mail from your Ubuntu desktop, It is a good choise.  Let`s just  install 
ssmtp.

## Steps

***NOTE*** Before you complete the following steps, need to delete Postfix/sendmail packages.

### Install ssmtp

	$sudo apt-get install ssmtp mailutils

### Configuration ssmtp

Then edit the ssmtp configuration file:

	$sudo vim /etc/ssmtp/ssmtp.conf

Comment out the "root" , "hostname" and "mailhub" lines. Add the following a the end of this file:

	root=your_email@gmail.com
	mailhub=smtp.gmail.com:587
	rewriteDomain=gmail.com
	hostname=<YOUR MACHINE HOSTNAME>
	AuthUser=your_gmail_username # me@gmail.com
	AuthPass=your_gmail_password
	FromLineOverride=Yes
	UseTLS=Yes
	UseSTARTTLS=Yes

Configure SSMTP "/etc/ssmtp/revaliases" file to looks like:

	root:<YOUR EMAIL>@gmail.com:smtp.gmail.com:587

Then, save the change. Add the "heirloom-mailx" as  mail application in command line.

	$sudo apt-get install heirloom-mailx

### Test Email

Now you can also use mail from the command line with something like:

	$echo "test text" | mail -s "test mail content" target@example.com

The text "test text" is sent to the email address targetperson@example.com (you may also 
specify multiple addresses separated by spaces) with the subject "test mail content". For more options type mail –help.




