---
title: '在Ubuntu中识别当前Init系统'
date: 2016-08-05 05:53:58
categories: 
- Tool
- Linux
tags: 
- unix
- linux
- init
---
### Ubuntu 14.04

首先用uname命令查看一下系统信息：
```
ubuntu@node50069:~$ uname -a
Linux node50069 3.19.0-25-generic #26~14.04.1-Ubuntu SMP Fri Jul 24 21:16:20 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
```

用pstree命令查看一下ID为1的进程，原来是init：![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy759cAy8UU58.png) 可以下面几个命令查看init进程所用的命令信息：
- ps -efa|grep init
- type init
- sudo stat /proc/1/exe

最终通过"sudo init --version"可知当前的Init系统为upstart：![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy759d8PJcKd2.jpg)

### Ubuntu 15.04

首先查看一下系统信息：
```
vagrant@vagrant-ubuntu-trusty:~$ uname -a
Linux vagrant-ubuntu-trusty 3.19.0-15-generic #15-Ubuntu SMP Thu Apr 16 23:32:37 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
```
用pstree命令查看一下ID为1的进程，原来是systemd：![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy75azKHvSWf2.jpg)

### 参考

[WIKI：init](https://zh.wikipedia.org/zh-cn/Init)    