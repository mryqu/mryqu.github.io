---
title: '[C++] 使用NM查看目标文件的符号列表'
date: 2015-12-18 06:10:13
categories: 
- Tool
- C++
tags: 
- nm
- cpp
- gcc
---
练习使用[nm](https://linux.die.net/man/1/nm)查看目标文件的符号列表。此外发现G++竟然创建了两套构造函数和析构函数。

### nm命令

- -a或--debug-syms：显示调试符号。
- -B：等同于--format=bsd，用来兼容MIPS的nm。
- -C或--demangle：将低级符号名解码(demangle)成用户级名字。这样可以使得C++函数名具有可读性。
- -D或--dynamic：显示动态符号。该任选项仅对于动态目标(例如特定类型的共享库)有意义。
- -fformat：使用format格式输出。format可以选取bsd、sysv或posix，该选项在GNU的nm中有用。默认为bsd。
- -g或--extern-only：仅显示外部符号。
- -n、-v或--numeric-sort：按符号对应地址的顺序排序，而非按符号名的字符顺序。
- -p或--no-sort：按目标文件中遇到的符号顺序显示，不排序。
- -P或--portability：使用POSIX.2标准输出格式代替默认的输出格式。等同于使用任选项-fposix。
- -s或--print-armap：当列出库中成员的符号时，包含索引。索引的内容包含：哪些模块包含哪些名字的映射。
- -r或--reverse-sort：反转排序的顺序(例如，升序变为降序)。
- --size-sort：按大小排列符号顺序。该大小是按照一个符号的值与它下一个符号的值进行计算的。
- -tradix或--radix=radix：使用radix进制显示符号值。radix只能为"d"表示十进制、"o"表示八进制或"x"表示十六进制。
- --target=bfdname：指定一个目标代码的格式，而非使用系统的默认格式。
- -u或--undefined-only：仅显示没有定义的符号(那些外部符号)。
- -l或--line-numbers：对每个符号，使用调试信息来试图找到文件名和行号。对于已定义的符号，查找符号地址的行号。对于未定义符号，查找指向符号重定位入口的行号。如果可以找到行号信息，显示在符号信息之后。
- -V或--version：显示nm的版本号。
- --help：显示nm的任选项。

### 练习

#### symtest.hpp
```
#include <iostream>

class SymTest
{
    SymTest();
    SymTest(int x);
    ~SymTest();
    void foo();
};
```
#### symtest.cpp
```
#include "symtest.hpp"

SymTest::SymTest() { printf("SymTest::SymTest\n"); }

SymTest::SymTest(int x) { printf("SymTest::SymTest(int)\n"); }

SymTest::~SymTest() { printf("SymTest::~SymTest\n"); }

void SymTest::foo() { printf("SymTest::foo\n"); }
```
#### 编译
![[C++] 使用NM查看目标文件的符号列表](/images/2015/12/0026uWfMzy79RhXyGPa4c.png)
#### NM: -g 仅显示外部符号 -C 显示用户级名字
![[C++] 使用NM查看目标文件的符号列表](/images/2015/12/0026uWfMzy79RdDF2MV29.png) 学习了StackOverflow上的帖子[Dual emission of constructor symbols](http://stackoverflow.com/questions/6921295/dual-emission-of-constructor-symbols)，才了解这是G++的一个已知问题，两套构造函数分别是complete objectconstructor和base object constructor。
#### NM: -A 在每个符号前显示文件名
![[C++] 使用NM查看目标文件的符号列表](/images/2015/12/0026uWfMzy79RiKNR1K18.png)
#### NM: -l 在每个符号前显示行号
```
mymachine> g++ -c symtest.cpp -g -o symtest.dbg.o
mymachine> nm -l symtest.dbg.o
0000000000000170 t _GLOBAL__I__ZN7SymTestC2Ev   /u/mryqu/nmtest/symtest.cpp:10
0000000000000000 t _Z17__gthread_triggerv
0000000000000130 t _Z41__static_initialization_and_destruction_0ii      /u/mryqu/nmtest/symtest.cpp:9
00000000000001b0 T _ZN7SymTest3fooEv    /u/mryqu/nmtest/symtest.cpp:9
0000000000000210 T _ZN7SymTestC1Ei      /u/mryqu/nmtest/symtest.cpp:5
0000000000000250 T _ZN7SymTestC1Ev      /u/mryqu/nmtest/symtest.cpp:3
0000000000000230 T _ZN7SymTestC2Ei      /u/mryqu/nmtest/symtest.cpp:5
0000000000000270 T _ZN7SymTestC2Ev      /u/mryqu/nmtest/symtest.cpp:3
00000000000001d0 T _ZN7SymTestD1Ev      /u/mryqu/nmtest/symtest.cpp:7
00000000000001f0 T _ZN7SymTestD2Ev      /u/mryqu/nmtest/symtest.cpp:7
                 U _ZNKSs4sizeEv        /usr/include/c++/4.2/bits/stl_algobase.h:189
                 U _ZNKSsixEm   /usr/include/c++/4.2/bits/locale_facets.tcc:2569
                 U _ZNSt8ios_base4InitC1Ev      /usr/include/c++/4.2/iostream:77
                 U _ZNSt8ios_base4InitD1Ev      /usr/include/c++/4.2/iostream:77
0000000000000010 t _ZSt17__verify_groupingPKcmRKSs      /usr/include/c++/4.2/bits/locale_facets.tcc:2558
0000000000000000 W _ZSt3minImERKT_S2_S2_
0000000000000000 b _ZSt8__ioinit
                 U __cxa_atexit /usr/include/c++/4.2/iostream:77
                 U __dso_handle /usr/include/c++/4.2/iostream:77
0000000000000000 d __gthread_active
                 U __gxx_personality_v0 /usr/include/c++/4.2/bits/locale_facets.tcc:2558
0000000000000190 t __tcf_0      /usr/include/c++/4.2/iostream:77
                 U puts /u/mryqu/nmtest/symtest.cpp:9
```

### 符号类型

符号类型一列有两个字母时，小写字母代表局部符号，大写则为全局/外部符号。
<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><td width="20">"A"</td><td>The symbol's value is absolute, and will not be changed byfurther linking.</td></tr><tr><td>"B"<br>"b"</td><td>The symbol is in the uninitialized data section (known as BSS).</td></tr><tr><td>"C"</td><td>The symbol is common. Common symbols are uninitialized data.When linking, multiple common symbols may appear with the samename. If the symbol is defined anywhere, the common symbols aretreated as undefined references.</td></tr><tr><td>"D"<br>"d"</td><td>The symbol is in the initialized data section.</td></tr><tr><td>"G"<br>"g"</td><td>The symbol is in an initialized data section for small objects.Some object file formats permit more efficient access to small dataobjects, such as a global int variable as opposed to a large globalarray.</td></tr><tr><td>"i"</td><td>For PE format files this indicates that the symbol is in asection specific to the implementation of DLLs. For ELF formatfiles this indicates that the symbol is an indirect function. Thisis a GNU extension to the standard set of ELF symbol types. Itindicates a symbol which if referenced by a relocation does notevaluate to its address, but instead must be invoked at runtime.The runtime execution will then return the value to be used in therelocation.</td></tr><tr><td>"N"</td><td>The symbol is a debugging symbol.</td></tr><tr><td>"p"</td><td>The symbols is in a stack unwind section.</td></tr><tr><td>"R"<br>"r"</td><td>The symbol is in a read only data section.</td></tr><tr><td>"S"<br>"s"</td><td>The symbol is in an uninitialized data section for smallobjects.</td></tr><tr><td>"T"<br>"t"</td><td>The symbol is in the text (code) section.</td></tr><tr><td>"U"</td><td>The symbol is undefined.</td></tr><tr><td>"u"</td><td>The symbol is a unique global symbol. This is a GNU extensionto the standard set of ELF symbol bindings. For such a symbol thedynamic linker will make sure that in the entire process there isjust one symbol with this name and type in use.</td></tr><tr><td>"V"<br>"v"</td><td>The symbol is a weak object. When a weak defined symbol islinked with a normal defined symbol, the normal defined symbol isused with no error. When a weak undefined symbol is linked and thesymbol is not defined, the value of the weak symbol becomes zerowith no error. On some systems, uppercase indicates that a defaultvalue has been specified.</td></tr><tr><td>"W"<br>"w"</td><td>The symbol is a weak symbol that has not been specificallytagged as a weak object symbol. When a weak defined symbol islinked with a normal defined symbol, the normal defined symbol isused with no error. When a weak undefined symbol is linked and thesymbol is not defined, the value of the symbol is determined in asystem-specific manner without error. On some systems, uppercaseindicates that a default value has been specified.</td></tr><tr><td>"-"</td><td>The symbol is a stabs symbol in an a.out object file. In thiscase, the next values printed are the stabs other field, the stabsdesc field, and the stab type. Stabs symbols are used to holddebugging information.</td></tr><tr><td>"?"</td><td>The symbol type is unknown, or object file formatspecific.</td></tr></tbody></table>