---
title: 'nohup命令笔记'
date: 2013-10-26 11:24:28
categories: 
- Tool
- Linux
tags: 
- linux
- nohug
---
Unix/Linux下一般比如想让某个程序在后台运行，很多都是使用 &在程序结尾来让程序自动运行。比如我们要运行mysql在后台：
```
/usr/local/mysql/bin/mysqld_safe --user=mysql &
```

但是很多程序并不象mysqld一样做成守护进程，一般普通程序使用 &结尾在后台运行，如果终端关闭了，普通程序还是会被关闭。如果想要在退出帐户/关闭终端之后继续运行相应的普通进程。我们就可以使用nohup这个命令，nohup就是不挂起的意思(nohang up)。
```
nohup COMMAND [ARG]...
```

nohup 命令运行由 Command参数和任何相关的 Arg参数指定的命令，忽略所有挂断（SIGHUP）信号。在注销后使用nohup 命令运行后台中的程序。要运行后台中的 nohup 命令，添加&到命令的尾部。

如果不将 nohup 命令的输出重定向，输出将附加到当前目录的 nohup.out 文件中。如果当前目录的 nohup.out文件不可写，输出重定向到 $HOME/nohup.out 文件中。如果没有文件能创建或打开以用于追加，那么 Command参数指定的命令不可调用。如果标准错误是一个终端，那么把指定的命令写给标准错误的所有输出作为标准输出重定向到相同的文件描述符。
```
nohup command > myout.file 2>&1 
```

该命令返回下列出口值：

- 126：可以查找但不能调用 Command 参数指定的命令。
- 127：nohup 命令发生错误或不能查找由 Command 参数指定的命令。
- 其他：Command 参数指定命令的退出状态。
使用jobs查看任务。使用fg %n关闭。
