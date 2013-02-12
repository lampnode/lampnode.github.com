---
layout: post
title: "Using Rsync with SSH to backup data"
description: ""
category: Linux 
tags: [CentOs]
---
{% include JB/setup %}

This document covers using cron, ssh, and rsync to backup data.You will need these packages installed:

- rsync
- openssh
- cron

## commands

### Without delete flag
 
	edwin@easydocs:~$ rsync -avz -e ssh remoteuser@remotehost:/remote/dir /local/dir/ 
 
### With delete flag
By default, rsync will only copy files and directories, but not remove them from the destination copy when they are removed from the source. To keep the copies exact, include the --delete flag:
 
	edwin@easydocs:~$ rsync -ave ssh  --delete remoteuser@remotehost:/remote/dir /local/dir/ 
