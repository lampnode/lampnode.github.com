---
layout: post
title: "SVN:propset ignore examples"
tagline: "SVN:propset ignore examples"
description: ""
category: Linux 
tags: [ Subversion ]
---
{% include JB/setup %}

This document is show to get svn to ignore some files and directories.

## svn:ignore

### To setup svn:ignore to a directory

With -F, you can specify a file that contains a list of file name patterns to ignore. For example, 

	$vim .svnignore

Add the following line to this file:

	*.html

Saved this file as .svnignore, and then enter the following commands:

	$svn propset svn:ignore -F ./.svnignore .
	$svn up
	$svn commit -m "Add ignore prop to the current dir"

### To setup svn:ignore to directories with recursively

        $vim .svnignore

Add the following lines to this file(Each ignore setup in own line):

	.svnignore
	*.pyc
	*.cash
	test.php

Enter the following commands

	$svn propset svn:ignore -F /usr/local/www/html/html/svnignore -R .
	$svn up
	$svn commit -m "Add ignore prop to dirs"

## svn prop setup

### svn proplist

List all properties (including svn:ignore) set for the current directory. You can optionally specify a path, or use -v (--verbose) will list all the file patterns being ignored.

	svn proplist -v
	
Output:

	Properties on '.':
	  svn:ignore
	    *.html
	
### svn propdel

Remove all your svn:ignore settings for the current directory. You can optionally specify a path, or use -R (--recursive) to delete the property recursively.

	svn propdel svn:ignore [PATH]


	
