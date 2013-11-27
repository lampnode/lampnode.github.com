---
layout: post
title: "在linux命令行下禁止无动作自动关闭显示器"
tagline: "Prohibited without action is automatically closed monitor on the Linux command line"
description: ""
category: Linux
tags: [Linux]
---
{% include JB/setup %}

LINUX 默认都是大概十分钟左右就自动把显示器给黑了.
执行下面的命令就可以解决这个问题。

	setterm -blank 0
