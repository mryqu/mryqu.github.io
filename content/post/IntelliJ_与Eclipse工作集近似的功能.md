---
title: '[IntelliJ] 与Eclipse工作集近似的功能'
date: 2014-12-13 12:02:21
categories: 
- Tool
- IntelliJ
tags: 
- eclipse
- intellij
- idea
- workset
- modulegroup
---
Eclipse鼓励将不同的功能模块划分为独立的项目存在，这样不但结构清晰，组织起来还非常灵活，因为我们可以用feature对这些项目进行不同的组合，输出后得到具有不同功能的产品。
不过这样一来项目浏览器里的项目会以更快的速度增加，当你面对几十上百个项目时，工作效率必然大打折扣。幸好Eclipse提供了工作集（WorkingSet）的功能，它可以用来对项目进行分组，并且可以项目浏览器里指定显示所有项目或者特定工作集下的项目。
具体操作可以参考Eclipse帮助文档[工作集概念](http://help.eclipse.org/juno/index.jsp?topic=/org.eclipse.platform.doc.user/concepts/cworkset.htm)和[项目浏览器显示/隐藏文件](http://help.eclipse.org/luna/index.jsp?topic=/org.eclipse.platform.doc.user/tasks/tasks-48b.htm)。


IntelliJ IDEA与Eclipse术语对比如下：

|Eclipse|IntelliJ IDEA
|-----
|A number of projects, a workspace|Project
|Project|Module
|Project-specific JRE|Module SDK
|User library|Global library
|Classpath variable|Path variable
|Project dependency|Module dependency
|Library|Module library

由此可知在IntelliJ IDEA中近似功能应该在module一层，就我查找的资料来看最近似的功能就是模块组（modulegroup）了。
具体操作可以参考IntelliJ IDEA帮助文档[对模块分组](https://www.jetbrains.com/idea/help/grouping-modules.html)。Eclipse可选择对某个工作集下的所有项目进行集中编译；同样IntelliJ IDEA也可选择对模块组下的所有模块集中编译。Eclipse可以显示工作空间下所有项目，或仅显示某个工作集下的项目以隐藏其他项目；IntelliJIDEA只能对模块组进行折叠来隐藏其下的模块。这一点两者的行为有一定差异。
