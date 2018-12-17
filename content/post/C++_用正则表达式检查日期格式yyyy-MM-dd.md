---
title: '[C++]用正则表达式检查日期格式yyyy-MM-dd'
date: 2015-12-31 06:21:51
categories: 
- C++
tags: 
- C++
- regex
- date
- yyyy-mm-dd
- gcc4.9.0
---
写了一个小程序使用C++的正则表达式检查日期是否符合yyyy-MM-dd格式：
![[C++]用正则表达式检查日期格式yyyy-MM-dd](/images/2015/12/0026uWfMgy70KhpRewf4f.jpg) 结果总是抛出exception，[错误代码](http://www.cplusplus.com/reference/regex/regex_error/)不是error_brack就是error_escape。检查了一下代码，没觉得不符合[ECMAScript](http://www.cplusplus.com/reference/regex/ECMAScript/)语法法则。
查了一下我的环境，用的gcc 4.7.0。试了一下[regex_match](http://www.cplusplus.com/reference/regex/regex_match/)的例子，没问题，但是稍微改动一下用\d{4}检查4位数字就又抛exception了。
```
C:\>g++ -v
Using built-in specs.
COLLECT_GCC=C:\quTools\Anaconda\Scripts\g++.bat\..\..\MinGW\bin\g++.exe
COLLECT_LTO_WRAPPER=c:/qutools/anaconda/mingw/bin/../libexec/gcc/x86_64-w64-mingw32/4.7.0/lto-wrapper.exe
Target: x86_64-w64-mingw32
Configured with: ../../../build/gcc/src/configure --target=x86_64-w64-mingw32 --prefix=/c/bb/vista64-mingw32/mingw-x86-x86_64/build/build/root --with-sysroot=/c/bb/vista64-mingw32/mingw-x86-x86_64/build/build/root --enable-languages=all,obj-c++ --enable-fully-dynamic-string --disable-multilib
Thread model: win32
gcc version 4.7.0 20111220 (experimental) (GCC)
```
搜了一下，发现C++2011标准中的regex功能直到gcc 4.9.0才正式发布。啥也不说了，在[Mingw-w64 Toolchains](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/)上直接下载个gcc 5.3.0试试，一切正常了
```
C:\ctest>g++ -v
Using built-in specs.
COLLECT_GCC=g++
COLLECT_LTO_WRAPPER=C:/tools/mingw32/bin/../libexec/gcc/i686-w64-mingw32/5.3.0/lto-wrapper.exe
Target: i686-w64-mingw32
Configured with: ../../../src/gcc-5.3.0/configure --host=i686-w64-mingw32 --build=i686-w64-mingw32 --target=i686-w64-mingw32 --prefix=/mingw32 --with-sysroot=/c/mingw530/i686-530-posix-dwarf-rt_v4-rev0/mingw32 --with-gxx-include-dir=/mingw32/i686-w64-mingw32/include/c++ --enable-shared --enable-static --disable-multilib --enable-languages=c,c++,fortran,lto --enable-libstdcxx-time=yes --enable-threads=posix --enable-libgomp --enable-libatomic --enable-lto --enable-graphite --enable-checking=release --enable-fully-dynamic-string --enable-version-specific-runtime-libs --disable-sjlj-exceptions --
with-dwarf2 --disable-isl-version-check --disable-libstdcxx-pch --disable-libstdcxx-debug --enable-bootstrap --disable-rpath --disable-win32-registry --disable-nls --disable-werror --disable-symvers --with-gnu-as --with-gnu-ld --with-arch=i686 --with-tune=generic --with-libiconv --with-system-zlib --with-gmp=/c/mingw530/prerequisites/i686-w64-mingw32-static --with-mpfr=/c/mingw530/prerequisites/i686-w64-mingw32-static --with-mpc=/c/mingw530/prerequisites/i686-w64-mingw32-static --with-isl=/c/mingw530/prerequisites/i686-w64-mingw32-static --with-pkgversion='i686-posix-dwarf-rev0, Built by MinGW
-W64 project' --with-bugurl=http://sourceforge.net/projects/mingw-w64 CFLAGS='-O2 -pipe -I/c/mingw530/i686-530-posix-dwarf-rt_v4-rev0/mingw32/opt/include -I/c/mingw530/prerequisites/i686-zlib-static/include -I/c/mingw530/prerequisites/i686-w64-mingw32-static/include' CXXFLAGS='-O2 -pipe -I/c/mingw530/i686-530-posix-dwarf-rt_v4-rev0/mingw32/opt/include -I/c/mingw530/prerequisites/i686-zlib-static/include -I/c/mingw530/prerequisites/i686-w64-mingw32-static/include' CPPFLAGS= LDFLAGS='-pipe -L/c/mingw530/i686-530-posix-dwarf-rt_v4-rev0/mingw32/opt/lib -L/c/mingw530/prerequisites/i686-zlib-static/
lib -L/c/mingw530/prerequisites/i686-w64-mingw32-static/lib -Wl,--large-address-aware'
Thread model: posix
gcc version 5.3.0 (i686-posix-dwarf-rev0, Built by MinGW-W64 project)

C:\ctest>testTimeRegex
 : 0
2015-03-01 : 1
2015-02-31 : 1
2015/02/01 : 0
15-2-1 : 0
123456789 : 0
```
附：
- [libstdc++手册](https://gcc.gnu.org/onlinedocs/libstdc++/manual/status.html#status.iso.2011)中列举了C++2011标准支持的正则表达功能(见表1.2中28节)。
- [最强日期正则表达式](http://www.cnblogs.com/jay-xu33/archive/2009/01/08/1371953.html)博文中包含更严格的日期检查代码。