---
layout: post
title: "Install Github and jekyll on Ubuntu"
tagline: "Install Github and jekyll on Ubuntu"
description: "Install github and jekyll on Ubuntu 12.04 or later"
category: Github
tags: [ Ubuntu ]
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
    $sudo gem install jekyll-paginate
    
If you are configuring this step on the Ubuntu Server Edition, the system will report an error like:

	ERROR: Failed to build gem native extension

You should install build-essential to fix this problem:

	$sudo apt-get install build-essential -y

### Install Rake

	$sudo gem install rake

### Install JavaScript Runtime(For Ubuntu 14.04 or later)

	$sudo apt-get install nodejs	

if you don't install nodejs, when you boot jekyll server, the system will report the following errror information:

	/var/lib/gems/1.9.1/gems/execjs-2.0.2/lib/execjs/runtimes.rb:51:in `autodetect': 
	Could not find a JavaScript runtime. See.....

### setup Global config

	$git config --global user.name lampnode
  	$git config --global user.email robert.qian@lampnode.com	
	$git config --global color.ui true

### Checkout the repository from github

	$mkdir USERNAME.github.com
	$cd USERNAME.github.com
	$git clone git@github.com:USERNAME/path/to/repository .

By Https

	$git clone https://github.com/lampnode/lampnode.github.com.git .

by SSH(Need login):
	
	$git clone git@github.com:lampnode/lampnode.github.com.git .

## Basic Usages

### Start Jekyll server

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

### For git

#### Update to local

	$git pull
	
#### Commit changes to GitHub

	$git add .
	$git commit -m "Add some content"
	$git push origin master
	
## gem usage

The gem command allows you to interact with RubyGems.

### gem update self 

    gem update --system

### gems managment

#### Finding Gems

The search command lets you find remote gems by name. You can use regular expression characters in your query:

    $ gem search ^rails

    *** REMOTE GEMS ***

    rails (4.0.0)
    rails-3-settings (0.1.1)
    rails-action-args (0.1.1)
    rails-admin (0.0.0)
    rails-ajax (0.2.0.20130731)
    [...]

#### Installing Gems

The install command downloads and installs the gem and any necessary dependencies then builds documentation for the installed gems.

    $ gem install drip
    Fetching: rbtree-0.4.1.gem (100%)
    Building native extensions.  This could take a while...
    Successfully installed rbtree-0.4.1
    Fetching: drip-0.0.2.gem (100%)
    Successfully installed drip-0.0.2
    Parsing documentation for rbtree-0.4.1
    Installing ri documentation for rbtree-0.4.1
    Parsing documentation for drip-0.0.2
    Installing ri documentation for drip-0.0.2
    Done installing documentation for rbtree, drip after 0 seconds
    2 gems installed

You can disable documentation generation using the --no-doc argument when installing gems.

#### Listing Installed Gems

The list command shows your locally installed gems

    $ gem list

    *** LOCAL GEMS ***

    bigdecimal (1.2.0)
    drip (0.0.2)
    io-console (0.4.2)
    json (1.7.7)
    minitest (4.3.2)
    psych (2.0.0)
    rake (0.9.6)
    rbtree (0.4.1)
    rdoc (4.0.0)
    test-unit (2.0.0.0)

#### Uninstalling Gems

The uninstall command removes the gems you have installed.

    $ gem uninstall drip
    Successfully uninstalled drip-0.0.2

#### Updating Gems

    $gem update jekyll
