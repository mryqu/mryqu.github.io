---
title: '[C] GCC对UTF8 BOM的支持'
date: 2013-10-24 20:31:28
categories: 
- Tool
- C++
tags: 
- gcc
- utf8
- bom
- support
- compile
---
最近玩些特俗字符，结果对yqutest.cpp源码文件编译时先碰到error:converting to execution character set: Illegal bytesequence错误。GCC的源码字符集与执行字符集默认是UTF-8编码，为了避免源码文件乱码，最好也是采用UTF-8编码来存储源码文件。将源码编码转成UTF-8，问题得以解决。
但是否需要UTF-8 BOM(byte-order mark)呢？
我一时兴起添加了BOM，十六进制为EF BB BF，即对应八进制的357 273 277，编译结果如下：
```
mryqu> g++ yqutest.cpp -o yqutst123
yqutest.cpp:1: error: stray '\357' in program
yqutest.cpp:1: error: stray '\273' in program
yqutest.cpp:1: error: stray '\277' in program
yqutest.cpp:1: error: stray '#' in program
yqutest.cpp:1: error: expected constructor, destructor, or type conversion before '<' token
mryqu> g++ -v
Using built-in specs.
Target: amd64-undermydesk-freebsd
Configured with: FreeBSD/amd64 system compiler
Thread model: posix
gcc version 4.2.1 20070719  [FreeBSD]
```

折腾一下-finput-charset和-fextended-identifiers选项，不管用。
```
g++ -finput-charset=UTF-8 -fextended-identifiers yqutest.cpp -o yqutst123
```

后来看到[Bug 33415 - Can't compile .cpp file with UTF-8 BOM](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=33415)，才知道是我用的G++版本太低，起码GCC4.4.0才支持UTF-8 BOM。老老实实去掉BOM就可以编译过了。

### 参考

[[C/C++] 各种C/C++编译器对UTF-8源码文件的兼容性测试（VC、GCC、BCB）](http://www.cnblogs.com/zyl910/archive/2012/07/26/cfile_utf8.html)    
[Using UTF-8 as the internal representation for strings in C and C++ with Visual Studio](http://www.nubaria.com/en/blog/?p=289)    