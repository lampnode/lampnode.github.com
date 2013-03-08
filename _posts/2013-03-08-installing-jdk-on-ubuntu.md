---
layout: post
title: "在 Ubuntu上安装JDK"
tagline: "Installing JDK on Ubuntu"
description: ""
category: Linux
tags: [ JAVA, Ubuntu ]
---
{% include JB/setup %}

## From Ubuntu 10.04

### Adding source

 
	deb http://archive.canonical.com/ lucid partner
 
### Updating

 
	sudo apt-get update
 

### Installation

 
	sudo apt-get install sun-java6-jre sun-java6-jdk
 
	option packages
	sun-java6-bin - Contains the binaries
	sun-java6-demo - Contains demos and examples
	sun-java6-doc - Contains the documentation
	sun-java6-fonts - Contains the Lucida TrueType fonts from the JRE
	sun-java6-jdk - Contains the metapackage for the JDK
	sun-java6-jre - Contains the metapackage for the JRE
	sun-java6-plugin - Contains the plug-in for Mozilla-based browsers
	sun-java6-source - Contains source files for the JDK

### Config JVM

 
	sudo update-alternatives --config java
 
	There are 2 alternatives which provide `java'.
 
	Selection Alternative
	----------------------------------------------- 
	  # /usr/bin/gij-wrapper-4.1
	  *+ 2 /usr/lib/jvm/java-6-sun/jre/bin/java
 
Press enter to keep the default[*], or type selection number:

Chose 2
 
	sudo update-alternatives --config javac
 
### Config environment

 
	sudo gedit /etc/environment
 
Adding the following:
 
	JAVA_HOME=/usr/lib/jvm/java-6-sun
	CLASSPATH=.:/usr/lib/jvm/java-6-sun/lib
