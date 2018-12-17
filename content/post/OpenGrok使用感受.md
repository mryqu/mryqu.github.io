---
title: 'OpenGrok使用感受'
date: 2017-06-12 06:22:27
categories: 
- Tool
tags: 
- opengrok
- source
- code
- search
- index
---
之前为了学习项目涉及的C/C++代码，试用过SourceInsight，后来改成Vim+Exuberant Ctags+Cscope。最近一个美国同事给了个链接，原来那边的兄弟是用OpenGrok搜项目代码的！
OpenGrok是一个快速、便于使用的源码搜索引擎与对照引擎，它能够帮助我们快速地搜索、定位、对照代码树。它可以理解各种程序语言和文件格式，及Mercurial、Git、SCCS、RCS、CVS、Subversion、Teamware、ClearCase、Perforce、Monotone和Bazaar等版本控制历史记录。OpenGrok是OpenSolaris操作系统源文件浏览和搜索的工具。
![OpenGrok](/images/2017/06/OpenGrok.png) OpenGrok由Java语言实现，需要Java 1.8、一个Servlet容器以及Exuberant Ctags。
用完就一个字：爽！

### 参考
* * *
[OpenGrok主页](https://opengrok.github.io/OpenGrok/)  
[GitHub：OpenGrok/OpenGrok](https://github.com/OpenGrok/OpenGrok)  
[OpenGrok：Comparison with Similar Tools](https://github.com/OpenGrok/OpenGrok/wiki/Comparison-with-Similar-Tools)  
[OpenGrok：Supported Languages and Formats](https://github.com/OpenGrok/OpenGrok/wiki/Supported-Languages-and-Formats)  
[OpenGrok：Supported Revision Control Systems](https://github.com/OpenGrok/OpenGrok/wiki/Supported-Revision-Control-Systems)  
[Ubuntu环境下OpenGrok的安装及使用](http://blog.csdn.net/weihan1314/article/details/8944291)  