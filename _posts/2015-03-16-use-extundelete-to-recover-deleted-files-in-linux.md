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
	
Sample output:

    File name                   | Inode number | Delete Status
    lost+found                      2
    exampleFile.txt                 1234            Deleted
    httpd.conf.bak                  2135            Deleted
	
Then, restore the file that inode Id is 1234:

	$ extundetele --restore-inode 1234 /dev/vda1
	
Sample output:

    WARNING: Extended attributes are not restored.
    Loading filesystem metadata ... 8 groups loaded.
    Loading journal descriptors ... 21 descriptors loaded.
    Writing output to directory RECOVERED_FILES/
    Restored inode 13 to file RECOVERED_FILES/file.1234
    
    $ls RECOVERED_FILES/
    file.1234
	
The deleted file has been saved to RECOVERED_FILES on current path.
	

