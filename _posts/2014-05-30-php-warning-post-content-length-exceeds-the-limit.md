---
layout: post
title: "PHP Warning: POST Content Length exceeds the limit"
tagline: "PHP Warning: POST Content Length exceeds the limit"
description: ""
category: PHP
tags: [ PHP Warning ]
---
{% include JB/setup %}

The purpose of this document is describe how to fix php errors.

## PHP Error

If you getting this kind of error when tring to upload an file to website:

	PHP Warning: POST Content-Length of 8978294 bytes exceeds the limit of 8388608 bytes in Unknown on line 0.


## Howto fix it

### Update your post_max_size in php.ini to a larger value.

	 post_max_size = 50M

### Update your upload_max_filesize in php.ini to a larger value.

	 upload_max_filesize = 50M

### reboot apache

	$sudo /etc/init.d/httpd restart
