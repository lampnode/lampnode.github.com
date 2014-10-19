---
layout: post
title: "Enabling APC UPS on Ubuntu"
tagline: "Enabling APC UPS on Ubuntu"
description: ""
category: Linux 
tags: [ Ubuntu ]
---
{% include JB/setup %}

If your Ubunut has connected to APC smartUPS using usb cable, the following guide is for you.

## Introduction

Linux comes with GPL licensed open source apcupsd server ( daemon ) that can be used for power mangement and controlling most of APC UPS models on Linux. Apcupsd works with most of APC Smart-UPS models as well as most simple signalling models such a Back-UPS, and BackUPS-Office. 

## Steps

### Install APCUPSD

#### Essential packages

Type the following apt-get command 

	$ sudo apt-get install apcupsd

Edit /etc/default/apcupsd, enter:

	$sudo vim /etc/default/apcupsd

Set ISCONFIGURED to yes:

	ISCONFIGURED=yes

#### Optional packages

You can install a package called apcupsd-cgi so that you can monitor your UPS load, uptime, logs and other details using www. Type the following apt-get command to install the same:

	$ sudo apt-get install apcupsd-cgi

### Configuration

Edit /etc/apcupsd/apcupsd.conf, enter:

	$sudo vim /etc/apcupsd/apcupsd.conf


#### UPSCABLE 

Change the UPSCABLE to the one that matches your particular battery backup, in this and most cases change it to usb.

	UPSCABLE usb


#### UPSTYPE

For USB UPS, please leave the DEVICE directive blank.


	UPSTYPE usb
	DEVICE

#### Configuration parameters used during power failures

The ONBATTERYDELAY directive defined the time in seconds from when a power failure s detected until we react to it with an onbattery event:

	ONBATTERYDELAY 6


If during a power failure, the remaining battery percentage (as reported by the UPS) is below or equal to BATTERYLEVEL, apcupsd will initiate a Linux system shutdown:

	BATTERYLEVEL 5

If during a power failure, the remaining runtime in minutes (as calculated internally by the UPS) is below or equal to MINUTES, apcupsd, will initiate a system shutdown.

	MINUTES 3

If during a power failure, the UPS has run on batteries for TIMEOUT many seconds or longer, apcupsd will initiate a system shutdown. A value of 0 disables this timer:

	TIMEOUT 0

Save and close the file.
	

### Restart the services

	$sudo /etc/init.d/apcupsd restart

Look for any errors, if you don’t see anything great.

#### Test ups

	$apctest

#### Check current status of UPS

	$apcaccess

#### Check the logs

	$sudo tail -f /var/log/apcupsd.events


