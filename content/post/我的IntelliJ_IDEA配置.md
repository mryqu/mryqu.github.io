---
title: '我的IntelliJ IDEA配置'
date: 2014-11-29 20:19:20
categories: 
- Tool
- IntelliJ
tags: 
- intellij
- idea
- 配置
- 内存
- 代理
---
- 安装完IntelliJIDEA，我首先切换到64位模式：
  安装文件生成的快捷方式默认指向的是idea.exe，更改为idea64.exe。
- 更改默认内存配置：修改IntelliJ"bin"目录下的idea64.exe.vmoptions文件。
  "-Xms"和"-Xmx"定义了Java分配给IntelliJ的最小和最大堆空间，将其更改为"-Xms256m"和"-Xmx1600m"
- 启动IntelliJ IDEA，通过File->Setting菜单做如下修改：
  - 更改编译器的构建过程堆大小为1024![我的IntelliJ IDEA配置](/images/2014/11/0026uWfMgy6S0BD8OdLad.jpg)
  - 设置代理为总动检测![我的IntelliJ IDEA配置](/images/2014/11/0026uWfMgy6S0BF0Dch85.jpg)