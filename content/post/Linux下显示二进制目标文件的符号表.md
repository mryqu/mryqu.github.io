---
title: 'Linux/Unix下显示二进制目标文件的符号表'
date: 2013-10-31 22:22:34
categories: 
- C++
tags: 
- symbol
- elf
- linux
- nm
- readelf
---
### nm

查看二进制目标文件符号表的标准工具是nm，可以执行下列命令查看二进制目标文件（.o）/静态库（.a）/动态库（.so）的符号表：
```
nm -g yourObj.o
nm -g yourLib.a
nm -g yourLib.so
```

C/C++语言在C++编译器编译以后，函数的名字会被编译器修改，改成编译器内部的名字，这个名字会在链接的时候用到。例如std::string::size()经过修饰后是_ZNKSs4sizeEv。通过添加"-C"选项，可以对底层符号表译成用户级名称（demangle），具有更好的可读性。

以test.cpp为例：![Linux/Unix下显示二进制目标文件的符号表](/images/2013/10/0026uWfMgy6YLylTfgJ61.png)
将其编译后，通过nm查看符号表，带"-C"选项与否的结果如下：![Linux/Unix下显示二进制目标文件的符号表](/images/2013/10/0026uWfMgy6YLyG1SuB59.jpg)

### readelf

如果你的二进制目标文件（.o）/静态库（.a）/动态库（.so）是ELF（Executableand linkingformat）格式，则可以使用readelf命令提取符号表信息。
```
readelf -Ws usr/lib/yourLib.so
```

如果仅想输出函数名，可以通过awk命令进行解析：
```
readelf -Ws test.o  | awk '$4=="FUNC" {print $8}';
```

以上面的test.o为例：

显示test.o的elf文件头信息：![Linux/Unix下显示二进制目标文件的符号表](/images/2013/10/0026uWfMgy6YLKopZKie2.png)
显示test.o的符号表：![Linux/Unix下显示二进制目标文件的符号表](/images/2013/10/0026uWfMgy6YLKCrkDG74.jpg)

### 参考

[How do I list the symbols in a .so file](http://stackoverflow.com/questions/34732/how-do-i-list-the-symbols-in-a-so-file)    
[nm - Linux man page](http://linux.die.net/man/1/nm)    
[readelf - Linux man page](http://linux.die.net/man/1/readelf)    
[](http://man.linuxde.net/nm)    
[](http://man.linuxde.net/readelf)  