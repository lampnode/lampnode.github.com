---
layout: post
title: "SVN:add command examples"
tagline: "SVN:add command examples"
description: ""
category: Linux
tags: [ Subversion ]
---
{% include JB/setup %}

### Add a file/directory only

	svn add foo.txt

Add directory

	svn add fooDir

Or

	svn add fooDir/a

### Add files/directories 

	svn add *

Add items recursively

	svn add * --force

### Add a directory only without recursively

	svn add fooDir -N

Or

	svn add fooDir/a -N

### Add directories resursively without any files

	find . -type d ! -wholename  '*.svn*' -exec svn add -N {} \;

