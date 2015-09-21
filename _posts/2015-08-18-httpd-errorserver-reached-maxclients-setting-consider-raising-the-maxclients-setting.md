---
layout: post
title: "Httpd Error:server reached MaxClients setting, consider raising the MaxClients setting"
tagline: "Httpd Error:server reached MaxClients setting, consider raising the MaxClients setting"
description: ""
category: Linux 
tags: [Httpd, PHP, Apache]
---
{% include JB/setup %}

The purpose of this ducument is show you how to fix maxClinents error.

### Error

The apache server stops to work and It need to restart it. The server log said this:

	[error] server reached MaxClients setting, consider raising the MaxClients setting


### How to fix it

If you use httpd with mod_php, the httpd is enforced in "prefork" mode, and not "worker". 

The MaxClients value is located in the main Apache configuration file, typically " /etc/httpd/httpd.conf".
The relevant section looks like this:

	<efModule prefork.c>
		StartServers      8
		MinSpareServers   5
		MaxSpareServers   20
		ServerLimit      256
		MaxClients       256
		MaxRequestsPerChild  4000
	</IfModule>


#### To Determine How Much RAM is Available to Apache

The amount of RAM available to Apache is the total amount of RAM on the system minus the amount that will be used by all other processes. 

#### to Determine How Much RAM a Single Apache Process Uses

The Max Process Size can be found with the following command, note that the size is in KB, so you will need to divide that by 1024.

	ps -ylC httpd --sort:rss

 The RSS column in "ps -ylC httpd --sort:rss" shows non-swapped physical memory usage by Apache processes in kiloBytes.

sample output:

	S   UID   PID  PPID  C PRI  NI   RSS    SZ WCHAN  TTY          TIME CMD
	S     0 18278 18276  0  80   0 10316 111806 semtim ?       00:00:00 httpd
	S   502 18279 18276  0  80   0 11116 130803 ep_pol ?       00:00:00 httpd
	S   502  7331 18276  0  80   0 12132 132661 poll_s ?       00:00:00 httpd
	S   502  7340 18276  0  80   0 13004 132727 poll_s ?       00:00:00 httpd
	S   502  7339 18276  0  80   0 27832 158216 semtim ?       00:00:00 httpd


The following is an algorithm for finding a suitable number.

	MaxClients = Total RAM dedicated to the web server / Max child process size 

Look at the highest value under RSS, In this sample output, it was 27832 (27Mb) and if you have 16GB of RAM, the value of  maxClient could be raised to max value is 606(16*1024/27).

Note: If you increase the MaxClients, you should increase the ServerLimit to match too.





