---
title: '[C++] addr2line使用'
date: 2015-09-11 05:33:28
categories: 
- Tool
- C++
tags: 
- addr2line
- objdump
- readelf
- linenumber
- debug
---
[GNU Binutils](https://www.gnu.org/software/binutils/)的Addr2line工具是一个可以将指令的地址和可执行程序转换成文件名、函数名和源代码行数的工具。这种功能对于将跟踪地址转换成更有意义的内容来说简直是太棒了。

下面是一个小示例testAddr2line.c：
```
#include "stdio.h"

void test() {
    printf("Hello Addr2line\n");
}
int main() {
    test();
    return 0;
}
```

编译时使用-g选项包含调试符号条，使用-Wl,-Map=testAddr2line.map选项输出MapFile。
```
gcc -Wl,-Map=testAddr2line.map -g -o testAddr2line testAddr2line.c
```

testAddr2line.map部分内容如下：
![[C++] addr2line使用](/images/2015/9/0026uWfMzy7cKgLgEKmca.jpg)
testAddr2line中也包含符号表信息，因而可以使用objdump查找：
```
hadoop@node51054:~/ctest$ objdump -t testAddr2line | grep 'main\|test'
testAddr2line:     file format elf64-x86-64
0000000000000000 l    df *ABS*  0000000000000000  testAddr2line.c
0000000000000000       F *UND*  0000000000000000  __libc_start_main@@GLIBC_2.2.5
0000000000400547 g     F .text  0000000000000015  main
0000000000400536 g     F .text  0000000000000011  test
```

使用addr2line：
```
hadoop@node51054:~/ctest$ addr2line -e testAddr2line 400536
/home/hadoop/ctest/testAddr2line.c:3
hadoop@node51054:~/ctest$ addr2line -e testAddr2line -f 400536
test
/home/hadoop/ctest/testAddr2line.c:3
hadoop@node51054:~/ctest$ addr2line -e testAddr2line 400547
/home/hadoop/ctest/testAddr2line.c:6
hadoop@node51054:~/ctest$ addr2line -e testAddr2line -f 400547
main
/home/hadoop/ctest/testAddr2line.c:6
hadoop@node51054:~/ctest$
hadoop@node51054:~/ctest$ addr2line -e testAddr2line -f 0x0000000000400547
main
/home/hadoop/ctest/testAddr2line.c:6
```

addr2line如何找到的源代码行数的呢？在可执行程序中都包含有调试信息，其中很重要的一份数据就是程序源文件与编译后的机器代码之间的对应关系目录表、文件名表和行数语句。上述信息存储在可执行程序的.debug_line域，使用命令readelf-w testAddr2line可以输出DWARF的调试信息。
![[C++] addr2line使用](/images/2015/9/0026uWfMzy7cKgIJ07791.jpg)
这里说明机器二进制编码的0x400536位置开始对应于源码中的第3行，0x400547开始就对应与源码的第6行了。

addr2line也可以用于对系统segfault日志信息定位错误位置。下面为一个日志信息示例：
```
/home/mryqu/ctest/mydrv.so(mytracex+0x2e) [0x7f713e0c696e]
/home/mryqu/ctest/mydrv.so(exceptionHandler+0x13a) [0x7f713e08428a]
/home/mryqu/ctest/mymk.so(myExcept+0x5b) [0x7f71433b55bb]
/home/mryqu/ctest/mymk.so(my_signal_handler+0x160) [0x7f71433b5c00]
/lib64/libpthread.so.0(+0xf790) [0x7f71448ad790]
/home/mryqu/ctest/mytable.so(__XXXX_avx_rep_memcpy+0x130) [0x7f713a340030]
/home/mryqu/ctest/mytable.so(+0x4652e) [0x7f713a1bb52e]
/home/mryqu/ctest/mytable.so(+0x42829) [0x7f713a1b7829]
/home/mryqu/ctest/mydrv.so(+0x1f4d3) [0x7f713e0944d3]
/home/mryqu/ctest/mydrv.so(+0x2c850) [0x7f713e0a1850]
/home/mryqu/ctest/mydrv.so(+0x29fb1) [0x7f713e09efb1]
/home/mryqu/ctest/mymk.so(myMain+0x8d) [0x7f71433b367d]
/home/mryqu/ctest/mymk.so(myMain+0x6f) [0x7f71433b53ff]
/lib64/libpthread.so.0(+0x7a51) [0x7f71448a5a51]
/lib64/libc.so.6(clone+0x6d) [0x7f7143f339ad]
```

当指令指针位置为动态库偏移量时，如mydrv.so**(+0x2c850)**，则可以直接使用addr2line查看源码位置。
当指令指针位置为函数偏移量时，如mydrv.so**<font color="red">(exceptionHandler+0x13a)</font>**，则需要先查找函数（如exceptionHandler）相对动态库的偏移量，之后与相对偏移量相加以用于addr2line命令。
可以通过objdump-S命令查找函数的指令指针地址：
![[C++] addr2line使用](/images/2015/9/0026uWfMzy7cKgHJe3ec8.png)

### 参考

[addr2line - linux man page](https://linux.die.net/man/1/addr2line)  
[用 Graphviz 可视化函数调用](https://www.ibm.com/developerworks/cn/linux/l-graphvis/)  
[addr2line objdump命令使用方法](http://blog.csdn.net/chrovery/article/details/48035235)  