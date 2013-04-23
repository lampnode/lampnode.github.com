---
layout: page
title: "Linux命令"
description: "Linux常用命令集锦"
group: navigation
---
{% include JB/setup %}

本文档的目的是快速查询常用命令的使用方法。这里列举的命令以及使用方法不会包含一个基本使用方法与解释。

## 命令基础

Linux提供了几百条命令，虽然这些命令的功能不同，但它们的使用方式和规则都是统一的。Linux命令的一般格式是： 

	命令名 [ 选项] [参数 1] [参数 2]... ...

### 特点

- 命令名由小写的英文字母构成，往往是表示相应功能的英文单词或单词的缩写。例如，date表示日期； who表示谁在系统中；cp是copy的缩写，表示拷贝文件等。
- 选项是对命令的特别定义，以"-"开始， 多个选项可用一个"-" 连起来，如"ls -l -a"与"ls -la"相同。
- 命令行的参数提供命令运行的信息，或者是命令执行过程中所使用的文件名。通常参数是一些文件名，告诉命令从哪里可以得到输入 ，以及把输出送到什么地方。
- 如果命令行中没有提供参数，命令将从标准输入文件（即键盘）接受数据，输出结果显示在标准输出文件（即显示器）上，而错误信息则显示在标准错误输出文件（即显示器）上。可使用重定向功能对这些文件进行重定向。
- 命令在正常执行后返回一个0值，表示执行成功；如果命令执行过程中出错，没有完成全部工作，则返回一个非零值 (在Shell中可用变量$?查看)。在Shell脚本中，可用命令返回值作为控制逻辑的一部分。
- Linux操作系统的联机帮助对每个命令的准确语法都做了说明，可以使用命令man来获取相应命令的联机说明，如" man ls"。

### 分类
#### 用户管理

- [useradd](/commands/useradd.html) 添加一个用户到系统中

#### 网络管理

- [netstat](/commands/netstat.html) 命令用于显示各种网络相关信息
- [nslookup](/commands/nslookup.html) 查询域名的解析情况的常用工具
- [iptables](/commands/iptables.html) 防火墙设置

#### 文件管理

- [cd](/commands/cd.html)  变换工作目录
- [ls](/commands/ls.html) 显示文件与目录信息
- [chattr and lschattr](/commands/chattr.html) 改变与查看文件、目录属性

#### 查找命令

- [find](/commands/find.html) 是最常见和最强大的查找命令，你可以用它找到任何你想找的文件
- [grep](/commands/grep.html) 全面搜索正则表达式并把行打印出来的文本搜索工具
## Bash编程

Bash 是一个为GNU計劃编写的Unix shell。它的名字是一系列缩写：Bourne-Again SHell. Bash也是Linux下最床用的shell之一。
