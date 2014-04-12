---
layout: post
title: "Howto add desktop entry on Ubuntu 13.10"
tagline: "Howto add desktop entry on Ubuntu 13.10"
description: ""
category: Linux
tags: [Linux, Ubuntu]
---
{% include JB/setup %}

If you need add the application icon on the desktop when you do not using the apt-get to install softwares, let us to perform the following operations. This document describes how to add customized desktop entry on Ubuntu 12.10.

### For Eclipse

	#vim /usr/share/applications/eclipse.desktop

Add the following to this file.

	[Desktop Entry]
	Type=Application
	Name=Eclipse
	Comment=Eclipse Integrated Development Environment
	Icon=/opt/eclipse/icon.xpm
	#Exec=/opt/eclipse/eclipse
	Exec=env UBUNTU_MENUPROXY=0 /opt/eclipse/eclipse
	Terminal=false
	Categories=Development;IDE;Java;


### For Zend Stdio

	
	#vim /usr/share/applications/zend.desktop	


	[Desktop Entry]
	Type=Application
	Name=Zend
	Comment=PHP  Development Environment
	Icon=/opt/ZendStudio/icon.xpm
	#Exec=/opt/ZendStudio/ZendStudio
	Exec=env UBUNTU_MENUPROXY=0 /opt/ZendStudio/ZendStudio
	Terminal=false
	Categories=Development;IDE;Java;

	
