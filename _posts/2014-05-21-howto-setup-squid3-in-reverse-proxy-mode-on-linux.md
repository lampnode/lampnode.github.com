---
layout: post
title: "Howto setup Squid3 in reverse Proxy mode on Linux"
tagline: "Howto setup Squid3 in reverse Proxy mode on Linux"
description: ""
category: Linux
tags: [ Linux, Squid, Proxy ]
---
{% include JB/setup %}

The purpose of this document is guide you to use Squid in reverse proxy, or web accelerator mode. 

## Requirement

In this case, we need to achieve nornal access to the exmaple1.com and example2.com through the Server3.

	Server1: 192.168.0.11 / Webserver / domain: example1.com
	Server2: 192.168.0.12 / Webserver / domain: example2.com
	Server3: 192.168.0.13 / Squid Server(Accelerator)/ domain: example3.com


## Setup

In the configuration file below on Server3, we will setup the squid.conf file to be in http-accelerator mode.

NOTE: If you runs the httpd deamon on the server3, you should assign another port for httpd before you edit squid.conf.

	robert@example3.com:~$sudo vim /etc/squid3/squid.conf

### TAG:acl

you need to tell Squid where to find the real web server.  

	acl ACL_FLAG_FOR_SITES dstdomain your.backend.website.name

In this case, add the following at the end of this section:

	acl sites dstdomain .example1.com
	acl sites dstdomain .example2.com

NOTE: the "sites" is a defined variable [ ACL_FLAG_FOR_SITES ].

### TAG:http_access

You need to set up access controls to allow access to your site without pushing other web requests 
to your web server. Find the comment content as below:

    # INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS

Then, add the following content after the above comment content.

	http_access allow sites

### TAG:http_port

Define the listen port: 

	http_port 80 vhost

or

	http_port 80 vhost defaultsite=your.main.website

If you are using Squid-3.1 or older has an accelerator for a domain based virtual host system then you need 
to additionally specify the vhost option to http_port

	http_port 80 accel defaultsite=your.main.website.name vhost

 - accel tells Squid to handle requests coming in this port as if it was a Web Server
 - defaultsite=X tells Squid to assume the domain X is wanted.
 - vhost for Squid-3.1 or older enables HTTP/1.1 domain based virtual hosting support. Omit this option for Squid-3.2 or later versions.

When both defaultsite and vhost is specified, defaultsite specifies the domain name old HTTP/1.0 clients not sending a Host 
header should be sent to. Squid will run fine if you only use vhost, but there is still some software out there not sending 
Host headers so it`s recommended to specify defaultsite as well. If defaultsite is not specified those clients will get an 
"Invalid request" error.

### TAG:cache_peer    

You need to tell squid where to find the real web server:

	cache_peer backend.webserver.ip.or.dnsname parent 80 0 no-query originserver name=myAccel

In this case, add the following at the end of this section: 

	cache_peer 192.168.0.11 parent 80 0 no-query originserver name=exa
	cache_peer 192.168.0.12 parent 80 0 no-query originserver name=exb

   
### TAG:cache_peer_domain

The "cache_peer_domain" directive allows you to specify that certain caches siblings or parents for certain domains:
    
	cache_peer_domain exa www.example1.com
	cache_peer_domain exb www.example2.com

if your want access news.example1.com, blog.example1.com, you should setup the cache_peer_domain as the following
for example1.com

	cache_peer_domain exa .example1.com

### TAG:cache_peer_access

	cache_peer_access exa allow sites
	cache_peer_access exb allow sites	

## test

### Check the config

	sudo squid3 -k parse

### Boot the Squid

	sudo service squid3 restart

### Check the listen port 

	robert@example3.com:~$ sudo lsof -i:80
	[sudo] password for robert: 
	COMMAND  PID  USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
	squid3  2023 proxy    9u  IPv6  14409      0t0  TCP *:http (LISTEN)
