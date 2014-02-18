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
Ubuntu 13.10

## Steps


### insall and config svn 

See [HowTo install and setup svn on CentOs](/linux/howto-install-and-setup-svn-on-centos)

### enable ssl

	sudo a2enmod ssl
	ls sites-available/
	ls sites-enabled/	

### Checking the user and group of apache

	vim /etc/apache2/apache2.conf 

### Edit default-ssl.conf

	sudo vim sites-available/default-ssl.conf 

{% highlight bash%}
	<IfModule mod_ssl.c>
	<VirtualHost _default_:443>
		ServerAdmin webmaster@localhost

		DocumentRoot /opt/svnrepos/subversion/styles
		
		<Directory "/opt/svnrepos/subversion/styles">
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny  
                allow from all
                Require all granted
	        </Directory>


		ErrorLog ${APACHE_LOG_DIR}/error.log
		CustomLog ${APACHE_LOG_DIR}/access.log combined


		#   Enable/Disable SSL for this virtual host.
		SSLEngine on

		#SSLCertificateFile	/etc/ssl/certs/ssl-cert-snakeoil.pem
		#SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
		SSLCertificateFile /opt/svnrepos/subversion/keys/svn.crt
		SSLCertificateKeyFile /opt/svnrepos/subversion/keys/svn.pem


		#   SSL Engine Options:
		<FilesMatch "\.(cgi|shtml|phtml|php)$">
				SSLOptions +StdEnvVars
		</FilesMatch>
		<Directory /usr/lib/cgi-bin>
				SSLOptions +StdEnvVars
		</Directory>

		#   SSL Protocol Adjustments:
		BrowserMatch "MSIE [2-6]" \
				nokeepalive ssl-unclean-shutdown \
				downgrade-1.0 force-response-1.0
		# MSIE 7 and newer should be able to use keepalive
		BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown
		
		<Location /p>
	        DAV svn
	        SVNParentPath /opt/svnrepos/subversion/repos
	        SVNIndexXSLT "/svnindex.xsl"
	        AuthzSVNAccessFile /opt/svnrepos/subversion/config/authz.conf
	        Satisfy all
	        Require valid-user
	        # authenticating them valid ones
	        AuthType Basic
	        AuthName "Subversion Repositories at yoursitename.com"
	        AuthUserFile /opt/svnrepos/subversion/config/users
		</Location>
	</VirtualHost>
	</IfModule>
{% endhighlight %}

	sudo a2ensite default-ssl

### Reboot The apache
	
	sudo /etc/init.d/apache2 restart
