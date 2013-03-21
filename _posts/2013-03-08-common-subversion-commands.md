---
layout: post
title: "常用的subversion命令"
tagline: "Common subversion commands"
description: ""
category: Linux
tags: [ Subversion, Linux ]
---
{% include JB/setup %}


## How To Add all new files and folders to subversion

### Method A:
 
	$svn add * --force
 
### Method B:
 
	$svn status | grep "^?" | awk '{print $2}' | xargs svn add

## Remove all svn managing folders in a directory tree
	
	$find . -name ".svn" -type d -exec rm -rf {} \;

## how the current working copy info

	$ svn info

## To show the list of files/directories added/modified locally

	$ svn status

Some GREP options (Works in Linux)

	$ svn status|grep M
	$ svn status|grep ?

## Update the working copy
	
	$ svn up

## To compare local copy with the repository copy

	$ svn diff


## To compare revisions of file

	$ svn diff -r<revision_old>:<revision_new> <file_name>

## Commit changes of individual file/files/directories

	$ svn commit -m “commit message”

To commit all local changes of working copy:
	
	$ svn commit -m

Above command will open up with the default editor bind with svn with the list of files. You can give your message here.

## Rollback the local file changes
	
	$ svn revert

To revert all the local changes in the current working copy
	
	$ svn revert –recursive .


