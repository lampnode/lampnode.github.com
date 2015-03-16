---
layout: post
title: "Use extundelete to recover deleted files in Linux"
tagline: "Use extundelete to recover deleted files in Linux"
description: ""
category: Linux
tags: [ Ubuntu, Linux ]
---
{% include JB/setup %}

The extundelete is a utility that can recover deleted files from an ext3 or ext4 partition. 

## install Package

	sudo apt-get install extundelete

## Usage

### Read help information

	$ extundelete --help
	
### To restore all deleted files from a partition 

	$ extundelete /dev/sda4 --restore-all
	
### To restore special file

Check the deleted file inode: 

	$ extundetele --inode 2 /dev/vda1
	
Then, restore the file that inode Id is 1234:

	$ extundetele --restore-inode 1234 /dev/vda1
	
The deleted file has been saved to RECOVERED_FILES on current path.
	

