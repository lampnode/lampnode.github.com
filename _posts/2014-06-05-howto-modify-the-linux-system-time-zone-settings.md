---
layout: post
title: "Howto modify the linux system time zone settings"
tagline: "Howto modify the linux system time zone settings"
description: ""
category: Linux 
tags: [ Linux, CentOS, Ubuntu ]
---
{% include JB/setup %}

The purpose of this document is to guide you setting the correct timezone on Linux (e.g. Ubuntu, CentOs ). If you have one 
more servers need to deploy same services, you should think about the time zone problem. 

## Check the time

You may check your current timezone by just running:

	$ date
	Thu Mar 21 18:02:49 MST 2012

checking the timezone file at

	$ more /etc/timezone
	US/Arizona

## projects

### Install NTP

#### On CentOS

Install ntp service and start it:

	$sudo yum install ntp
	$sudo /etc/init.d/htpd start
	$sudo chkconfig ntpd on
	

Then, sync the time:

	$sudo ntpdate us.pool.ntp.org

#### On ubuntu

Install ntp and run it:

    $sudo apt-get install ntp
    $sudo /etc/init.d/ntp start

### Update timezone

Timezone data (tzdata) is stored in /usr/share/zoneinfo. To change your system  timezone, 
simply run the following command:

	$sudo cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime



### Related services

You should make sure that all services are using the new time-zone. The simply method is to restart your server entirely,
or restart the following services.

#### cron

To restart cron as it won’t pick up the timezone change and will still be running on UTC.

	$ sudo /etc/init.d/cron restart

#### Apache

If you are running PHP you will find that you will need to restart the Apache service.

	$ sudo /etc/init.d/apache2 restart


