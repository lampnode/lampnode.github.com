---
layout: post
title: "Install Oracle Java on Ubuntu 13.10"
tagline: "Install Oracle Java on Ubuntu 13.10"
description: ""
category: Java
tags: [JAVA, Ubuntu ]
---
{% include JB/setup %}

This simple tutorial is how install Oracle java on Ubuntu 13.10.

## Steps

### Disable another java

	$sudo apt-get purge openjdk*

### Add source(PPA)

	$sudo add-apt-repository ppa:webupd8team/java
	$sudo apt-get update

Note: if the conmand "add-apt-repository" can not found, try it:

	$sudo apt-get install python-software-properties

### Install

#### To install Oracle Java 8

	$sudo apt-get install oracle-java8-installer

#### To install Oracle Java 7

	$sudo apt-get install oracle-java7-installer

#### To install the Java 6

	$sudo apt-get install oracle-java6-installer

### Config path

Add JAVA_HOME, CLASSPATH, PATH to profile:

	$sduo vim /etc/profile

Sample as:

	JAVA_HOME=/usr/lib/jvm/java-8-oracle
	CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH
	PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

Test the config:

	$source /etc/profile
	$echo $JAVA_HOME
		/usr/lib/jvm/java-8-oracle
	

