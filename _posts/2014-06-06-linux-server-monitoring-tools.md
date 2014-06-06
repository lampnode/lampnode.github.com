---
layout: post
title: "Linux server monitoring tools"
tagline: "Linux server monitoring tools"
description: ""
category: Linux 
tags: [ Linux ]
---
{% include JB/setup %}


## htop

The hop is an interactive process viewer for Linux on command-line mode.

	$ sudo apt-get install htop 


Read more: [http://hisham.hm/htop/](http://hisham.hm/htop/)

## iotop

Iotop is a Python program with a top like UI used to show of behalf of which process is the I/O going on.

### Installation

#### Ubuntu

	$ sudo apt-get install iotop 

#### CentOS

	# yum install python python-ctypes
	# yum install iotop

### Usage

	# iotop

Or

	# iotop --only

To use iotop with "-o" or "--only" option to see all the running processes or threads actually doing I/O, instead of watching all processes or threads.

Read more: [http://guichaz.free.fr/iotop/](http://guichaz.free.fr/iotop/)

## apachetop 

ApacheTop is a curses-based top-like display for Apache information, including requests per second, bytes per second, most popular URLs, etc. 

### Installation

#### Ubuntu

	$ sudo apt-get install apachetop

#### CentOS

	#yum install apachetop

Read more: [http://freecode.com/projects/apachetop](http://freecode.com/projects/apachetop)

### Usage

You can launch it by simply running apachetop from the command line. 

	$ apachetop

Since apachetop sometimes defaults to the wrong directory for the logfiles, you can pass in the -f parameter to specify the location of the logfile.

	# apachetop -N 300 -f /var/logs/http/access_log

This command will show stats for hits in the last 5 minutes.

	#  apachetop -T 100 -f /var/log/httpd/access_log

This command will have apachetop remember the last 100 hits and show the statistics for them.


## glances

Glances is a cross-platform curses-based monitoring tool written in Python. This utility uses the psutil library to fetch the statistical values from your server.

### Installation

#### Ubuntu

	$ sudo apt-get install glances

or

	$ sudo apt-get install python-pip build-essential python-dev

	$ sudo pip install Glances

#### CentOS
	
	# yum -y install glances

#### Usage

	$ glances


Read more: [https://github.com/nicolargo/glances](https://github.com/nicolargo/glances)

