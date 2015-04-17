---
layout: post
title: "How to install tomcat8 on window 7"
tagline: "How to install tomcat8 on window 7"
description: ""
category: Java
tags: [ Tomcat, Java ]
---
{% include JB/setup %}

## Steps

### Installation of JDK
Before beginning the process of installing Tomcat on your system, ensure first the availability of JDK on your system program directory. Install it on your system if not already installed (because any version of tomcat requires the Java 1.7 or higher versions).

Then, you should set the class path (environment variable) of JDK. To set the JAVA_HOME Variable: you need to specify the location of the java run time environment to support the Tomcat else Tomcat server can not run.

see:[Installing JDK on Windows](/Windows/installing-jdk-on-windows/)

### Downloading Tomcat

We should download the tomcat package from http://tomcat.apache.org/download-60.cgi, Windows Service Installer(Binary Distributions 64-bit Windows Service Installer) is recommended.

### Install Tomcat

#### Extract the file

Extract the downloaded file to your D Drive. You should create a folder named as  "apache-tomcat" to save the tomcat application:

        D:\apache-tomcat

#### Setup the CATALINA_HOME Variable

you need to specify the location of the installation path to system CATALINA_HOME  variable . then, add JRE_HOME, re-configurate the CLASSPATH:

        set CATALINA_HOME=D:\apache-tomcat
        set JRE_HOME=C:\the\path\to\jre
        add %CATALINA_HOME%\lib;%CATALINA_HOME%\bin to %CLASSPATH%

Navigate to d:/apache-tomcat/bin, and run startup.bat to sart the tomcat. Now to test the tomcat is up or not, you can just open any browser and type http://localhost:8080/.

#### Installing services

The safest way to manually install the service is to use the provided service.bat script. 

	D:\> apache-tomcat\bin\service.bat install

### Managing Tomcat

For security, access to the manager webapp is restricted. Users are defined in:

	$CATALINA_HOME/conf/tomcat-users.xml

In Tomcat 8.0 access to the manager application is split between different users. setup example:

	<role rolename="manager-gui"/>
	<role rolename="manager-script"/>
	<user username="tomcat" password="tomcat" roles="manager-gui,manager-script"/>






