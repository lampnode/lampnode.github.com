---
layout: post
title: "Howto remove apache logs"
tagline: "Howto remove apache logs"
description: ""
category: Linux 
tags: [ Linux, Apache ]
---
{% include JB/setup %}

### Delete all logs files

Use the following command to remove all the log files inside your apache2 log.

	$sudo rm -rf /var/log/httpd/*

### Reload Apache

You should reload it after deleting all files,  or it`s empty.

	$sudo /etc/init.d/httpd restart


