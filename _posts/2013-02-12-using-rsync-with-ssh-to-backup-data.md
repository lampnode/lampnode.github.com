---
layout: post
title: "Using Rsync with SSH to backup data"
tagline: "Using Rsync with SSH to backup data"
description: ""
category: Linux 
tags: [ Linux, rsync]
---
{% include JB/setup %}

The purpose of this ducument is guide you to setup cron job with rsync to bakcup data.



## System requirement

### Hosts

- Data-Server [192.168.0.3]
- Backup-Server[192.168.0.7]



### Related packages:

- rsync
- openssh
- cron

## Rsync Usage Examples

### Backup without delete flag
 
	$ rsync -avz -e ssh remoteuser@remotehost:/remote/dir /local/dir/ 
 
### Backup with delete flag

By default, rsync will only copy files and directories, but not remove them from the destination copy when they are removed from the source. To keep the copies exact, include the --delete flag:
 
	$ rsync -avz ssh  --delete remoteuser@remotehost:/remote/dir /local/dir/

## Backup with secret key

### Creating the ssh key

The following steps will be complated on the backup server [192.168.0.7].

	$ ssh-keygen -t dsa -b 1024 -f rsync.key
	
Sample outputs:

	Generating public/private dsa key pair
	Enter passphrase (empty for no passphrase): [Enter without any input]
	Enter same passphrase again: [Enter without any input]
	Your identification has been saved in yenjinc.info-key. 
	Your public key has been saved in yenjinc.info-key.pub. 
	The key fingerprint is: 
	41:29:60:49:40:c3:a0:8f:2f:74:4e:40:64:a5:42:db edwin@client.local 

### Server configration

#### Configuring sshd

Update the following params in the sshd configuration file.

- "PubkeyAuthentication" should be set to "yes".
- "PermitRootLogin" should be set to either "without-password", or "forced-commands-only".

Then, reload the sshd

	$sudo /etc/init.d/sshd restart

#### Add the public key to server-side host

You should finished the following steps on the backup server.
  
	$ scp rsync.key.pub robert@192.168.0.3:~/.ssh/
	$ ssh root@192.168.0.3
	# cd .ssh
	# cat rsync.key.put >>  authorized_keys
	# chmod 600 authorized_keys

#### Test this key     

	$ ssh -i rsync.key root@192.168.0.3

or 

	$ ssh -p10001 -i rsync.key root@192.168.0.3 "ls -al"

### Test backup 

	$ rsync -avz -e "ssh -i rsync.key" root@192.168.0.3:~/backup/ /backup/ 

## Backup Data with cron

### Edit the script

The script file is  "/home/edwin/crontabScript/rsync.sh", the following content is:

#### Without Exclude Files

{% highlight bash %}
#!/bin/bash
RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
KEY=/your/path/to/rsync.key
USER=edwin
HOST=192.168.0.22
SSH_PORT=22
REMOTE_DIR=/your/path/to/remote_dir
LOCAL_DIR=/your/path/to/local_dir

# rsync+ssh+crontab command
$RSYNC -avz -e "$SSH -i $KEY -p $SSH_PORT" $USER@$HOST:$REMOTE_DIR $LOCAL_DIR
{% endhighlight %}


#### With Exclude Files	

{% highlight bash %}
#!/bin/bash 
RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
KEY=/your/path/to/rsync.key
EXCLUDE_FILE=/your/path/to/exclude.txt
USER=edwin
HOST=192.168.0.22
SSH_PORT=22
REMOTE_DIR=/your/path/to/remote_dir
LOCAL_DIR=/your/path/to/local_dir

# rsync+ssh+crontab command 
$RSYNC -avz -e "$SSH -i $KEY -p $SSH_PORT" --exclude-from "$EXCLUDE_FILE"  $USER@$HOST:$REMOTE_DIR $LOCAL_DIR 
{% endhighlight %}

The content of exclude file:

{% highlight bash %}

sources
public_html/database.*
downloads/test/*

{% endhighlight %}

### Setup crontab

	$crontab -e
	20 1 * * * /home/edwin/crontabScript/rsync.sh


Related articles: 

* [ How to Setup Rsync on Linux ](/Linux/how-to-setup-rsync-on-linux/index.html)
 
