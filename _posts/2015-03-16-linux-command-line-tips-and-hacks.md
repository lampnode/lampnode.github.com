---
layout: post
title: "Linux Command Line Tips and Hacks"
tagline: "Linux Command Line Tips and Hacks"
description: ""
category: Linux
tags: [ Linux, Mac ]
---
{% include JB/setup %}

Command line tricks, tools, tips and hacks to help you get the most out of the shell prompt in Linux.

## Tips

### Multiple Commands in one line

If you want to execute two commands consecutively, then you would use the following syntax:

    command1 ; command2

command1 and command2 are executed. 

if you need command1 to complete successfully before executing command2, then you would use the following syntax:

    command1 && command2

In the format above, nothing happened when the first command did not complete successfully. If you want command2 
to execute only if command1 fails, then you would use the following syntax:

    command1 || command2

In the above format, command2 was only executed when command1 failed.

### Keyboard Shortcuts

* Ctrl+U: This clears the entire line so you can type in a completely new command.
* Ctrl+K: This deletes the line from the position of the cursor to the end of the line.
* Ctrl+W: This deletes the word before the cursor only.
* Ctrl+R: This lets you search your command history for something specific. 

### history & grep

If you want to see all the recent commands you ran that included nano, for example, you could just run:

    history | grep nano
    
You'll get a list that looks something like this:

    381 sudo nano /etc/NetworkManager/nm-system-settings.conf
    387 sudo nano /etc/rc.conf
    388 sudo nano /etc/rc.conf
    455 sudo nano /boot/grub/menu.lst
    
    
You can then pick a command out from that list—say I want to run "sudo nano /boot/grub/menu.lst", 
which grep lists as command 455—and run it using:

    !455
    
Lastly, if you want to keep certain commands out of your history, just put a s