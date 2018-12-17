---
title: '了解Activiti Explorer及其Vaadin实现方式'
date: 2015-02-10 16:04:06
categories: 
- workflow
tags: 
- activiti
- explorer
- vaadin
- gwt
- web
---
![了解Activiti Explorer及其Vaadin实现方式](/images/2015/2/0026uWfMgy6PRVScz7nf5.jpg)通过ActivitiModeler架构图可知，Activiti Explorer采用的是[Vaadin](https://vaadin.com/home)框架。
Vaadin 是一种 Java Web 应用程序的开发框架, 其设计目标是便利地创建和维护高质量的 Web UI 应用程序.Vaadin 支持两种不同的开发模式: 服务器端开发和客户端开发. 服务器端开发方式是这二者中更为强大的一种. 它能帮助开发者忘记Web 程序的各种实现细节, 使得 Web 应用程序的开发变得就象过去使用便利的Java开发工具(如AWT, Swing,SWT)来开发桌面应用程序一样, 甚至更简单。
Vaadin 应用程序中基本上所有的逻辑都是运行在服务器端的 Java Servlet API 上的，如下图中Vaadin的运行时结构图所示，Vaadin运行时结构主要由服务器端框架和客户端引擎两部分构成。服务器端框架包含了用来与客户端引擎通讯的服务器端集成层以及一系列的 server端 UI 组件。客户端引擎则由 Google Web toolkit(GWT) 页面渲染模块和客户端集成层两部分组成。
![了解Activiti Explorer及其Vaadin实现方式](/images/2015/2/0026uWfMgy6PRYDN1hP7d.png)
ActivitiExplorer的代码位于Activiti\modules\activiti-explorer下：
![了解Activiti Explorer及其Vaadin实现方式](/images/2015/2/0026uWfMgy6PRZ1wSUga8.jpg)


### 参考资料

[vaadin官方网站](https://vaadin.com/home)    
[book of vaadin 中文版](https://vaadin.com/book/zh/-/page/preface.html)    
[Vaadin - 来自北欧的 Web 应用开发利器，第 1 部分: Vaadin 的基本概况和基础开发](http://www.ibm.com/developerworks/cn/web/1101_wangyc_vaadin1/index.html)    
[Vaadin - 来自北欧的 Web 应用开发利器，第 2 部分: Vaadin 的体系结构和功能扩展](http://www.ibm.com/developerworks/cn/web/1101_wangyc_vaadin2/)    