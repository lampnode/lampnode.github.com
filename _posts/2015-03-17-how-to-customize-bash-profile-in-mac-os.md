---
layout: post
title: "How to customize bash profile in Mac OS"
tagline: "How to customize bash profile in Mac OS"
description: ""
category: MacOS
tags: [ MacOS, Bash ]
---
{% include JB/setup %}

This document is show you how to customize the command-line profile of bash.


## Add new alias

    alias ll='ls -alF'
    alias la='ls -A'

## Add color for bash output

    export CLICOLOR=1  
    export LSCOLORS=gxfxaxdxcxegedabagacad
    
## Change the primary prompt

    export PS1="\u@\h:\w$ " # out put as username@hosname:currentPath$ 
    
or

    export PS1="[\u@\H \w]\$ " #out put as [ username@hosname:currentPath ] $
