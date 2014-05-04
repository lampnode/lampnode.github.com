---
layout: post
title: "Howto setup static ip address on ubuntu 14.04"
tagline: "Howto setup static ip address on ubuntu 14.04"
description: ""
category: Linux 
tags: [Linux, Ubuntu]
---
{% include JB/setup %}

The purpose of this document is guide you to setup a static IP address on Ubuntu 14.04.

## Step 1

Open the interfaces file

	$sudo vim /etc/network/interfaces

If you are using DHCP for your network catd which is eth0(example), you will get the following:

	auto eth0
	iface eth0 inet dhcp

## Step 2

Remove the DHCP setup, and add the following for static IP:

	auto eth0
	iface eth0 inet static
	address 192.168.0.16
	netmask 255.255.255.0
	gateway 192.168.0.1
	dns-nameservers 208.67.222.222 208.67.220.220

## Step 3

Restart the neworking service using the following command

	$sudo /etc/init.d/networking restart


## Step 4

	$ ifconfig

{% highlight java %}
......
eth0      Link encap:Ethernet  HWaddr 00:1e:c9:3d:8a:49  
          inet addr:192.168.0.16  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1930 errors:0 dropped:0 overruns:0 frame:0
          TX packets:609 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:168762 (168.7 KB)  TX bytes:59741 (59.7 KB)
          Interrupt:16 
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:75 errors:0 dropped:0 overruns:0 frame:0
          TX packets:75 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:5065 (5.0 KB)  TX bytes:5065 (5.0 KB)
......
{%endhighlight %}


	$ cat /etc/resolv.conf 

{% highlight java %}
......
nameserver 208.67.222.222
nameserver 208.67.220.220
......	
{%endhighlight %}
