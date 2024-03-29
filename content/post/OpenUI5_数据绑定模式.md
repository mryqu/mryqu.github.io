---
title: '[OpenUI5] 数据绑定模式'
date: 2015-02-02 00:24:09
categories: 
- FrontEnd
tags: 
- openui5
- data
- binding
- model
- 源代码
---
## OpenUI5数据绑定模式概念

[OpenUI5开发指南-数据绑定模式](https://openui5.hana.ondemand.com/#docs/guide/91f0df546f4d1014b6dd926db0e91070.html)介绍了OpenUI5数据绑定模式概念和不同模型的默认值。

### 绑定模式

绑定模式定义了数据源如何绑定。不同模型实现需要特定绑定模式。例如资源模型仅支持模型到视图的一次性绑定。
SAPUI5提供如下绑定模式：
- 单向绑定：单向绑定意味着模型到视图的绑定；模型中的数据变化将更新相应的绑定和视图。
- 双向绑定：双向绑定意味着模型到视图及视图到模型的绑定；模型/视图中的数据变化将更新相应的绑定和视图/模型。
- 一次性绑定：一次性绑定意味着模型到视图的绑定。

下表展示了不同模型分别支持的绑定模式：

|模型|一次性绑定|双向绑定|单向绑定
|-----
|资源模型|--|--|X
|JSON模型|X|X|X
|XML模型|X|X|X
|OData模型|X|X|X

资源模型仅处理静态文本，所以仅支持一次性绑定模式

#### 模型的默认绑定模式

当模型实例被创建后，该实例具有一个默认绑定模式。该模型实例的所有绑定会采用他们自己默认绑定模式。
下表展示了不同模式实现的默认绑定模式。

|模型|默认绑定模式
|-----
|资源模型|一次性绑定
|JSON模型|双向绑定
|XML模型|双向绑定
|OData模型|单向绑定


## OpenUI5数据绑定模式范例

[OpenUI5开发指南-数据绑定入门](https://openui5.hana.ondemand.com/#docs/guide/91f0f3cd6f4d1014b6dd926db0e91070.html)介绍了数据绑定使用范例。

## OpenUI5数据绑定模式源代码研究

数据绑定模式在sap.ui.model.BindingMode中定义。
![[OpenUI5] 数据绑定模式](/images/2015/2/0026uWfMgy6PGCnacmhf5.jpg)
通过如上类图可知，JSON模型类和XML模型类继承自客户端模型类，资源模型和OData模型直接继承自模型类。
客户端模型具有额外的setData方法。客户端模型相对模型类多了一层客户端数据，可以存储视图属性变化相应的数据，应此能够在不跟服务器端交互的情况下实现双向绑定。网上的很多演示采用客户端模型，就是因为无需搭建服务器，易于实现。
模型类原型有一个checkUpdate方法，用于在模型数据发生变化后，检查模型的所有绑定是否需要更新以实现模型到视图的绑定。其调用情况如下：
- JSON模型和XML模型：被setData和setProperty方法调用
- OData模型：被loadData、setProperty和refresh方法调用
- 资源模型：无调用

视图到模型的绑定，主要在sap.ui.base.ManagedObject类实现。
ManagedObject是所有视图控件的祖宗类，ManagedObject原型的_bindProperty方法判别绑定模式是否是一次性绑定，是的话就将绑定上的事件和模型数据变化处理程序卸载掉。
ManagedObject原型的updateModelProperty方法判别绑定模式是否是双向绑定，是的话就将视图属性变化写入绑定，从而将数据写入模型。

## 参考

[OpenUI5 API参考指南](https://openui5.hana.ondemand.com/#docs/api/symbols/sap.ui.html)  
[sap.ui.model包源代码 - GitHub](https://github.com/SAP/openui5/tree/master/src/sap.ui.core/src/sap/ui/model)  