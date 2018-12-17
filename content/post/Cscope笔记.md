---
title: 'Cscope笔记'
date: 2013-10-19 20:20:11
categories: 
- Tool
- C++
tags: 
- cscope
- C++
---
### Cscope简介

Cscope是一个类似Ctags的工具，但功能比ctags强大很多。Cscope是一款自带一个基于文本的用户界面的源代码浏览工具，尽管它最初是为C代码的搜索（包括lex、yacc文件）设计的，但是也可以用于对C++和Java代码的搜索。用Cscope你可以轻易地搜索到你的标识符是在哪里被定义和使用的，它可以轻而易举地解决以下问题：
- 这个变量在哪里被使用？
- 这个预处理符号的值是什么？
- 这个函数都在哪些源代码文件中出现过？
- 都有哪些函数调用了这个函数？
- "out of space"的消息是从哪里来的？
- 这个源文件在在目录结构中的位置？
- 都有哪些源文件包含了这个头文件？

Cscope是由Santa Cruz Operation, Inc发布的，它遵循BSD开源协议。

### 安装

Cscope项目仅提供源代码，不提供二进制文件。cscope-win32项目提供了[使用MinGW、MSYS和Cygwin编译Windows平台Cscope](https://code.google.com/p/cscope-win32/wiki/BuildingCscope)的方法，此外也提供编译好好的csope.exe文件。下载[cscope-15.8a-win64rev1-static.zip](https://cscope-win32.googlecode.com/files/cscope-15.8a-win64rev1-static.zip)，将其中的cscope.exe解压缩到系统环境变量path包含的路径即可。
![Cscope笔记](/images/2013/10/0026uWfMgy6XFivQqxC5c.png)

### 使用

#### 创建符号数据库
Cscope在第一次被使用在指定的源文件时会建立一个符号的数据库。接下来调用时，Cscope仅仅重建那些被改动或者和新文件相关的数据库。那些没有被改动的文件相关的数据库会被直接复制使用。这使得重建数据库要比第一次运行快许多。
Cscope命令的参数如下：
- **-R**: 在生成索引文件时，搜索子目录树中的代码
- **-b**: 只生成索引文件，不进入cscope的界面
- **-q**:生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
- **-k**: 在生成索引文件时，不搜索/usr/include目录
- **-i**:如果保存文件列表的文件名不是cscope.files时，需要加此选项告诉cscope到哪儿去找源文件列表。可以使用”**-**“，表示由标准输入获得文件列表。
- **-I**_dir_:在**-I**选项指出的目录中查找头文件
- **-u**: 扫描所有文件，重新生成交叉索引文件
- **-C**: 在搜索时忽略大小写
- **-P**_path_:在以相对路径表示的文件前加上的path，这样，你不用切换到你数据库文件所在的目录也可以使用它了。    

我针对curl项目执行`cscope -Rkq` ，这样会启动Cscope的文本用户界面，之后我搜索set_binmode函数： ![Cscope笔记](/images/2013/10/0026uWfMgy6XGAG6B6A1c.jpg)

#### 搜索符号

在Cscope的文本界面里可以在命令模式执行:cs find或:cs f命令搜索符号，其参数为：
- **s:** 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
- **g:** 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
- **d:** 查找本函数调用的函数
- **c:** 查找调用本函数的函数
- **t:** 查找指定的字符串
- **e:** 查找egrep模式，相当于egrep功能，但查找速度快多了
- **f:** 查找并打开文件，类似vim的find功能
- **i:** 查找包含本文件的文件

![Cscope笔记](/images/2013/10/0026uWfMgy6XGBDPdGca4.jpg)下面示例为用
```
:cs
f c set_binmode
```
命令搜索set_binmode函数的调用者：![Cscope笔记](/images/2013/10/0026uWfMgy6XHjBrn2O62.jpg)

#### E567: no cscope connections错误处理

有个帖子[vim cannot connect to cscope database](http://stackoverflow.com/questions/6450265/vim-cannot-connect-to-cscope-database)讲过解决方案，但是在我的Windows平台cscope文本界面不起作用。通过:cs add {prj path}/cscope.out添加符号数据库可在一定程度避免这一问题。

### 参考

[Cscope网站](http://cscope.sourceforge.net)    
[SourceForge：Cscope项目](http://sourceforge.net/projects/cscope/)    
[Cscope手册](cscope.sourceforge.net/cscope_man_page.html)    
[Cscope-win32下载](https://code.google.com/p/cscope-win32/downloads/list)    