---
title: '[OpenUI5] MVC：访问其他View/Controller的方法'
date: 2015-01-08 19:42:03
categories: 
- FrontEnd
tags: 
- openui5
- mvc
- controller
- 交互
- 通信
---
### 访问其他视图/控件的方法

在创建视图/控件实例时，设置ID：
```
var oViewLeft = sap.ui.jsview("leftView",
"com.yqu.view.Left");
var oPanelRight = new sap.ui.commons.Panel("panel2");
```

通过sap.ui.getCore().byId("compID")获取上述视图/控件。控制器可以通过getView()函数获取自身对应的视图，但是该视图内部的控件还得通过这种方式获取：
```
var refViewLeft = sap.ui.getCore().byId("leftView");
var refPanelRight = sap.ui.getCore().byId("panel2");
```

需要注意的是，上面讲的是JS视图最简单的一种情况。
对于使用了静态视图ID的XML、HTML和JSON视图，其内部的控件ID会自动添加视图ID做前缀。JS视图中，在动态实例化控件时通过oController.createId("ID")也可以生成用视图ID做前缀的唯一ID。
```
var refSubView = oViewParent.byId("subViewId");
refSubView.byId("ctrId");
```
JS、XML、HTML和JSON片断(Fragment)是更轻量级的分割和UI重用单元，每个片段示例化时为了保证唯一性，即使没有定义片段ID也会自动生成，其内部的控件ID会自动添加视图ID和片段ID做前缀。
- 当没有给定片段ID：myControl = sap.ui.getCore().byId("myControl")
- 当给定片段ID "myFrag" ：myControl =sap.ui.core.Fragment.byId("myFrag", "myControl")

### 访问其他Controller的方法

- 最简单的方法是使用一个全局变量引用所需控制器 **不推荐**
- 通过获取其他控制器对应的视图来访问该控制器的函数：sap.ui.getCore().byId("viewId").getController().method();
- 直接调用控制器的函数：sap.ui.controller("namespace.Controllername").method();
- 最推荐的是在控制器(或应用组件)之间的通信使用sap.ui.core.EventBus，这种事件/消息总线模式可以更好进行解耦。

在jsbin上做了个Retrive other component示例：[http://jsbin.com/xufeyo/1/edit?html,output](http://jsbin.com/xufeyo/1/edit?html,output)
这个示例演示了一个视图如何控制另外一个视图的控件是否显示，一个视图调用了另外一个视图控制器的方法。但是它完全违反了我以前有篇学习帖子[重温MVC:一个很好的MVC](/post/重温mvc一个很好的mvc图)中的规则，不可以在实际工作中使用！

此外通过调试找到了sap.ui.core.Core里面ID与组件的映射表。![[OpenUI5] MVC：访问其他View/Controller的方法](/images/2015/1/0026uWfMgy6P1HuLUmY38.jpg)