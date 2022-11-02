---
title: '[OpenUI5] MVC和EventBus示例'
date: 2015-01-09 12:11:23
categories: 
- FrontEnd
tags: 
- openui5
- mvc
- eventbus
- 消息总线
- 通信
---
昨天发了一个帖子[[OpenUI5] MVC：访问其他View/Controller的方法](/post/openui5_mvc：访问其他view或controller的方法)，里面的示例是用违反MVC原则的方式演示一下效果，今天又在jsbin上做了个OpenUI5MVC & EventBus示例：[http://jsbin.com/nixomo/1/edit?html,output](http://jsbin.com/nixomo/1/edit?html,output)。
[sap.ui.core.EventBus](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.core.EventBus.html)使用起来很简单。

- 通过var bus = sap.ui.getCore().getEventBus() 获得消息总线
- 接收方首先在某个消息通道上订阅消息时间并注册消息监听器listener
- 发送方在这个消息通道上发布消息，接收方就会去处理

![[OpenUI5] MVC和EventBus示例](/images/2015/1/0026uWfMgy6P2x0uJs874.jpg)
通过阅读代码可知，EventBus一个实例对应一个消息通道，EventBus的_defaultChannel和_mChannels都是[sap.ui.base.EventProvider](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.base.EventProvider.html)实例，用于事件注册与分发、将数据与事件的绑定/解绑。上图中就是消息通道"rightViewChannel"对应的EventBus实例，已经注册了两个事件setRightPanelVisible和doSomething。