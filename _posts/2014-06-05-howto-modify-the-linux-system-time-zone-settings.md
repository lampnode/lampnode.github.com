---
layout: post
title: "Howto modify the linux system time zone settings"
tagline: "Howto modify the linux system time zone settings"
description: ""
category: Linux 
tags: [ Linux, CentOS, Ubuntu ]
---
{% include JB/setup %}

The purpose of this document is to guide you setting the corrct timezone on Linux (e.g. Ubuntu, CentOs ).

## Check the time

You can check your current timezone by just running

	$ date
	Thu Mar 21 18:02:49 MST 2012

checking the timezone file at

	$ more /etc/timezone
	US/Arizona

## Update the timezone

### CentOS


#### Installation

	$sudo yum install ntp

Then

	$sudo ntpdate us.pool.ntp.org


#### Update timezone

Timezone data (tzdata) is stored in /usr/share/zoneinfo. To change your system  timezone, 
simply run the following command:

	$sudo cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


### Ubuntu

To change it just run

	$ sudo dpkg-reconfigure tzdata


### Related services

You should make sure that all services are using the new time-zone. The simply method is to restart your server entirely,
or restart the following services.

#### cron

To restart cron as it won’t pick up the timezone change and will still be running on UTC.

	$ sudo /etc/init.d/cron restart

#### Apache

If you are running PHP you will find that you will need to restart the Apache service.

	$ sudo /etc/init.d/apache2 restart


