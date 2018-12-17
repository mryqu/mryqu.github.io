---
title: '[Golang] 折腾一下Golang项目调试'
date: 2017-10-24 05:59:46
categories: 
- Golang
tags: 
- mingw-w64
- tdm-gcc
- golang
- gdb
- delve
---
想装个MinGW-W64玩玩64位GDB，才发现继上一博文[MinGW安装和使用](/post/mingw安装和使用)已三年了，不经意间到看到了下列帖子：
- [MinGW MinGW-w64 TDM-GCC等工具链之间的区别与联系](http://blog.csdn.net/crazycoder8848/article/details/25164471)
- [发现个新环境msys2](http://i.rexdf.org/blog/2015/04/04/fa-xian-ge-xin-huan-jing-msys2/)
- [MinGW、MinGW-w64 与TDM-GCC 应该如何选择？](https://www.zhihu.com/question/39952667)

对于[mingw-w64](http://mingw-w64.org)、[tdm-gcc](http://tdm-gcc.tdragon.net/)、[Win-builds](http://win-builds.org/)这三个小纠结一会，觉得自己本身也就是用一下GDB，还是去[https://sourceforge.net/projects/mingw-w64/](https://sourceforge.net/projects/mingw-w64/)直接下载MinGW-W64好了。

### MinGW-W64安装

所用MinGW-W64安装配置：

| 配置项 | 配置值 |
| - | - |
| **Architecture** | x86_64 |
| **Threads** | posix |
| **Exception** | seh |

### Golang项目编译

编译Golang项目采用 `go build -gcflags “-N -l”` 关闭内联优化。

### GDB调试

载入[runtime-gdb.py](https://golang.org/src/runtime/runtime-gdb.py)脚本以对Go运行时结构进行完美打印和转换(例如显示slice和map值、查看goroutine等)：
- 参数载入：gdb -d $GCROOT
- 手工载入：source C:\Go\src\runtime\runtime-gdb.py
折腾一会，最后还是折在[GDB on windows with golang: buildsym_init Assertion "free_pendings == NULL" failed.](https://sourceware.org/bugzilla/show_bug.cgi?id=18624)这个问题上，一调试就DDB崩了，貌似目前无解。

### Delve调试

不过[Debugging Go Code with GDB](https://golang.org/doc/gdb)里还介绍了另外一个对Golang支持更好的工具[Delve](https://github.com/derekparker/delve)。![delve](/images/2017/10/delve.png) 上手容易，有些命令跟GDB差不多。![delve commands](/images/2017/10/delveCmds.png) 好了，就折腾到这里了。目前不太需要的东东就不花费力气了。



