---
layout: post
title: "Install Oracle Java JDK 8 On CentOS 6.x"
tagline: "Install Oracle Java JDK 8 On CentOS 6.x"
description: ""
category: Linux 
tags: [ CentOS, JAVA, Linux ]
---
{% include JB/setup %}

This document describes how to install and configure Oracle JDK on CentOS 6.5 or later.

## Steps

### Update your server

	$sudo yum update

### Check old installed JDK

To search for if any other JDK versions has installed.

	$sudo rpm -qa | grep -E '^open[jre|jdk]|j[re|dk]'

Sample output:

	cjkuni-uming-fonts-0.2.20080216.1-36.el6.noarch
	pygobject2-2.20.0-5.el6.x86_64
	cjet-0.8.9-9.1.el6.x86_64
	cjkuni-fonts-common-0.2.20080216.1-36.el6.noarch
	openjpeg-libs-1.3-10.el6_5.x86_64
	libbasicobjects-0.1.1-11.el6.x86_64
	eject-2.1.5-17.el6.x86_64
	java-1.6.0-openjdk-1.6.0.34-1.13.6.1.el6_6.x86_64

To check the already installed Java version, enter the following command:

	$java -version

Sample output, none of any installed JDK:

	-bash: java: command not found

or, has installed:

	java version "1.6.0_34"
	OpenJDK Runtime Environment (IcedTea6 1.13.6) (rhel-1.13.6.1.el6_6-x86_64)
	OpenJDK 64-Bit Server VM (build 23.25-b01, mixed mode)

If Java 1.6 or 1.7 have been installed already,

	$ls -lA /etc/alternatives/ | grep java

Sample output:

	lrwxrwxrwx  1 root root 46 Feb 18 16:23 java -> /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin/java
	lrwxrwxrwx  1 root root 48 Feb 18 16:23 java.1.gz -> /usr/share/man/man1/java-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 51 Feb 18 16:23 keytool.1.gz -> /usr/share/man/man1/keytool-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 48 Feb 18 16:23 orbd.1.gz -> /usr/share/man/man1/orbd-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 51 Feb 18 16:23 pack200.1.gz -> /usr/share/man/man1/pack200-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 48 Feb 18 16:23 rmid.1.gz -> /usr/share/man/man1/rmid-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 55 Feb 18 16:23 rmiregistry.1.gz -> /usr/share/man/man1/rmiregistry-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 54 Feb 18 16:23 servertool.1.gz -> /usr/share/man/man1/servertool-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 53 Feb 18 16:23 tnameserv.1.gz -> /usr/share/man/man1/tnameserv-java-1.6.0-openjdk.1.gz
	lrwxrwxrwx  1 root root 53 Feb 18 16:23 unpack200.1.gz -> /usr/share/man/man1/unpack200-java-1.6.0-openjdk.1.gz

you can uninstall them using the following commands.

	$sudo yum remove java-1.6.0-openjdk

Let us check the alternatives

	$ls -lA /etc/alternatives/ | grep java

There are nothing should output. It make sure you have removed all old JDK versions from your system. 


### Download JDK

Go to the Oracle Java download page and download the required version depending upon your distribution architecture.

### Install JDK


	$sudo rpm -ivh jdk-8u25-linux-x64.rpm

Then, check Java version

Now, check for the installed JDK version in your system using command:

	$java -version

Sample output:

	java version "1.8.0_25"
	Java(TM) SE Runtime Environment (build 1.8.0_25-b17)
	Java HotSpot(TM) 64-Bit Server VM (build 25.25-b02, mixed mode)

As you see above, latest java 1.8 has been installed.

### Setup Global Environment Variables

To create a file called java.sh under /etc/profile.d/ directory. The script under /etc/profile.d 
will be loaded when starting up.

	$sudo vim /etc/profile.d/java.sh

Add the following lines:

	#!/bin/bash
	export JAVA_HOME=/usr/java/jdk1.8.0_25
	export PATH=$JAVA_HOME/bin:$PATH
	export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar

Save and close the file. Make it executable using command:

	$sudo chmod +x /etc/profile.d/java.sh

or 

	$sudo chmod 755 /etc/profile.d/java.sh


Then, set the environment variables permanently by running the following command:

	$source /etc/profile.d/java.sh

Now, let us check for the environment variables using commands:

	$echo $JAVA_HOME

Sample output:

	/usr/java/jdk1.8.0_25/

Or

	echo $PATH

Sample output:

	/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/usr/java/jdk1.8.0_25/


All done.
