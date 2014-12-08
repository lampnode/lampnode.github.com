---
layout: post
title: "How to Installing and Configuring Logwatch on Linux"
tagline: "How to Installing and Configuring Logwatch on Linux"
description: ""
category: Linux
tags: [ Linux, CentOs, Ubuntu ]
---
{% include JB/setup %}

All of applications in the Linux create log files to keep track of activities. A good log file should be
as detailed as posible in order to help the administrator, who have the responsibility of maintaining the 
system, find the exact information needed for a certain purpose. This is where Logwatch, a perfect application
that designed for this job.

## Installing Logwatch

### On CentOs

Using YUM to install logwatch, run the folloing: 

	# yum install -y logwatch

### On Ubuntu

To install logwatch on Ubuntu, run the folloing:

	#sudo apt-get install -y logwatch

## Configuring Logwatch

The default configuration file for logwatch on linux(Ubuntu/CentOs) is located at:

	/usr/share/logwatch/default.conf/logwatch.conf

Let us open up this file in order to modify the variables:

	#sudo vim /usr/share/logwatch/default.conf/logwatch.conf

In order to begin using the logwatch, we will need to make a few changes to these valiables. The important options which we need to set:

### The email address to receive the daily digest reports from logwatch:

	MailTo = root

Replace root with your email address:
	
	MailTo = user@domain.com 


### Setting the range for the reports

	Range = yesterday

You have options of receiving reports for All (all available since the beginning), Today (just today) or Yesterday (just yesterday).

### Setting the reports detail level

	Detail = Low


You can modify the reports detail level here. Options are: Low, Medium and High.

### Setting services/applications to be analysed

By default, the logwatch covers a wide range of services/application. If you would like to see a full list, running the following:

	ls -l /usr/share/logwatch/scripts/services
	
You can choose to receive reports for all services or some specific ones.

#### For all services
	
To keep the line as: Service = All

If you want to disable specific services, listing each service after the "Service = All":

	Service= "-http"
	Service= "-cron"
	Service= "-dpkg"
	Service= "-postfix"
	

#### For specific service(s)

If you wish to receive reports for specific ones, modify it similar to the following example, listing each service on a new line:

	Service = sendmail
	Service = http
	Service = identd
	Service = sshd2
	Service = sudo

## Running Logwatch Manually


To run the Logwatch manually whenever you need through the command line(Unless you specify an option, it will be read from 
the configuration file):

### Print on the screen:

	logwatch --print

### Send to the email

	logwatch --range today --print --mailto yourmail@gmail.com

### Print on the screen for specific service:

	logwatch --service sshd --print
