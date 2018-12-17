---
title: '[Eclipse] 确认Eclipse是32/64bit的方法'
date: 2013-10-26 22:19:41
categories: 
- Tool
- Eclipse
tags: 
- eclipse
- platform
- 32bit
- 64bit
---
两种方法：

- 打开Eclipse界面：Help -> About Eclipse -> Installation Details -> Configuration，若看到x86字样说明Eclipse是32bit的，若看到x86_64或x64字样则说明Eclipse是64bit的。![[Eclipse] 确认Eclipse是32/64bit的方法](/images/2013/10/0026uWfMzy784NkvCPi2c.jpg)
- 查看Eclipse安装目录下的eclipse.ini文件，如果launcher.library设置的值中写的是X86就说明Eclipse是32bit的，如果写的是x86_64或x64则说明Eclipse是64bit的。![[Eclipse] 确认Eclipse是32/64bit的方法](/images/2013/10/0026uWfMzy784NEk5ue26.jpg)