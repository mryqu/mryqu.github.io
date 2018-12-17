---
title: 'Exuberant Ctags笔记'
date: 2013-10-19 14:46:08
categories: 
- Tool
- C++
tags: 
- exuberant
- ctags
- C++
---
### Ctags简介

Ctags（Generate tag files for sourcecode）产生标记(/索引)文件以帮助在源文件中定位对象。Ctags最初支持C语言，现在已经支持C/C++/Java/JS/Python等41种语言。Vim/Emacs/SublimeText/UltraEdit等编辑器或工具都支持Ctags生成的标记文件。
对于C/C++语言来说，其生成的标记文件tags中包括这些对象的列表：
- 用#define定义的宏
- 枚举型变量的值
- 函数的定义、原型和声明
- 名字空间（namespace）
- 类型定义（typedefs）
- 变量（包括定义和声明）
- 类（class）、结构（struct）、枚举类型（enum）和联合（union）
- 类、结构和联合中成员变量或函数

### 安装

下载[ctags58.zip](http://prdownloads.sourceforge.net/ctags/ctags58.zip)，将其中的ctags.exe解压缩到系统环境变量path包含的路径即可。
![Exuberant Ctags笔记](/images/2013/10/0026uWfMgy6XETkbkcod8.png)

### 使用选项

如果没有指定−−language−force选项，每个源文件的语言基于文件名和语言的映射进行自动选择。该映射可用−−list−maps选项显示，它可能会被−−langmap选项改变。对于操作系统所支持的文件，如果文件名无法映射到某种语言且该文件可被执行，则会对文件第一行检查是为"#!"公认的语言脚本。默认情况下，所有其他文件名都会被忽略。由于仅文件名可匹配某种语言的文件会被扫描，这使得在单个目录对所有文件(例如"ctags*")或对目录树的所有文件(例如"ctags −R")执行ctags成为可能。.h扩展名即用于C++也用于C，所以Ctags将.h映射为C++，这样做不会有不良后果。

- `-R`：等同于--recurse，递归子目录遍历
- `-L`：从文件读取Ctags待处理文件列表并对其执行ctags
   ```
   find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.bld" -o -name "*.blt" > prj.files
   ctags -L prj.files
   ```
- `--list−maps`：显示文件名和语言的映射
  ![Exuberant Ctags笔记](/images/2013/10/0026uWfMgy6XF0sgjTBc3.png)
- `--list−languanges`：显示所有支持的语言
  ![Exuberant Ctags笔记](/images/2013/10/0026uWfMgy6XF0zDJDeec.png)
- `--langmap`：设置文件名和语言的映射
  如果程序中有的.c文件其实是C++程序，这该怎么办？答案是使用ctags --langmap=c++:+.c。![Exuberant Ctags笔记](/images/2013/10/0026uWfMgy6XF2jJyVqb8.png)
- `−−language−force`：强制使用特定语言，而不是通过文件名和语言的映射进行自动选择
  像C++标准库stl中文件名没有后缀，怎么办？ 使用ctags−−language−force=C++这样就把所有文件当成C++来处理了。
- `−−fields`：指定标记文件中条目的可用扩展字段（没有指明的默认关闭）
  <table rules="none" frame="void" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td width="2%"><p style="margin-top: 1em" valign="top"><i>a</i></p></td><td width="71%"><p style="margin-top: 1em" valign="top">类成员的访问属性</p></td></tr><tr><td width="2%"><p valign="top"><i>f</i></p></td><td width="71%"><p valign="top">文件限制范围 [enabled]</p></td></tr><tr><td width="2%"><p valign="top"><i>i</i></p></td><td width="71%"><p valign="top">继承信息</p></td></tr><tr><td width="2%"><p valign="top"><i>k</i></p></td><td width="71%"><p valign="top">单字符形式的标记类型 [enabled]</p></td></tr><tr><td width="2%"><p valign="top"><i>K</i></p></td><td width="71%"><p valign="top">全名称形式的标记类型</p></td></tr><tr><td width="2%"><p valign="top"><i>l</i></p></td><td width="71%"><p valign="top">包含该标记的源文件语言</p></td></tr><tr><td width="2%"><p valign="top"><i>m</i></p></td><td width="71%"><p valign="top">实现信息</p></td></tr><tr><td width="2%"><p valign="top"><i>n</i></p></td><td width="71%"><p valign="top">标记定义行号</p></td></tr><tr><td width="2%"><p valign="top"><i>s</i></p></td><td width="71%"><p valign="top">标记定义范围 [enabled]</p></td></tr><tr><td width="2%"><p valign="top"><i>S</i></p></td><td width="71%"><p valign="top">函数签名（例如原型或参数类表）</p></td></tr><tr><td width="2%"><p valign="top"><i>z</i></p></td><td width="71%"><p valign="top">包含kind字段中包含"kind:"的关键字</p></td></tr><tr><td width="2%"><p valign="top"><i>t</i></p></td><td width="71%"><p valign="top">变量的类型和名称，或typedef的"typeref:"字段。 [enabled]</p></td></tr></tbody></table>
- `--{language}-kinds`：指定输出中需包含的特定语言标记列表
  使用ctags --list-kinds=c++可以查看选项：
  <table rules="none" frame="void" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td width="2%"><p style="margin-top: 1em" valign="top"><i>c</i></p></td><td width="71%"><p style="margin-top: 1em" valign="top">classes</p></td></tr><tr><td width="2%"><p valign="top"><i>d</i></p></td><td width="71%"><p valign="top">macro definitions</p></td></tr><tr><td width="2%"><p valign="top"><i>e</i></p></td><td width="71%"><p valign="top">enumerators (values inside an enumeration)</p></td></tr><tr><td width="2%"><p valign="top"><i>f</i></p></td><td width="71%"><p valign="top">function definitions</p></td></tr><tr><td width="2%"><p valign="top"><i>g</i></p></td><td width="71%"><p valign="top">enumeration names</p></td></tr><tr><td width="2%"><p valign="top"><i>l</i></p></td><td width="71%"><p valign="top">local variables [off]</p></td></tr><tr><td width="2%"><p valign="top"><i>m</i></p></td><td width="71%"><p valign="top">class, struct, and union members</p></td></tr><tr><td width="2%"><p valign="top"><i>n</i></p></td><td width="71%"><p valign="top">namespaces</p></td></tr><tr><td width="2%"><p valign="top"><i>p</i></p></td><td width="71%"><p valign="top">function prototypes [off]</p></td></tr><tr><td width="2%"><p valign="top"><i>s</i></p></td><td width="71%"><p valign="top">structure names</p></td></tr><tr><td width="2%"><p valign="top"><i>t</i></p></td><td width="71%"><p valign="top">typedefs</p></td></tr><tr><td width="2%"><p valign="top"><i>u</i></p></td><td width="71%"><p valign="top">union names</p></td></tr><tr><td width="2%"><p valign="top"><i>v</i></p></td><td width="71%"><p valign="top">variable definitions</p></td></tr><tr><td width="2%"><p valign="top"><i>x</i></p></td><td width="71%"><p valign="top">external and forward variable declarations[off]</p></td></tr></tbody></table>
- `--extra`：用于增加额外的标记条目
  <table rules="none" frame="void" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td width="2%"><p style="margin-top: 1em" valign="top"><i>f</i></p></td><td width="71%"><p style="margin-top: 1em" valign="top">为每个源文件包含一个用于基本文件名(除去路径的文件名，例如"example.c")的条目，用于定位文件首行。</p></td></tr><tr><td width="2%"><p valign="top"><i>q</i></p></td><td width="71%"><p valign="top">（对C++、Eiffel和Java这些支持全类名语言）为类成员标记包含一个额外的全类名条目，其形式取决于特定语言。对于C++，形式为"class::member"；对于Eiffel和Java，形式为"class.member"。</p></td></tr></tbody></table>

OmniCppComplete 提供的ctags生成语句示例：
```
ctags -R –c++-kinds=+px –fields=+iaS –extra=+q . 
```

### 通过Vim使用标记文件

|命令|介绍
|---
|vi -t tag|启动Vim并定位到标记所定义的文件和代码行上。
|:ta tag|查找一个标记。
|Ctrl-]|跳到光标所在函数或者结构体的定义处。
|Ctrl-T|返回到跳转标记之前的位置。
|:ts|:tselect, 列出一个列表供用户选标记。
|:tp|:tprevious，上一个tag标记文件。
|:tn|:tnext，下一个tag标记文件。
|:tfirst|第一个tag标记文件。
|:tlast|最后一个tag标记文件。

### Ctags局限性

Ctags生成的标记文件包含了类、函数和变量等的定义信息，而没有包含使用信息。如果要知道一个函数都在什么地方使用过，需要使用cscope工具。

### 参考

[Exuberant Ctags网站](http://ctags.sourceforge.net/)    
[SourceForge：Exuberant Ctags项目](http://sourceforge.net/projects/ctags/)    
[Ctags手册](http://ctags.sourceforge.net/ctags.html)    
[ctags 小记](http://www.cnblogs.com/napoleon_liu/archive/2011/01/23/1942738.html)    