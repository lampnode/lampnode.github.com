---
layout: page
title: "Useradd"
description: ""
---
{% include JB/setup %}

## 使用范围

useradd命令用来建立用户帐号和创建用户的起始目录，使用权限是超级用户。

## 格式

	useradd [-d home] [-s shell] [-c comment] 
		[-m [-k template]] [-f inactive] [-e expire ] 
		[-p passwd] [-r] name

## 参数
* -c <备注> 加上备注文字

* -d <登入目录> 　指定用户登入时的启始目录。

* -e <expire_date>　帐号终止日期。日期的指定格式为MM/DD/YY。
 
* -f inactive_days　帐号过期几日后永久停权。当值为0时帐号则立刻被停权。而当值为-1时则关闭此功能，预设值为-1
 
* -g initial_group　group名称或以数字来做为使用者登入起始群组(group)。群组名须为现有存在的名称。群组数字也须为现有存在的群组。预设的群组数字为1。
 
* -G group,[...]　定义此使用者为此一堆groups的成员。每个群组使用","区格开来，不可以夹杂空白字元。群组名同-g选项的限制。定义值为使用者的起始群组。
 
* -m　使用者目录如不存在则自动建立。如使用-k选项skeleton_dir内的档案将复制至使用者目录下。然而在/etc/skel目录下的档案也会复制过去取代。任何在skeleton_diror/etc/skel的目录也相同会在使用者目录下一一建立。The-k同-m不建立目录以及不复制任何档案为预设值。
 
* -M　不建立使用者目录，即使/etc/login.defs系统档设定要建立使用者目录。
 
* -n　预设值使用者群组与使用者名称会相同。此选项将取消此预设值。
 
* -r　此参数是用来建立系统帐号。系统帐号的UID会比定义在系统档上/etc/login.defs.的UID_MIN来的小。注意useradd此用法所建立的帐号不会建立使用者目录，也不会在乎纪录在/etc/login.defs.的定义值。如果你想要有使用者目录须额外指定-m参数来建立系统帐号。这是REDHAT额外增设的选项。
 
* -s shell　使用者登入后使用的shell名称。预设为不填写，这样系统会帮你指定预设的登入shell。

* -u uid　使用者的ID值。必须为唯一的ID值，除非用-o选项。数字不可为负值。预设为最小不得小于999而逐次增加。0~999传统上是保留给系统帐号使用。改变预设值当-D选项出现时，useradd秀出现在的预设值，或是藉由命令列的方式更新预设值。可用选项为∶
 
