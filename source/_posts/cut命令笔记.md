---
title: 'cut命令笔记'
date: 2013-10-22 23:22:24
categories: 
- Tool
- Linux
tags: 
- cut
- linux
- unix
---
cut命令比较简单，但是也没测试过所有的选项，这里试一下没有细扣过的选项。
```
命令名
  cut -- 对文件每一行的选定部分进行裁剪

概要
  cut -b list [-n] [file ...]
  cut -c list [file ...]
  cut -f list [-d delim] [-s] [file ...]

描述
  cut工具会从每个文件每一行裁剪出选定部分并写入标准输出。如果没有指定file参数，或file参数为单个破折号('-')，cut将从标准输入进行读取。list指定可以是列位置或特定字符分隔的字段序号，起始值为1。
  
  list选项参数为逗号或空白字符分隔的数字或数字范围集合。数字范围可由数字+破折号（'-'）+第二个数字组成内包含范围。 数字和数字范围可以重复、重叠，但字段或列如果多次被选中，则仅显示一次。输入中没有选定的字段或列，不会报错。
  N-   从第N个开始到所在行结束的所有字节、字符或列
  N-M  从第N个开始到第M个之间(包括第M个)的所有字节、字符或列
  -M   从第1个开始到第M个之间(包括第M个)的所有字节、字符或列
  
  命令选项如下：
  
  -b list
          list指定字节位置。
  
  -c list
          list指定字符位置。
  
  -d delim
          使用delim而不是制表符作为字段分隔符。
  
  -f list
          list指定由字段分隔符(见-d选项)对输入分割后的字段。 输出字段由单个字段分隔符分开。
  
  -n      不拆分多字节字符。 仅在多字节字符全部选中的情况下，字符才会被输出。
  
  -s      抑制没有字段分隔符的行。如果没指定该选项的话，没有分隔符的行会原封不动地输出。

环境
  环境变量LANG、LC_ALL和LC_CTYPE将影响cut的执行结果。

退出码
  cut工具执行成功时返回0，执行出错时返回值大于0。

示例
  从系统passwd文件抽取用户登录名和Shell(5)，显示成''name:shell''对:
        cut -d : -f 1,7 /etc/passwd
  
  显示当前登录用户的名称和登录时间:
        who | cut -c 1-16,26-38
```

### 个人体会

- cut命令在unix/mac和linux/MinGW上实现并不一样。
- cut命令在linux/MinGW上的实现忽略-n选项，此外通过[GNU CoreUtils](http://ftp.gnu.org/gnu/coreutils/coreutils-8.21.tar.xz)中的cut源码可知-b和-c选项实现是一样的，operating_mode变量都是枚举byte_mode，走的是cut_bytes函数。而unix/mac上的实现通过-n选项可以同时是否输出多字节字符的部分字节码。
- cut命令在linux/MinGW上的实现还有--output-delimiter=STRING选项控制输出字符分隔符。