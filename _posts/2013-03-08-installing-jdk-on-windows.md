---
layout: post
title: "在Windows上安装JDK"
tagline: "Installing JDK on Windows"
description: ""
category: Windows
tags: [ Windows, JAVA ]
---
{% include JB/setup %}

## Step 1 Download

- Goto Java SE download site @ http://www.oracle.com/technetwork/java/javase/downloads/index.html.
- Select "Java SE 6 Update 29", "JDK".
- Choose your operating platform,examples: Windows x86 (for 32-bit Windows) "jdk-7-windows-i586.exe", jdk-6u29-windows-x64.exe, for Windows Xp 64bit

## Step 2 Install

Run the downloaded installer, which installs both the JDK (Java Development Kit) and JRE (Java Runtime). By default, the JDK and JRE will be installed into directories "C:\Program Files\java\jdk1.6.0_14" and "C:\Program Files\java\jre6", respectively. For novices, accept the defaults. I shall refer to the JDK installed directory as <JAVA_HOME>, hereafter, in this article.

### For Advanced Users

- The default JDK/JRE directories work but I recommend avoiding "Program Files" directory because of that blank character in the directory name. You may change the installed directories for JDK and JRE during installation. I personally installed JDK and all my programming tools in "d:\bin" (instead of "C:\Program Files") for ease of maintenance.
- It is always cleaner to un-install all the out-dated JDK/JRE before installing a new version.

## Step 3 Configuring the installation

In this Section we will add some settings to the windows environment so that the java compiler and runtime becomes available for compiling and running the java application.
### Setup JAVA_HOME
The JAVA_HOME will be your installation directory. In my case, C:\Program Files\Java\jdk1.6.0_14.
Either you can set up this as Windows environment, in which case you never need to worry about setting up of the JAVA_HOME, but makes it little difficult to use any other JDK version. Or, you can create a batch file for that particular project, to have unique environments for that project alone.

Right clicking "My Computer" icon generally available on your Desktop or Windows Start -> My Computer -> View System Information
Set up Java Home Properties -> Advanced -> Environment Variables -> System variables -> New
 
	Variable Name: JAVA_HOME
	Variable Value: C:\Program Files\Java\jdk1.6.0_14
 
Note: The variable value is your JDK installation directory name. The above is as on my system.

### Setup Path

- Right clicking "My Computer" icon generally available on your Desktop or Windows Start -> My Computer -> View System Information
Set up Java Home Properties -> Advanced -> Environment Variables -> System variables
- In "System Variables" box, scroll down to select "PATH" ⇒ "Edit..."
- In "Variable value" field, INSERT "%JAVA_HOME%\bin" (assume that this is your JDK's binary directory) IN FRONT of all the existing directories, followed by a semi-colon (;) which separates the JDK's binary directory from the rest of the existing directories. DO NOT DELETE any existing entries; otherwise, some existing applications may not run.
 
	Variable name  : PATH
	Variable value : %JAVA_HOME%\bin;....exiting entries....
 
## STEP 4 Verify the JDK Installation

Launch a CMD shell (click the "Start" button ⇒ run... ⇒ enter "cmd"), and Issue a "path" command to list the content of the PATH environment variable. Check the output and make sure that <JAVA_HOME>\bin is listed in the PATH.
 
	prompt> path
	PATH=c:\Program Files\java\jdk1.7.0\bin;......other entries......
 
Issue the following commands to verify that JDK is properly installed and display its version:
 
	prompt> java -version
	java version "1.7.0"
	Java(TM) SE Runtime Environment (build 1.7.0-b147)
	Java HotSpot(TM) Client VM (build 21.0-b17, mixed mode, sharing)
	prompt> javac
	Usage: javac <options> <source files>
	.........
	.........
 
## STEP 5 Download JDK API Documentation

The JDK download does not include the documentation, which needs to be downloaded separately.You should have a local copy of JDK API Documentation.

- To install JDK API documentation
- From the Java SE download page (http://www.oracle.com/technetwork/java/javase/downloads/index.html), look for "Java SE 6 Documentation" (under "Additional Resources") ⇒ Download the zip-file (e.g., "jdk-6....zip").
- Unzip into the <JAVA_HOME> (JDK installed directory). The documentation will be unzipped into "<$JAVA_HOME>\docs".
Browse the JDK documentation by opening "<JAVA_HOME>\docs\index.html".
