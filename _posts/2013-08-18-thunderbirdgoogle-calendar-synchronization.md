---
layout: post
title: "Google Calendar与Thunderbird同步"
tagline: "Thunderbird:Google Calendar synchronization"
description: ""
category: software 
tags: [Thunderbird]
---
{% include JB/setup %}

Google Calendar拥有非常强大的日程管理功能，可以使用Lightning等插件, 把它引入ThunderBird

## 安装方法

### 安装插件

* Provider for Google Calender
* Lighting

安装之后，将Thunderbird重启使之生效，将在Thunderbird界面右边产生的侧边栏

### 配置Google calender

进入你的Google Calendar帐户，在主界面的右上角点击"设置",在设置页面选择日历标签，进入其中的某一日历  
点击XML按钮并复制XML标示的链接.

### 配置Lightning

选择位于网络上选项，点击下一步；在接下来的日历格式中选择Google Calendar。

好了，在位置项目中粘贴刚才复制的XML的地址链接。再在下一步中起名，标上色彩。最后，让软件保存你Google Calendar帐户的登录口令，校验之后就可以自动登录了.

