---
title: 'MinGW安装和使用'
date: 2014-02-04 18:17:07
categories: 
- Tool
tags: 
- mingw
- cygwin
- gcc
- windows
- C++
---
### MinGW简介

MinGW全称Minimalist GNU For Windows，，是将GCC编译器和GNUBinutils移植到Win32平台下的产物，包括一系列头文件（Win32API）、库和可执行文件。MinGW是从Cygwin1.3基础上发展而来，相比Cygwin而言体积更小、使用更方便。MinGW分两个分支，MinGW（即MinGW32）和MinGW-w64。
MinGW包括：
- GNU编译器套件，包括C/C++、ADA语言和Fortran语言编译器
- 用于生成Windows二进制文件的GNU工具（编译器、链接器和档案管理器）
- 用于Windows平台安装和部署MinGW和MSYS的命令行安装器（mingw-get）
- 用于命令行安装器的GUI打包器（mingw-get-inst）

### MinGW安装和使用
![MinGW安装和使用](/images/2014/2/0026uWfMgy6Z6r6PIYube.jpg)
我只想使用C/C++，所以仅安装mingw32-base、mingw32-gcc-g++。msys-base其实也是可以不用安装的，因为我可以使用已有的GitBash。
我选择了默认的安装路径c:\MinGW，可以将c:\MinGW\bin加入环境变量以便使用。
![MinGW安装和使用](/images/2014/2/0026uWfMgy6Z6rP0aU78f.jpg)

### 参考

[MinGW 官方网站](http://mingw.org/)    
[SourceForge.net：MinGW - Minimalist GNU for Windows](http://sourceforge.net/projects/mingw/)    
[SourceForge.net：MinGW-w64 - for 32 and 64 bit Windows](http://sourceforge.net/projects/mingw-w64/)    