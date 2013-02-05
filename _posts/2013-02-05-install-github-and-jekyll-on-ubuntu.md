---
layout: post
title: "Install Github and jekyll on Ubuntu"
description: "Install github and jekyll on Ubuntu 12.04 or later"
category: Github
tags: [Ubuntu]
---
{% include JB/setup %}

Jekyll is a Git compatible static site generator that can be installed on Ubuntu.

## Installation

### Install Dependencies
	$sudo apt-get install git ruby rubygems python-pygments
	$sudo gem install rdiscount

### Install Jekyll
In order to preview your blog locally you will  need to install the Jekyll ruby gem.
	$sudo gem install jekyll

### Install rake
	$sudo gem install rake

## Usages

### Start Jekyll
	$cd USERNAME.github.com
	$jekyll --server

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
	
