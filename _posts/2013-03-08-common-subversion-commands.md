---
layout: post
title: "常用的subversion命令"
tagline: "Common subversion commands"
description: ""
category: Linux
tags: [ SVN ]
---
{% include JB/setup %}

## How To Add all new files and folders to subversion

### Method A:
 
	svn add * --force
 
### Method B:
 
	svn status | grep "^?" | awk '{print $2}' | xargs svn add
