---
layout: post
title: "使用fdisk进行Linux分区任务"
tagline: "Linux partitioning with fdisk"
description: ""
category: Linux 
tags: [Linux]
---
{% include JB/setup %}

##  Viewing existing partitions

	[root@foo ~]# fdisk -l

	Disk /dev/sda: 500.1 GB, 500107862016 bytes
	255 heads, 63 sectors/track, 60801 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	Sector size (logical/physical): 512 bytes / 4096 bytes
	I/O size (minimum/optimal): 4096 bytes / 4096 bytes
	Disk identifier: 0x0ae3b10c

   	Device Boot      Start         End      Blocks   Id  System
	/dev/sda1               1       30396   244149968+  83  Linux
	/dev/sda2           30396       60802   244236580   83  Linux

	
	Disk /dev/sdb: 500.1 GB, 500107862016 bytes
        255 heads, 63 sectors/track, 60801 cylinders
        Units = cylinders of 16065 * 512 = 8225280 bytes
        Sector size (logical/physical): 512 bytes / 4096 bytes
        I/O size (minimum/optimal): 4096 bytes / 4096 bytes
	Disk identifier: 0X8040000

We can see that there is a new /dev/sdb hard disk the size of 500GB without any partitions on it. In order to use the disk and create a filesystem we need to create a  partition on it.

## Creating a new partition with fdisk

	[root@foo ~]# fdisk -u /dev/sdb

	Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
	Building a new DOS disklabel with disk identifier 0x7973a9ad.
	Changes will remain in memory only, until you decide to write them.
	After that, of course, the previous content won’t be recoverable.
 
	Warning: invalid flag 0×0000 of partition table 4 will be corrected by w(rite)
 
	WARNING: DOS-compatible mode is deprecated. It’s strongly recommended to
	switch off the mode (command ‘c’) and change display units to
	sectors (command ‘u’).
 
	Command (m for help):	

### Create a new partition
	
	Command (m for help): n
	Command action
	e   extended
	p   primary partition (1-4) [Enter p]
	Partition number (1-4): 1 [Enter 1]
	First cylinder (1-130, default 1): [Enter 1]
	Using default value 1
	Last cylinder, +cylinders or +size{K,M,G} (1-130, default 130): [Enter +500M]

Partition number is the /dev/sdbX number. Since this is the first partition on this hard drive, the partition number is 1 (/dev/sdb1)

We have entered “+500M” so our partition will be 500MB large (mind the “+” in front of the partition size!!). You can also enter the size in Kilobytes (K) and Gigabytes (G).

No changes have yet been done to the disk and partitions until we write changes out. We can see what we did with the "p" key:

	Command (m for help): p
 	....
	Device Boot      Start         End      Blocks   Id  System
	/dev/sdb1               1          65      522081   83  Linux

### Save it

We are now satisfied with the partitioning of the /dev/sdb hard drive and can write changes out by entering "w". DO NOT FORGET to write changes out. If you hit “"q" to quit, all changes are lost!	

	Command (m for help): w
	The partition table has been altered!
 
	Calling ioctl() to re-read partition table.
	Syncing disks.

## Format the new partition

	mkfs.ext4 /dev/sdb1

