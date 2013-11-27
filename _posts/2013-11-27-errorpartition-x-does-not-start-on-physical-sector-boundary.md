---
layout: post
title: "错误:Partition X does not start on physical sector boundary"
tagline: "Error:Partition X does not start on physical sector boundary"
description: ""
category: Linux
tags: [Linux]
---
{% include JB/setup %}

## 问题

在使用fdisk对硬盘进行分区的时候:
	
	fdisk /dev/sda

是以cylinder为单位的分区边界，而以cylinder为粒度的分区造成了标题中的问题，

	$fdisk -l

	Disk /dev/sda: 160.0 GB, 160041885696 bytes
	255 heads, 63 sectors/track, 19457 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk identifier: 0x0007ab29

   	Device Boot      Start         End      Blocks   Id  System
	/dev/sda1   *           1          64      512000   83  Linux
	Partition 1 does not end on cylinder boundary.
	/dev/sda2              64        2614    20480000   83  Linux
	Partition 2 does not end on cylinder boundary.
	/dev/sda3            2614        2869     2048000   82  Linux swap / Solaris
	Partition 3 does not end on cylinder boundary.
	/dev/sda4            2869       19458   133248000   83  Linux


## 解决办法
使用参数"-u",可以去掉"Partition X does not start on physical sector boundary"错误。例如：

	fdisk -u /dev/sdb，

改用sectors为粒度工作，就可以解决这个问题。

	Disk /dev/sdb: 500.1 GB, 500107862016 bytes
	255 heads, 63 sectors/track, 60801 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	Sector size (logical/physical): 512 bytes / 4096 bytes
	I/O size (minimum/optimal): 4096 bytes / 4096 bytes
	Disk identifier: 0x0ae3b10c

   	Device Boot      Start         End      Blocks   Id  System
	/dev/sdb1               1       30396   244149968+  83  Linux
	/dev/sdb2           30396       60802   244236580   83  Linux

