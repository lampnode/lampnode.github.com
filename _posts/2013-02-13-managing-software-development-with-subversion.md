---
layout: post
title: "使用Subversion管理软件开发代码"
tagline: "Managing Software Development with Subversion"
description: ""
category: Development
tags: [Subversion]
---
{% include JB/setup %}

## Repository Layout

### trunk

Trunk是用于进行开发的主干代码存储位置。这里包含的都是最新的，可运行的软件代码（开发模式）。Trunk没有版本号和发布名称。 仅需要保证trunk在任何时候都处于“开发模式”。
其版本号命名规则：X.X.dev(最新主版本号.最新子版本号.dev)

### branchs
根据开发计划或者你想冻结新特色的添加时或者进行一些新的技术尝试的时候，就要使用Branches了。Brahches路径包含了trunk在不同发展阶段的副本。可以分为如下2中类型：

### Release Branches

根据开发计划，发布软件的一个版本的时候，就要使用Release Branches， Release branches只是你当前trunk的一个副本，是软件开发到已经阶段的里程碑。
其版本号命名规则：X.X.build-(主版本号.子版本号.build-SVN revision版本号)，分支路径命名规则为:X.X.build

### Experimental branches

如果想尝试新的技术（如PHP版本升级），可以建议Experimental branches。
其版本号命名规则：X.X.test-(主版本号.子版本号.test-SVN revision版本号);分支路径命名规则为:X.X.test
