---
layout: post
title: "如何在Eclipse里为java项目设置classpath"
tagline: "How to setup classpath for java project on Eclipse"
description: ""
category: Linux
tags: [ JAVA , Eclipse ]
---
{% include JB/setup %}

## Example

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
        <!-- default setup -->
	<classpathentry kind="src" path="src"/>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.6"/>
	<classpathentry kind="output" path="bin"/>
	<classpathentry kind="var" path="MAVEN_REPO/jetspeed/jars/jetspeed-1.4.jar"/>
 
         <!-- add the external jar to current project -->
        <classpathentry kind="lib" path="lib/jsch-0.1.44.jar"/>
         <!-- filter rules -->
        <classpathentry excluding="**/.svn/**" kind="src" path="src"/>  
</classpath>
{% endhighlight %}
 
## Note:

- src是源文件输出目的的
- output是类文件输出目的的,
- con是eclipse运行时所需的核心包
- var是通过环境变量的形式增加的一些JAR包
- lib是直接加入的JAR包
- excluding指对源文件目录src执行忽略规则（或略svn的控制目录）

所以需要加入一些第三方的JAR文件时,直接编辑此文件即可,eclipse不需重启,工程即可生效.
