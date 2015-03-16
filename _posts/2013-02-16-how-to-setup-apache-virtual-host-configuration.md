---
layout: post
title: "How To Setup Apache Virtual Host Configuration"
tagline: "How To Setup Apache Virtual Host Configuration"
description: ""
category: Apache 
tags: [ Httpd, Apache, Network ]
---
{% include JB/setup %}


This document attempts to show you how to creating virtual host configurations on your Apache server.

## Steps

### Web server deployment

It's supposed that our web apps directory are placed to "/opt/web"

#### For IP address accessing

add a new directory named "default" in "/var/www/html" for Ip based request.

#### For domain accessing

The Web applications directory structure are as follows:

    /opt/web/com.example #for example.com and www.example.com
    /opt/web/com.example.home #for home.example.com
    /opt/web/org.example #for example.org and www.example.org

Then, create a sub-directory in each web application directory, to store pubic application or html files. If the application 
have security files, it is a good choice that stored them in the root directory.

    /opt/web/com.example/www    # For html
    /opt/web/com.example/files  # For security path

### vhost configuration

Open the file "/etc/httpd/conf/httpd.conf"

    $ sudo vim /etc/httpd/conf/httpd.conf
  
Listen for virtual host requests on all IP addresses

    NameVirtualHost *:80

Then, add the following text to the end of this file:

{% highlight bash %}

	<VirtualHost *:80>
	    #ServerAdmin your.mail@domain.com
	    DocumentRoot "/opt/web/com.example/www"
	    ServerName example.com
	    ServerAlias www.example.com
	    ErrorLog "logs/example.com-error.log"
	    CustomLog "logs/example.com-access.log" common
	    <Directory "/opt/web/example.com/www">
		    Options -Indexes FollowSymLinks
		    AllowOverride All
		    Order allow,deny
		    Allow from all
	    </Directory>
	</VirtualHost>

{% endhighlight %}
	
Apache 2.4.3 added a new security feature that often results in this error. 
You would also see a log message of the form: 

    client denied by server configuration

The feature is requiring a user identity to access a directory. It is turned on by DEFAULT 
in the "httpd.conf" that ships with Apache:

    Require all denied

This basically deny access to all users. To fix this problem, either remove the denied directive 
(or much better) add the following directive to the directories you want to grant access to:

    Require all granted
    
as in:

    <Directory "your directory here">
       ......
       # New directive needed in Apache 2.4.3: 
       Require all granted
       ......
    </Directory>

### Reboot apache

	$sudo service httpd restart
