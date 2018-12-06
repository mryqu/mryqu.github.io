---
title: '[Linux] 判断可执行文件或动态库是否包含符号表'
date: 2013-10-24 22:48:09
categories: 
- Tool
- C++
tags: 
- linux
- debug
- symbol
- file
- objdump
---
在Linux下生成一个可执行文件或动态库，可以使用gcc/g++的"-g"选项使文件包含调试符号表。
要在Linux下判断一个第三方的可执行文件或动态库是否包含调试符号表，可以通过file命令实现：
```
srv01> file libcurl.so.6
libcurl.so.6: ELF 64-bit LSB shared object, x86-64, version 1 (FreeBSD), dynamically linked, not stripped

srv01> file /usr/bin/X11/curl
/usr/bin/X11/curl: ELF 64-bit LSB executable, x86-64, version 1 (FreeBSD), dynamically linked (uses shared libs), for FreeBSD 8.0 (800107), stripped
```

显示not stripped，表明文件带调试符号表；而显示stripped，表明文件已去除符号表。

如果文件包含调试符号表，可以通过objdump -t命令及选项打印文件的符号表：
```
srv01> objdump -t libcurl.so.6

libcurl.so.6:     file format elf64-x86-64

SYMBOL TABLE:
0000000000000120 l    d  .hash  0000000000000000
00000000000012b0 l    d  .dynsym        0000000000000000
0000000000004b08 l    d  .dynstr        0000000000000000
0000000000006f36 l    d  .gnu.version   0000000000000000
00000000000073e8 l    d  .gnu.version_r 0000000000000000
0000000000007418 l    d  .rela.dyn      0000000000000000
00000000000092a8 l    d  .rela.plt      0000000000000000
000000000000bfc0 l    d  .init  0000000000000000
000000000000bfd4 l    d  .plt   0000000000000000
000000000000de00 l    d  .text  0000000000000000
0000000000043388 l    d  .fini  0000000000000000
........
```