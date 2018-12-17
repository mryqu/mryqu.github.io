---
title: '在Linux终端下启动SAS管理控制台'
date: 2016-03-29 21:50:15
categories: 
- Tool
tags: 
- sas
- sasmanagementconsole
- linux
- x11forward
---
在Linux终端下没有X11显示系统的情况下，可以通过如下命令将X11转移到其他X视窗服务器以显示SMC界面：
```
$ export DISPLAY=[machine]:[port]
$ pwd
/local/install/SASServer/SASHome/SASManagementConsole/9.4
$ ./sasmc
```
