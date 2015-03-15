---
layout: post
title: "PHP:How to lookup country code by GeoIP"
tagline: "PHP:How to lookup country code by GeoIP"
description: ""
category: 
tags: [ PHP, Network ]
---
{% include JB/setup %}

This document will show you how to use the GeoIP data  easily and quickly to lookup country code.


## Download GeoIP package

* Download [GeoLite Country (binary format)](http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz), and extract the file GeoIP.dat. 
* download [geoip.inc](http://www.maxmind.com/download/geoip/api/php/geoip.inc), this is php script.

## The Code

First, include the library and open the geoip database:

	include_once("geoip.inc");
	$gi = geoip_open("GeoIP.dat",GEOIP_STANDARD);

Then, getting the country code:

	$ip='202,122.23.1';
	$country_code = geoip_country_code_by_addr($gi,$ip);
	
	echo "Your country code is: $country_code \n";

finally, close the geoip database:

	geoip_close($gi);
	
This solution uses a very fast and compact binary file as the database to lookup the country code by the IP address. 


