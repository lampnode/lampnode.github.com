---
layout: post
title: "How to use SSH to create an HTTP Proxy"
tagline: "How to use SSH to create an HTTP Proxy"
description: ""
category: Linux
tags: [ Linux, SSH, Proxy ]
---
{% include JB/setup %}

The purpose of this document is to guide you simple way to create a HTTP proxy with SSH.

## Create SSH tunnel

Let us build a SSH tunnel with flag "-D":

	$ ssh -D 10000 user@remote_server


The proxy server is set up. It will listen on the port 10000 on your local machine as a socks proxy. 
Then, you should set up your browser to use this proxy server.

For Firefox 3, go to 

	Edit->Preferences->Advanced->Network->Settings

and specify that you want to use a Manual Proxy, localhost, port 10000 and SOCKS v5. Now your can browse 
internat throw secure tunnel by the remote server.



