---
title: '[C++] GNU Binutils之ar和ranlib'
date: 2015-12-06 07:36:13
categories: 
- Tool
- C++
tags: 
- ar
- ranlib
- binutils
- gcc
---
[GNU binutils](https://www.gnu.org/software/binutils/)是一组二进制工具集。包括：ld、as、addr2line、ar、gprof、nm、objcopy、objdump、ranlib、size、strings、strip等。本文重点学习一下其中的ar和ranlib。

### [ar](https://linux.die.net/man/1/ar)命令

[ar](https://linux.die.net/man/1/ar)用于建立、修改、提取档案文件(archive)。archive是一个包含多个被包含文件的单一文件（也称之为库文件），其结构保证了可以从中检索并得到原始的被包含文件（称之为archive中的member）。member的原始文件内容、模式（权限）、时间戳、所有者和组等属性都被保存在archive中。member被提取后，他们的属性被恢复到初始状态。
[ar](https://linux.die.net/man/1/ar)命令第一个参数可混合指令代码（operationcode p）和修饰符标志（modifier flags mod），可按意愿添加一个折线。
```
ar [--plugin name] [-X32_64] [-]p[mod [relpos] [count]] archive [member...]
```

#### 指令参数

- d：删除档案文件中的成员文件。
- m：移动在档案文件中的成员文件，改变次序。可以借助修饰符标志a、b、i移动到指定位置。
- p：显示档案文件中的成员文件内容。
- q：将文件快速附加在档案文件末端。不检查、不替换已有同名成员文件，也不更新档案文件的符号表索引，修饰符标志a、b、i无效。然而很多不同系统都假设q指令重建档案文件的符号表索引，因此GNU将其按照r指令进行相同实现。
- r：将文件插入档案文件中。检查并替换已有同名成员文件，重建档案文件的符号表索引，借助修饰符标志a、b、i将文件插入到指定位置。
- t：显示档案文件中所包含的文件。
- x：自档案文件中取出成员文件。

#### 修饰符标志

- a <成员文件>：将文件插入档案文件中指定的成员文件之后。
- b<成员文件>：将文件插入档案文件中指定的成员文件之前。
- c：建立档案文件。当更新档案文件时，档案文件不存在则创建档案文件，但会告警。此标志可抑制告警。
- D：以确定模式工作。
- f：为避免过长的文件名不兼容于其他系统的ar指令指令，可利用此参数，截掉要放入档案文件中过长的成员文件名称。
- i <成员文件>：将文件插入档案文件中指定的成员文件之前。（等同标志b）
- I：可接受但不使用。
- N：使用count参数。当档案文件中存在多个同名成员，用于指定提取/删除的个数。
- o：保留档案文件中文件的日期。如无此参数，则输出文件的修改时间为提取时间。
- s：若档案文件中包含了对象模式，可利用此参数建立档案文件的符号表。
- S：不产生符号表。
- T：使指定档案文件成为瘦档案文件。例如将多个档案文件加入目标档案文件，目标档案文件可以包含符号索引及对源档案文件中成员文件的引用。
- u：只将日期较新文件插入档案文件中。
- v：程序执行时显示详细的信息。
- V：显示版本信息。

#### 练习
```
# 将当前目录下所有.o打包成libyqutest.a档案文件：r插入，v显示操作信息，s生成符号表。 
ar rvs libyqutest.a *.o 

# 制作瘦档案文件：r插入，c建立档案文件，T指定为瘦档案文件。
ar -rcT libkx.a libke.a libxiao.a
```

### [ranlib](https://linux.die.net/man/1/ranlib)命令

为档案文件创建符号索引。
```
ranlib [-vVt] archive
```
选项：
- -v、-V或--version：显示版本
- -t：更新档案文件符号映射的时戳。

最早在Unix系统上ar程序是单纯用来打包多个.o到.a（类似于tar做的事情），而不处理.o里的符号表。Linker程序则需要.a文件提供一个完整的符号表，所以当时就写了单独的ranlib程序用来产生linker所需要的符号信息，也就是说那时，产生一个对linker合格的的.a文件需要做ar和ranlib两步 。如今，ar-s就做了ranlib的工作，但为了保证这些早期Makefile文件的兼容性，ranlib被保留下来了。
