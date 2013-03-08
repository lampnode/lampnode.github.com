---
layout: post
title: "如何在Windows安装Tomcat 6"
tagline: "How to install tomcat6 on Windows"
description: ""
category: Windows  
tags: [ Tomcat ]
---
{% include JB/setup %}

## Steps

### Installation of JDK
Before beginning the process of installing Tomcat on your system, ensure first the availability of JDK on your system program directory. Install it on your system if not already installed (because any version of tomcat requires the Java 1.6 or higher versions) and then set the class path (environment variable) of JDK. To set the JAVA_HOME Variable: you need to specify the location of the java run time environment to support the Tomcat else Tomcat server can not run. 

see:[Installing JDK on Windows](/Windows/installing-jdk-on-windows/)

### Downloading Tomcat
We should download the tomcat package from http://tomcat.apache.org/download-60.cgi, Windows Service Installer(Binary Distributions->Core->32-bit/64-bit Windows Service Installer) is recommended.

### Install Tomcat
The process of installing Tomcat 6.0 begins here from now. It takes some steps for installing and configuring the Tomcat 6.0. The install path is:
 
	D:\Tomcat
 
After completing the installation process, the Apache Tomcat Manager appears on the toolbar panel like shown in the below picture.

### Setup the CATALINA_HOME Variable

you need to specify the location of the installation path to system CATALINA_HOME Variable .
 
	set CATALINA_HOME=D:\Tomcat
