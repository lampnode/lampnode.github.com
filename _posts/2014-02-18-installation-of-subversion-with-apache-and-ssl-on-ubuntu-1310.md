---
layout: post
title: "Installation of Subversion with Apache and SSL on ubuntu 13.10"
tagline: "在Ubuntu 13.10上安装Apache和SSL的Subversion"
description: ""
category: Ubuntu
tags: [ Ubuntu, Subversion ]
---
{% include JB/setup %}

Direct access to the subversion server is not safe, so the encryption processing is the most basic security strategy

## Condiation

System:Ubuntu 13.10

## Steps


### Insall and setup svn repository 

#### Install subversion and related packages

	$sudo apt-get install subversion libapache2-svn apache2

#### Create the subversion repository

The example respotory directorys:

	+/subversion
	+------/repos
	+------/config
	+------/styles
	+------/keys

Please refer to [HowTo install and setup svn on CentOs](/linux/howto-install-and-setup-svn-on-centos)

### Enable apache ralated  modules

You should use the command a2enmod to enable ssl, authz_svn:

	$sudo a2enmod ssl
	$sudo a2enmod authz_svn

***NOTE*** If you do not enable authz_svn, there are an error will been reported when you
reboot the apache2. The error like:


	Syntax error on line 64 of /etc/apache2/mods-enabled/dav_svn.conf:
	Invalid command ‘AuthzSVNAccessFile’, perhaps misspelled or defined by a module not included in the server configuration
	Action ‘configtest’ failed.
	The Apache error log may have more information.
	…fail!


Then,Check the following pathes:

	$ls /etc/apache2/sites-available/
	$ls /etc/apache2/sites-enabled/	

### Checking the user and group of apache

	$sudo vim /etc/apache2/apache2.conf

In ubuntu, The default user/group for Apache service is www-data. In this example, the subverion respository is saved on "/opt". 
Let`s change the owner of the repository.

	$sudo chown -R www-data:www-data /opt/subversion

### Edit default-ssl.conf

	$sudo vim /etc/apache2/sites-available/default-ssl.conf 

#### Update the DocumentRoot configuration:

Modify the "DocumentRoot"

 	DocumentRoot /opt/subversion/styles

Then, add the directory configuration for the new "DocumentRoot":

	<Directory "/opt/subversion/styles">
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		allow from all
		Require all granted
	</Directory>

#### Update the SSL Certificate files

Comment out the relevant parameters, add the following content

	#SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
	#SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
	SSLCertificateFile /opt/subversion/keys/svn.crt
    SSLCertificateKeyFile /opt/subversion/keys/svn.pem

#### Add the location for the repository

Add the following content before the tag "</VirtualHost>":

	<Location /p>
		DAV svn
		SVNParentPath /opt/subversion/repos
		SVNIndexXSLT "/svnindex.xsl"
		AuthzSVNAccessFile /opt/subversion/config/authz.conf
		Satisfy all
		Require valid-user
		# authenticating them valid ones
		AuthType Basic
		AuthName "Subversion Repositories at yoursitename.com"
		AuthUserFile /opt/subversion/config/users
	</Location>

You should use the command a2ensite to enable default-ssl:

	$sudo a2ensite default-ssl

### Reboot The apache
	
	$sudo /etc/init.d/apache2 restart
