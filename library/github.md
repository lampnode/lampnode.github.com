---
layout: page
title: "Github使用手册"
description: "Github guideline"
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


### git ignore

由于用jekyll本地测试时会生成_site文件夹，所以需要把这个文件夹排除在外再提交到github, 这就需要用到.gitignore，即不加入版本控制，在git根目录下建立.gitignore，具体设定如下：

	tmp.txt         //忽略tmp.txt 
	*.log           //忽略所有log文件 
	tmp/*           //忽略tmp文件夹所有文件 
	log/**/*.log    //忽略log目录下的包括子目录下的所有log文件 

其他的一些过滤条件

	？：代表任意的一个字符
	＊：代表任意数目的字符
	{!ab}：必须不是此类型
	{ab,bb,cx}：代表ab,bb,cx中任一类型即可
	[abc]：代表a,b,c中任一字符即可
	[ ^abc]：代表必须不是a,b,c中任一字符

由于git不会加入空目录，所以下面做法会导致tmp不会存在

	tmp/*             //忽略tmp文件夹所有文件 

改下方法，在tmp下也加一个.gitignore,内容为

	* !.gitignore 

还有一种情况，就是已经commit了，再加入gitignore是无效的，所以需要删除下缓存

	git rm --cached ignore_file 


### Hints

Use colorful git output

	$git config color.ui true

Use interactive adding

	$git add -i

## Links and Resources

- Graphical clients: [GitX](http://gitx.laullon.com), [GitHub for Mac](http://mac.github.com/)

- Guides: [GitHub help](https://help.github.com)
