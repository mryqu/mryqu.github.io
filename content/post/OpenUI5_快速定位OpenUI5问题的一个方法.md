---
title: '[OpenUI5] 快速定位OpenUI5问题的一个方法'
date: 2015-01-09 16:30:12
categories: 
- FrontEnd
tags: 
- openui5
- html
- javascript
- debugging
- 杂谈
---
[sap.ui.base.Object](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.base.Object.html)是所有OpenUI5对象的父类，它的某些方法对快速定位OpenUI5问题很有帮助。我写了一个小函数通过OpenUI5对象的元数据获得类名，并且获得OpenUI5对象的ID信息。
```

traceUI5Object: function(obj) {
  if(obj instanceof sap.ui.base.Object)
  
    console.log(obj.getMetadata().getName()+"{id:\'"+obj.getId()+"\'}");
}

traceUI5EventProviders: function(obj) {
  var that = obj;
  while (that && that instanceof sap.ui.base.EventProvider) {
    console.log(that.getMetadata().getName()+"{id:\'"+that.getId()+"\'}");
    that = that.getEventingParent();
  }
}
```

traceUI5EventProviders函数运行结果示例： 
```
sap.ui.commons.CheckBox{id:'check1'}
sap.ui.commons.Panel{id:'panel1'}
sap.ui.core.mvc.JSView{id:'leftView'}
sap.ui.commons.Splitter{id:'Splitter1'}
sap.ui.core.mvc.JSView{id:'__jsview0'}
sap.ui.core.UIArea{id:'content'}
```
在编写和调试OpenUI5时，有时会有Exception抛出。
![[OpenUI5] 快速定位OpenUI5问题的一个方法](/images/2015/1/0026uWfMgy6P2PEiUCUdc.jpg)![[OpenUI5] 快速定位OpenUI5问题的一个方法](/images/2015/1/0026uWfMgy6P2PUDShsfa.png)
假定上面图中代码会抛出Exception，通过this我们看到的的是一个Factory，通过sId我们可以找到发生问题的定义了ID的控件。但是如果控件ID是自生成的，就不太容易了。我们可以通过监视表达式获取（组件链上所有的）组件类名及ID，这样就可以更快定位导致抛出Exception的OpenUI5视图/控件了。

