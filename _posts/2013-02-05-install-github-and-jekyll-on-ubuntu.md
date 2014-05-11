---
layout: post
title: "在Ubuntu上安装Github和Jekyll"
tagline: "Install Github and jekyll on Ubuntu"
description: "Install github and jekyll on Ubuntu 12.04 or later"
category: Github
tags: [Ubuntu]
---
{% include JB/setup %}

Jekyll is a Git compatible static site generator that can be installed on Ubuntu.

## Installation

### Install Dependencies

	$sudo apt-get install git ruby ruby-dev python-pygments
	$sudo gem install rdiscount

### Install Jekyll
In order to preview your blog locally you will  need to install the Jekyll ruby gem.

	$sudo gem install jekyll

### Install Rake

	$sudo gem install rake

### Install JavaScript Runtime(For Ubuntu 14.04 or later)

	$sudo apt-get install nodejs	

if you don't install nodejs, when you boot jekyll server, the system will report the following errror information:

	/var/lib/gems/1.9.1/gems/execjs-2.0.2/lib/execjs/runtimes.rb:51:in `autodetect': 
	Could not find a JavaScript runtime. See.....

### setup Global config

	$git config --global user.name lampnode
  	$git config --global user.email robert@example.com	

## Usages

### Start Jekyll

	$cd USERNAME.github.com
	$jekyll --server

or

	$jekyll server -w

Your can access this by http://loclaohost:4000

### For Rake

#### Create a new page
	$rake page name="about.md"


#### Create a new post 

Begin a new post
	
	$rake post title="Your post title"

The rake task automatically creates a file with properly formatted filename and YAML Front Matter. Make sure to specify your own title. By default, the date is the current date.

	
## Commit to GitHub
	$git add .
	$git commit -m "Add some content"
	$git push origin master
	
