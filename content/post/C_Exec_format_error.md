---
title: '[C] Exec format error'
date: 2013-10-20 17:28:57
categories: 
- Tool
- C++
tags: 
- C
- gcc
- -c
- executable
- format
---
很久没用g++了，结果编个小程序还出错。
```
mryqu:~/ctest$ g++ -g -c wvc.cpp -o wvc
mryqu:~/ctest$ chmod a+x wvc
mryqu:~/ctest$ ./wvc
-bash: ./wvc: cannot execute binary file: Exec format error
mryqu:~/ctest$ file wvc
wvc: ELF 64-bit LSB  relocatable, x86-64, version 1 (SYSV), not stripped
```

查了查gcc的帮助，才发现用了-c选项后其实是只编译不链接的：
```
-c
Compile or assemble the source files, but do not link. The linking stage simply is not done. The ultimate output is in the form of an object file for each source file.
By default, the object file name for a source file is made by replacing the suffix .c, .i, .s, etc., with .o.
Unrecognized input files, not requiring compilation or assembly, are ignored.
```

去掉-c选项后一切OK！
```
mryqu:~/ctest$ g++ -g wvc.cpp -o wvc
mryqu:~/ctest$ file wvc
wvc: ELF 64-bit LSB  executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=XXXX, not stripped
mryqu:~/ctest$ chmod a+x wvc
```