---
layout: post
title: "Send Email from the command line on Ubuntu"
tagline: "Send Email from the command line on Ubuntu"
description: ""
category: Linux
tags: [ Linux, postfix ]
---
{% include JB/setup %}

The purpose of this document is to guide you to send email from the command line on Ubuntu 12.04
 or later.

## Installation

You need to install the mailutils and postfix packages with the following commands.

	$apt-get install mailutils

The postfix will be installed with mailutils too. 

## Testing
After configuring Postfix, test out the new configuration with the following command.

	$echo "test" | mail me@mail.com

