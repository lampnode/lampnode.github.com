---
layout: page
title: "Jekyll使用指南"
description: "Jekyll的使用指南"
---
{% include JB/setup %}


## Overview 

### What is Jekyll?

jekyll是一个简单的免费的Blog生成工具，jekyll通过生成静态网页的来组织内容，不需要数据库支持。它可以配合第三方服务,例如disqus(http://www.disqus.com)。最关键的是jekyll可以免费部署在Github上，而且可以绑定自己的域名。

## Install jekyll and git

[Install Github and jekyll on Ubuntu](/github/install-github-and-jekyll-on-ubuntu.html)

## Clone blog from github by ssh

	$mkdir lampnode.github.com
	$cd lampnode.github.com
	$git clone git@github.com:lampnode/lampnode.github.com.git .

## 启用jekyll server

在Workspace的根目录下，输入如下命令:

	$jekyll --server

OR
	$jekyll server -w

可以访问http://localhost:4000 查看内容

## Git 基本用途


### 提交编辑内容

在Workspace的根目录下,执行如下命令

	$ git add *
	$ git status
 	$ git commit -m "new posts"
	$ git push origin master

### 更新本地内容到最新

	$git pull

## 编写日志用法

### 创建新的日志

在Workspace的根目录下,执行如下命令

        $rake post title="Zend Server CE setup error on windows"

### Pygments配置代码高亮

#### 修改_config.yml

设置pygments: true

#### 选择一种喜欢的代码高亮样式

Pygments提供了多种样式，比如’native’, ‘emacs’, ‘vs’等等，可以在Pygments Demo中选择某种语言的例子，体验不同的样式。

通过下面的命令可以查看当前支持的样式：
{% highlight bash %}
	>>> from pygments.styles import STYLE_MAP
	>>> STYLE_MAP.keys()
	['monokai', 'manni', 'rrt', 'perldoc', 'borland', 'colorful', 'default', 'murphy', 'vs', 'trac', 'tango', 'fruity', 'autumn', 'bw', 'emacs', 'vim', 'pastie', 'friendly', 'native']
{% endhighlight %}

#### 选择一种样式，应用在Jekyll中

	cd /dev/projects/zyzhang.github.com/assets/themes/abel/css
	pygmentize -S native -f html > pygments.css, “native”是样式名，“html”是formatter

在layout中引用刚刚加的pygments.css

#### 使用方法

在代码前添加:

	
	{ % highlight java % }
	
	 ...... Some code here ......	
		
	{ % endhighlight % }



** 注意: ** 大括号与百分号之间没有空格

例如:

{% highlight java %}

	public class ClassAdapter extends ClassVisitor implements Opcodes{
		public static final String INIT = "<init>";
		private ClassWriter classWriter;
		private String originalClassName;
		private String enhancedClassName;
		private Class<?> originalClass;

		public ClassAdapter(String enhancedClassName,
			Class<?> targetClass, ClassWriter writer) {
			super(Opcodes.ASM4,writer);
			this.classWriter = writer;
			this.originalClassName = targetClass.getName();
			this.enhancedClassName = enhancedClassName;
			this.originalClass = targetClass;
		}
	}

{% endhighlight %}

 This is the local network exmaple:

{% highlight bash %}

Local Network Example:

			Internet
                 |         
                 |         
                 |         
            _____|_____    
            |          |   
            |  Route   |
            |__________|  IP: 192.168.0.1
                 |
                 |             
            _____|_________  
           |               |
           |  Hub  		   |
           |_______________|
              |    |   |
              |    |   |
              |    |   |_________________________
              |    |                             |
           ___|    |________                     |
           |                |                    |
           |                |                    |
   ________|_______    _____|___________     ____|___________
   |               |   |                |    |               |
   | PC1           |   |  PC2           |    | PC3           |
   | nas.          |   |  user1.        |    | srv.      	 |
   | example.com   |   |  example.com   |    | example.com   |
   |               |   |                |    |               |
   |  192.168.0.3  |   |  192.168.0.5X  |    | 192.168.1.253 |
   |_______________|   |________________|    |_______________|

{% endhighlight %}

