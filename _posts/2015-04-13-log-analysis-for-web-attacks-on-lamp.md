---
layout: post
title: "Log analysis for Web Attacks on LAMP"
tagline: "Log analysis for Web Attacks on LAMP"
description: ""
category: Linux 
tags: [Linux, Security, Apache, PHP, MySQL ]
---
{% include JB/setup %}

This article covers some concepts of log analysis to web attacks for LAMP.

## Analyzing the logs

### Keywords

#### union

we can check the apache access log for the query “union select 1,2,3,4,5” in the URL. It will show some SQL Injection.

	$sudo cat /var/log/apache2/access.log | grep "union"

#### passwd

To searche for requests that try to read “/etc/passwd”, which is obviously a Local File Inclusion attempt.

	$sudo cat /var/log/apache2/access.log | grep "etc/passpwd"

