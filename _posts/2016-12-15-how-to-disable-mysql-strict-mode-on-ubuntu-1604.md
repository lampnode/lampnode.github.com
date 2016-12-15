---
layout: post
title: "How to disable MySQL strict mode on Ubuntu 16.04"
tagline: "How to disable MySQL strict mode on Ubuntu 16.04"
description: ""
category: 
tags: [MySQL, PHP]
---
{% include JB/setup %}


MySQL has a strict mode in 5.7 as a default option. If you updated the Mysql to this version, your old version PHP apps maybe been broken.

On MySQL 5.7, the default values for this key  are: 

    STRICT_TRANS_TABLES,ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

The strict mode comes from STRICT_TRANS_TABLES. So, let's overwrite the sql_mode and set it to be the same as the default, but without strict mode.

    sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf

add the following line on section [mysqld]

    sql-mode="ERROR_FOR_DIVISION_BY_ZERO,NO_ZERO_DATE,NO_ZERO_IN_DATE,NO_AUTO_CREATE_USER"

That's it! Save the file, and restart MySQL. 
