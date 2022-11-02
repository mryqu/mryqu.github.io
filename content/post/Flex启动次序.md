---
title: 'Flex启动次序'
date: 2012-07-18 13:28:23
categories: 
- FrontEnd
tags: 
- flex
- 组件
- 容器
- 应用程序
- 启动顺序
---
所有Flex组件在启动过程都会触发一些事件。这些事件指示何时组件首次被创建、在内部进行描绘、在屏幕上进行绘制。这些事件也指示何时组件结束创建，当组件为容器时指示何时子组件被创建。
组件被实例化、加入或链接父组件，之后在容器内确定大小并布局。组件创建顺序如下：
下例展示了组件创建生命期内分发的一些重要事件：
![Major events dispatched during a component's creation life cycle.](http://help.adobe.com/en_US/flex/using/images/lifecycle_component.png)
容器和组件的创建顺序是不同的，因为容器可为其他组件的父组件。容器内的组件也必须经历创建顺序。如果一个容器是另一个容器的父组件，内部容器的子组件也必须经历创建顺序。
下例展示了容器创建生命期内分发的一些重要事件：
![Major events dispatched during a container's creation life cycle.](http://help.adobe.com/en_US/flex/using/images/lifecycle_container.png)
当所有组件被创建并在屏幕绘制，[Application](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/spark/componets/Application/html)对象会分发一个<samp>applicationComplete事件。这是程序启动的最后一个被分发的事件。</samp>
multiview容器(navigators)的启动顺序与标准容器不同。默认情况下，导航器(navigator)的所有顶级视图会被实例化。然而，Flex仅创建初始可见视图的子组件。当用户切到导航器的其他视图，Flex才会为此视图创建子组件。