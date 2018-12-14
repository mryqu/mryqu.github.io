---
title: 'Shell中的source和.命令'
date: 2013-10-10 23:11:05
categories: 
- Tool
- Linux
tags: 
- nix
- shell
- source
- .命令
- command
---
source是csh(C Shell)的内置命令: 标识读入并执行文件中的命令。
这与执行shell脚本是不一样的./script.sh会启动一个新的shell并执行script.sh中的命令。
```
source [-h] filename [arguments]
  The  shell reads and executes commands from name.  The commands
  are not placed on the history list.  If  any  args  are  given,
  they are placed in argv.  (+) source commands may be nested; if
  they are nested too deeply  the  shell  may  run  out  of  file
  descriptors.   An error in a source at any level terminates all
  nested source commands.  With -h, commands are  placed  on  the
  history list instead of being executed, much like `history -L'.
```

sh (Bourne Shell)和ksh (Korn Shell)有一个类似的命令 .
```
. filename [arguments]
  The commands in the specified file are read and executed by the shell.
  The return command may be used to return to the . command's caller.
  If file contains any ''/'' characters, it is used as is.  Otherwise, the shell
  searches the PATH for the file.  If it is not found in the PATH, it is sought
  in the current working directory.

```

bash (GNU Bourne-AgainShell)是组合了sh/ksh/csh的特征同时支持(source)命令和.命令。
