---
title: '[C++] 我服务器上的GCC版本不支持C++11特性'
date: 2015-12-25 06:10:29
categories: 
- Tool
- C++
tags: 
- c11
- -stdc0x
- gcc
- support
---
用了点C++11特性，结果编译失败，编译参数加"-std=c++0x"，结果识别不出来。
```
$ g++ -v
Using built-in specs.
Target: amd64-undermydesk-freebsd
Configured with: FreeBSD/amd64 system compiler
Thread model: posix
gcc version 4.2.1 20070719  [FreeBSD]
```
[C++0x/C++11 Support in GCC](http://gcc.gnu.org/projects/cxx0x.html)提到GCC 4.3版本之后才支持C++11特性，白折腾一把！
好吧，我用[gcc docker](https://hub.docker.com/_/gcc/)!