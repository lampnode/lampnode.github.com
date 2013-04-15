---
layout: post
title: "如何在CentOs上安装SVN"
tagline: "HowTo install and setup svn on CentOs"
description: ""
category: Linux
tags: [ Subversion, Linux, CentOs ]
---
{% include JB/setup %}

## Preparation

- Env：CentOS 5.6/RHEL 5.6
- software：httpd mod_dav_svn mod_ssl subversion

## Install packages

	[root@edwin~]# yum install -y mod_dav_svn mod_ssl subversion
 
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

### Create subversion's pathes

Once subversion is installed, we’ll need a directory on which to store the repositories. we are using /opt/subversion. That directory will hold four things: some subversion stylesheets for web display, the repositories themselves, SSL keys and the config files.
{% highlight bash %} 
[root@edwin~]# mkdir /opt/subversion
[root@edwin~]# mkdir /opt/subversion/repos
[root@edwin~]# mkdir /opt/subversion/config
[root@edwin~]# mkdir /opt/subversion/styles
[root@edwin~]# mkdir /opt/subversion/keys
{% endhighlight %} 
**Note：** /repos is root patch of repository.

### Add styles for SVN's web browser
 
	[root@edwin~]# cp /usr/share/doc/subversion-XXX/tools/xslt/svnindex* /opt/subversion/styles
 
Create the first repo, named test
 
	[root@edwin~]# mkdir /opt/subversion/repos/test
	[root@edwin~]# svnadmin create /opt/subversion/repos/test
 
Modify the permission of repos And since we’ll be accessing this via apache, g
ive permissions to the group. 

	[root@edwin~]# chgrp apache -R /opt/subversion/repos
	[root@edwin~]# chmod g+w -R /opt/subversion/repos
 
### Create users

create user db file named users，and add the first svn account named mysvnuser
 
	[root@edwin~]# cd /opt/subversion/config
	[root@edwin~]# htpasswd -cm users mysvnuser
 
Add another account named secoundsvnuser
 
	[root@edwin~]# htpasswd -m users secondsvnuser
 
Create auth file named authz.conf
 
	[root@edwin~]# vim authz.conf
 
Add the fllowing content to this file:
{% highlight bash %} 
[groups]
todos = user1, user2
proj = user1
 
[/]
@todos = r
 
[/myproj]
@proj = rw
{% endhighlight %} 

### Create a self-signed certification
We’ll now create a self-signed SSL certificate.
{% highlight bash %} 
[root@edwin~]# cd /opt/subversion/keys
[root@edwin~]# openssl genrsa -des3 -rand file1:file1 -out svn.key 1024
[root@edwin~]# openssl rsa -in svn.key -out svn.pem
[root@edwin~]# openssl req -new -key svn.pem -out svn.csr
[root@edwin~]# openssl x509 -req -days 365 -in svn.csr -signkey svn.pem -out svn.crt
{% endhighlight %} 
**Note:**svn.pem is key, and our certificate is svn.crt

{% highlight bash %} 
[root@edwin~]# chgrp apache -R /opt/subversion/keys
[root@edwin~]# chmod go-rwx /opt/subversion/keys/svn.crt
[root@edwin~]#chmod go-rwx /opt/subversion/keys/svn.pem
{% endhighlight %} 

### Apache VirtualHost configuration file for the svn

#### Method A
 
	[root@edwin~]# vim /etc/httpd/conf.d/ssl.conf
 
Add the flollowing information after the tag named location

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
方法A倒是简单，不过在linux下，迁出代码库的时候，会报类似如下的错误:
	
	 SSL handshake failed: SSL error: A TLS warning alert has been received.

这是svn客户端对服务器的自签名不识别的缘故，所以，还是推荐使用第二种方法。

#### Method B
 
	[root@edwin~]#vim /etc/httpd/conf.d/svnsite.conf
 
Let’s suppose you’ll be creating a separate site for this, called svn.yoursitename.com.


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
