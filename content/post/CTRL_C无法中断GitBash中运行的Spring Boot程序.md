---
title: 'CTRL+C无法中断Git Bash中运行的Spring Boot程序'
date: 2019-07-12 20:02:02
categories: 
- Tool
tags: 
- CTRL+C
- Git Bash
- MinTTY
---

在Git Bash中通过gradle bootRun的方式运行Spring Boot程序，使用CTRL+C无法中断运行的程序，重启计算机才能重新运行Spring Boot程序。  
忍了很久，最近查了查，发现是Msys2使用的MinTTY终端无法争取地将CTRL+C传递给应用导致的。  
[CTRL-C doesn't interrupt the running process #684](https://github.com/mintty/mintty/issues/684)  
[CTRL-C doesn't stop running app in Windows #773](https://github.com/spring-projects/spring-boot/issues/773)  
[Re: Ctrl-C and non-cygwin programs](http://cygwin.com/ml/cygwin/2006-12/msg00151.html)  
[Unable to use CTRL-C, 'n' and 'q' keyboard commands in Cygwin and Msys2 shells #112](https://github.com/admb-project/admb/issues/112)  
[Ctrl+C no longer kills running process in Git Bash](https://www.bountysource.com/issues/54434582-ctrl-c-no-longer-kills-running-process-in-git-bash)  

在最后一个帖子中查找到适用于我使用场景的workaround：  
1. 通过文件浏览器在Git目录中删除usr\bin\mintty.exe文件  
2. 重新运行Git Bash（或在文件浏览器中直接双击git-bash.exe)  

```
# 删除mintty前
$ echo $TERM
xterm


# 删除mintty后
$ echo $TERM
cygwin
```