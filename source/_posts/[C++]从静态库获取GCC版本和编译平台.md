---
title: '[C++] 从静态库获取GCC版本和编译平台'
date: 2013-10-24 07:43:44
categories: 
- Tool
- C++
tags: 
- cpp
- static
- library
- gcc
- platform
---
获取GCC版本：strings -a {library} | grep "GCC: ("
```
mryqu> strings -a libcurl.a | grep "GCC: ("
GCC: (GNU) 4.4.5 20110214 (Red Hat 4.4.5-6)
```

获取编译平台信息：ar -x {library}file *.o
```
mryqu> ar -x libcurl.a
mryqu>file libcurl_la-url.o
libcurl_la-url.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
```

### 参考

[How to retrieve the GCC version used to compile a given ELF executable?](https://stackoverflow.com/questions/2387040/how-to-retrieve-the-gcc-version-used-to-compile-a-given-elf-executable)    
[How to see the compilation platform of a static library file](https://stackoverflow.com/questions/9260948/how-to-see-the-compilation-platform-of-a-static-library-file)    