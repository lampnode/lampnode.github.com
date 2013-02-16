---
layout: page
title: "Github使用手册"
description: "Github guideline"
---
{% include JB/setup %}

## About Github

[GitHub](https://github.com) GitHub是共享代码一个的好地方.GitHub可以托管各种git库，并提供一个web界面，但与其它像 SourceForge或Google Code这样的服务不同，GitHub的独特卖点在于从另外一个项目进行分支的简易性。为一个项目贡献代码非常简单：首先点击项目站点的“fork”的按钮，然后将代码检出并将修改加入到刚才分出的代码库中，最后通过内建的“pull request”机制向项目负责人申请代码合并。已经有人将GitHub称为代码玩家的MySpace。

### About Git
Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理.Git 是 Linus Torvalds 为了帮助管理 Linux 内核开发而开发的一个开放源码的版本控制软件。

## 简单使用指南 Simple Guide For github

### 迁出 Checkout an existed repository

这里有两种常用的方法迁出代码,一种是https

	https://github.com/username/project.name.git	

一种是ssh,
	
	$git clone USERNAME@github.com:/path/to/repository

推荐使用ssh, 配合SSH-KEY,安全简单

### 添加 Add and commit
	
	$git add <filename> # or git add .
	$git commit -m "Commit message"

Note:The file(s) have been committed to the HEAD, but not in your remote repository yet.

### 与服务器同步 Pushing changes

代码提交后, 只能说明是本地的代码已经修改，如果将代码的修改同步到服务器，需要执行以下命令:
 
	$git push origin master

### 更新服务器端代码到本地 Update the workspace

In order to update your local repository to the newest commit, you should execute the following command in your working directory to fetch and merge remote changes.

	$git pull


### 忽略配置 git ignore

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


### 技巧 Hints

#### Use colorful git output

	$git config color.ui true

#### Use interactive adding

	$git add -i

## 资源 Links and Resources

- Graphical clients: [GitX](http://gitx.laullon.com), [GitHub for Mac](http://mac.github.com/)

- Guides: [GitHub help](https://help.github.com)
