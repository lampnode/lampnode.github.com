---
layout: page
title: "Jekyll使用指南"
description: "Jekyll的使用指南"
---
{% include JB/setup %}


## Overview 

### What is Jekyll?

jekyll是一个简单的免费的Blog生成工具，jekyll通过生成静态网页的来组织内容，不需要数据库支持。它可以配合第三方服务,例如disqus(http://www.disqus.com)。最关键的是jekyll可以免费部署在Github上，而且可以绑定自己的域名。


##Pygments配置代码高亮

### 修改_config.yml

设置pygments: true

### 选择一种喜欢的代码高亮样式

Pygments提供了多种样式，比如’native’, ‘emacs’, ‘vs’等等，可以在Pygments Demo中选择某种语言的例子，体验不同的样式。

通过下面的命令可以查看当前支持的样式：
{% highlight bash %}
	>>> from pygments.styles import STYLE_MAP
	>>> STYLE_MAP.keys()
	['monokai', 'manni', 'rrt', 'perldoc', 'borland', 'colorful', 'default', 'murphy', 'vs', 'trac', 'tango', 'fruity', 'autumn', 'bw', 'emacs', 'vim', 'pastie', 'friendly', 'native']
{% endhighlight %}

### 选择一种样式，应用在Jekyll中

	cd /dev/projects/zyzhang.github.com/assets/themes/abel/css
	pygmentize -S native -f html > pygments.css, “native”是样式名，“html”是formatter

在layout中引用刚刚加的pygments.css

### 使用方法

在代码前添加:
	
	{ % highlight java % }
		
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
