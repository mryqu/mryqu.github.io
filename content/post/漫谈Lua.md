---
title: '漫谈Lua'
date: 2015-08-24 05:49:45
categories: 
- Tech
tags: 
- lua
- sas
- scripting
---
![漫谈Lua](/images/2015/8/0026uWfMgy6Vk2ljPeX63)
由于工作需要，最近用了有一段时间Lua了。对于脚本语言，研究生时用过Tcl/Tk做过网络仿真，后来在工作中学过Ruby，不同程度地用过UnixShell、Python、Javascript、Groovy、SAS和R。这里面UnixShell脚本是针对特定操作系统的脚本，SAS和R是用于特定业务领域（统计）的脚本，Javascript现在做Web富客户端是绕不过去的。用于通用领域的脚本中，Python容易上手、成熟、工具库多、资源丰富、文档等支持强大、几乎能做任何事：网络、图形界面、桌面程序、服务器、图形处理、算法等。可是我司将Lua而不是Python集成到SAS9.4中了。我使用它之前对其一无所知。很好奇Lua的历史及特长，是什么让我司对其青睐有加的？

### 何为Lua？

Lua是一门强大、快速、轻量级、可嵌入的脚本语言。Lua结合了简单的程序语法以及基于关联数组和扩展语义的强大数据描述结构。Lua是动态类型语言，通过在基于寄存器的虚拟机上解析字节码进行运行，具有自动内存管理和增量垃圾回收功能，极适于配置、脚本和快速原型开发。

### Lua的历史

Lua在葡萄牙语中指的是“月亮”。Lua由PUC-Rio（巴西的里约热内卢天主教大学）的一个团队设计、实现和维护。Lua由Tecgraf（原先的计算机图形技术组）发明，并作为自由软件发行。现在由LabLua维护。Tecgraf和LabLua是PUC-Rio计算机科学系的两个实验室。
![漫谈Lua](/images/2015/8/0026uWfMgy6VqgGxnUNb5.jpg)Lua发明者：Waldemar, Roberto, Luiz由Ernani d'Almeida拍摄(2011)

|Lua版本|发行时间|Lua版本|发行时间
|-----
|1.0|未公开|3.1|1998/07/11
|1.1|1994/07/08|3.2|1999/07/08
|2.1|1995/02/07|4.0|2000/11/06
|2.2|1995/11/28|5.0|2003/04/11
|2.3|未公开|5.1|2006/02/21
|2.4|1996/03/14|5.2|2011/12/16
|2.5|1996/11/19|5.3|2015/01/12
|3.0|1997/07/01

### Lua优点

- **经过验证的、健壮的语言**：Lua已经被用于很多工业程序中(例如Adobe的PhotoshopLightroom)、嵌入式系统中(例如，用于巴西数字电视的Ginga中间件)和游戏中(例如魔兽和愤怒的小鸟)。Lua是游戏开发中主要的脚本语言。
- **速度快**：许多Benchmark显示Lua是解释性脚本语言中最快的。例如[Lua vs Python3 on X64 Ubuntu](http://benchmarksgame.alioth.debian.org/u64/compare.php?lang=lua&lang2=python3)显示Lua比Python3要快很多。此外，LuaJIT项目提供在目标平台上的即时编译，可以让Lua有更优越的性能。
- **可移植**：Lua以很小的包进行分发，在任何具有标准C编译器的系统上即可开箱即用地进行编译。Lua可在所有Unix发行版和Windows、移动设备、嵌入微处理器和IBM大型机等系统上运行。
- **可嵌入**：Lua以很小的体积提供了一个快速语言引擎，所以易于嵌入到应用中。Lua具有简明、很好文档化的API，允许同其他语言紧密集成。非常易于通过其他语言库扩展Lua，同样其他语言程序也易于用Lua扩展。Lua不仅仅被用于扩展C和C++程序，还有Java、C#、Smalltalk、Fortran、Ada、Erlang、甚至注入Perl和Ruby之类的其他脚本语言。
- **功能强大（但简明）**：Lua设计的一个基本概念是对所实现的功能提供元机制，而不是在语言中直接提供一堆功能。例如，Lua不是一个纯的面向对象语言，但它提供了用于实现类和集成的元机制。Lua的元机制带来概念的简明性并保持语言很小，同时允许语义以非传统的方式进行扩展。
- **体积小**：Lua5.3.1的压缩包包含源代码和文档，体积仅276K，解压缩后为1.1M。源代码包含大约23000行C代码。在64位Linux下，使用所有标准Lua库的Lua解释器占242K，Lua库占414K。
- **免费**：开源，使用非常自由的MIT许可证发布软件。

### 为什么SAS集成Lua？

通过本文所附文章，基本可以判断SAS集成Lua是内部驱动的；
首先Lua有助SAS研发部门完成特定产品的开发工作（特别是新版本的[SAS预报服务器](http://support.sas.com/software/products/forecast/)）。Lua的优雅语法、现代设计和对数据结构的支持，可以让你以新的方式书写SAS程序，克服SAS宏语言的种种不足。SAS中的Lua生态系统有助于提升质量、一致性和重用性，从而以更低的代价获得更高的生产力。

### 参考

[Lua官网](http://www.lua.org/)  
[The History of Lua](http://www.cs.hut.fi/~tlilja/hopl/slides/lua.pdf)  
[Lua 为什么在游戏编程领域被广泛运用？](http://www.zhihu.com/question/21717567)  
[Lua简明教程](http://coolshell.cn/articles/10739.html)  
[Driving SAS® with Lua](http://support.sas.com/resources/papers/proceedings15/SAS1561-2015.pdf)  
[Using Lua within your SAS programs](http://blogs.sas.com/content/sasdummy/2015/08/03/using-lua-within-your-sas-programs/)  
[The implementation of Lua 5.0](http://www.lua.org/doc/jucs05.pdf)  
[The LuaJIT Project](http://luajit.luaforge.net/)  