---
title: '[IntelliJ] 与Eclipse关于Call Hierarchy和Find Reference功能比较'
date: 2014-12-11 19:46:23
categories: 
- Tool
- IntelliJ
tags: 
- eclispe
- intellij_idea
- call_hierarchy
- find_reference
- analyze_data_flow
---
### "Call Hierarchy"功能比较

Eclipse的"CallHierarchy"可以查看一个Java方法或类成员变量的调用树（caller和callee两个方向）。
IntelliJ IDEA中可以在主菜单中选择Navigate | CallHierarchy命令查看一个Java方法调用树（caller和callee两个方向），但是不像Eclipse那样可以查看类成员变量的调用树。
IntelliJ IDEA中可以在主菜单中选择Analyze | Dataflow from/toHere两个命令查看表达式、变量和方法参数的传递关系树。
Eclipse的"Call Hierarchy"命令的功能，在IntelliJIDEA中被划分到了三个命令，增加了一点点记忆成本，不过IntelliJ IDEA中的处理范围更广，相对功能更强一些。

### "Find Reference"功能比较

Eclipse的"Find Reference"可以查看一个Java类、方法或变量的直接使用情况。
IntelliJ IDEA的"Find Usage"具有相同的功能。在我的体验中，IntelliJIDEA中的功能更强一些，可以分析Sping配置文件中对Java类或方法的使用情况。

### 参考
[https://www.jetbrains.com/idea/help/building-call-hierarchy.html](https://www.jetbrains.com/idea/help/building-call-hierarchy.html)  
[https://www.jetbrains.com/idea/help/analyzing-data-flow.html](https://www.jetbrains.com/idea/help/analyzing-data-flow.html)  
