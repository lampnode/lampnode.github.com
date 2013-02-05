---
layout: page
title: "Github"
description: "Github guideline"
group: navigation
---
{% include JB/setup %}

## About Github

[GitHub](https://github.com) is the best place to share code with friends, co-workers, classmates, and complete strangers. Over three million people use GitHub to build amazing things together.

### About Git
In software development, Git is a distributed revision control and source code management (SCM) system with an emphasis on speed.Git was initially designed and developed by Linus Torvalds for Linux kernel development; it has since been adopted by many other projects. Every Git working directory is a full-fledged repository with complete history and full revision tracking capabilities, not dependent on network access or a central server.

## Simple Guide For github

### Checkout an existed repository
	$git clone USERNAME@github.com:/path/to/repository

### Add and commit
	$git add <filename> # or git add .
	$git commit -m "Commit message"

Note:The file(s) have been committed to the HEAD, but not in your remote repository yet.

### Pushing changes
After commited, your changes are now in the HEAD of your local working copy. To send those changes to your remote repository, execute the following command:
 
	$git push origin master

### Update the workspace
In order to update your local repository to the newest commit, you should execute the following command in your working directory to fetch and merge remote changes.
	$git pull

### Hints

Use colorful git output

	$git config color.ui true

Use interactive adding

	$git add -i

## Links and Resources

- Graphical clients: [GitX](http://gitx.laullon.com), [GitHub for Mac](http://mac.github.com/)

- Guides: [GitHub help](https://help.github.com)
