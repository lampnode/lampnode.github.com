---
layout: post
title: "HowTo install and setup svn on CentOs"
tagline: "HowTo install and setup svn on CentOs"
description: ""
category: Linux
tags: [ Subversion, Linux, CentOs ]
---
{% include JB/setup %}

## Preparation

- Env：CentOS 5.6/RHEL 5.6
- Softwares：httpd mod_dav_svn mod_ssl subversion

## Install packages

	#yum install -y mod_dav_svn mod_ssl subversion
 
If you wish to confirm the version you have, run the following command, which will list the available protocols.

{% highlight bash %} 
[root@edwin~]# svn --version 
svn, version 1.6.11 (r934486)
   compiled Jun  8 2011, 16:22:13
 
Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).
 
The following repository access (RA) modules are available:
 
* ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
{% endhighlight %} 
 
## Setup

### Create subversion`s pathes

Once subversion is installed, we’ll need a directory on which to store the repositories. we are using "/opt/subversion". That directory 
will hold four things: some subversion stylesheets for web display, the repositories themselves, SSL keys and the config files.

	# mkdir /opt/subversion
	# mkdir /opt/subversion/repos
	# mkdir /opt/subversion/config
	# mkdir /opt/subversion/styles
	# mkdir /opt/subversion/keys

**Note：** /repos is root patch of repository.

### Add styles for SVN`s web browser
 
	# cp /usr/share/doc/subversion-XXX/tools/xslt/svnindex* /opt/subversion/styles
 
Create the first repo, named test
 
	# mkdir /opt/subversion/repos/test
	# svnadmin create /opt/subversion/repos/test
 
Modify the permission of repos And since we’ll be accessing this via apache, give permissions to the group. 

	# chgrp apache -R /opt/subversion/repos
	# chmod g+w -R /opt/subversion/repos
 
### Create users

create user db file named users，and add the first svn account named mysvnuser
 
	# cd /opt/subversion/config
	# htpasswd -cm users mysvnuser
 
Add another account named secoundsvnuser
 
	# htpasswd -m users secondsvnuser
 
Create auth file named authz.conf
 
	# vim authz.conf
 
Add the fllowing content to this file:

{% highlight bash %} 
[groups]
todos = user1, user2
proj = user1
 
[repoA:/]
@todos = r
* =  

[reposB:/]
@proj = rw
*=

{% endhighlight %} 

### Create a self-signed certification

We’ll now create a self-signed SSL certificate.

	# cd /opt/subversion/keys
	# openssl genrsa -des3 -rand file1:file1 -out svn.key 1024
	# openssl rsa -in svn.key -out svn.pem
	# openssl req -new -key svn.pem -out svn.csr
	# openssl x509 -req -days 365 -in svn.csr -signkey svn.pem -out svn.crt

**Note:**svn.pem is key, and our certificate is svn.crt

	# chgrp apache -R /opt/subversion/keys
	# chmod go-rwx /opt/subversion/keys/svn.crt
	# chmod go-rwx /opt/subversion/keys/svn.pem

### Apache VirtualHost configuration file for the svn

#### Method A
 
	# vim /etc/httpd/conf.d/ssl.conf
 
Add the flollowing information after the tag named location.

{% highlight bash %} 
<Location /p>
   DAV svn
   SVNParentPath /opt/workspace/subversion/repos
 
#   # Limit write permission to list of valid users.
#   <LimitExcept GET PROPFIND OPTIONS REPORT>
#      # Require SSL connection for password protection.
      SSLRequireSSL
#:
      AuthType Basic
      AuthName "Bestbackup svn server"
      AuthUserFile /opt/subversion/config/users
      AuthzSVNAccessFile /opt/subversion/config/authz.conf
      Require valid-user
#   </LimitExcept>
</Location>
{% endhighlight %} 

Method A is actually simple, but in linux, When you check out the code,svn will report an error similar to the following:
	
	 SSL handshake failed: SSL error: A TLS warning alert has been received.

The svn client does not recognize the self-signed certification, so it is recommended to use the  method B.
 
	[root@edwin~]#vim /etc/httpd/conf.d/svnsite.conf
 
Let`s suppose you`ll be creating a separate site for this, called svn.yoursitename.com.


{% highlight bash %} 
<VirtualHost svn.yoursitename.com:443>
    DocumentRoot "/opt/subversion/styles"
    ServerName svn.yoursitename.com
    SSLEngine on
    SSLCipherSuite ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP
    SSLCertificateFile /opt/subversion/keys/svn.crt
    SSLCertificateKeyFile /opt/subversion/keys/svn.pem
    <Location /repos>
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
    ServerAdmin webmaster@yoursitename.com
</VirtualHost>
{% endhighlight %}
 
### Reboot apache
 
	[root@edwin~]#service httpd restart
