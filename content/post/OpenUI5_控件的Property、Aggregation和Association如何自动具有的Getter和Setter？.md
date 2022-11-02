---
title: '[OpenUI5] 控件的Property、Aggregation和Association如何自动具有的Getter和Setter？'
date: 2015-11-13 06:04:43
categories: 
- FrontEnd
tags: 
- openui5
- control
- property
- getter
- setter
---
定义了OpenUI5控件的Property、Aggregation、Association和Event后，该控件就会出现这些Property、Aggregation和Association的Getter和Setter，是什么机制自动生成的这些Getter和Setter的？

OpenUI5控件都继承自sap.ui.core.Control，其父类为sap.ui.core.Element，在祖父类为[sap.ui.base.ManagedObject](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObject.js)。[sap.ui.base.ManagedObject](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObject.js)类定义了Properties、Aggregations、Associations和Events这些管理特性。

Getter和Setter的生成机制都在[sap.ui.core.ManagedObjectMetadata](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObjectMetadata.js)中实现的。首先我们看一下[sap.ui.core.ManagedObjectMetadata](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObjectMetadata.js)这个类的源代码片段：
```
ManagedObjectMetadata.prototype.generateAccessors = function() {

  var proto = this.getClass().prototype,
    prefix = this.getName() + ".",
    methods = this._aPublicMethods,
    n;

  function add(name, fn, info) {
    if ( !proto[name] ) {
      proto[name] = (info && info.deprecated) ? deprecation(fn, prefix + info.name) : fn;
    }
    methods.push(name);
  }

  for (n in this._mProperties) {
    this._mProperties[n].generate(add);
  }
  for (n in this._mAggregations) {
    this._mAggregations[n].generate(add);
  }
  for (n in this._mAssociations) {
    this._mAssociations[n].generate(add);
  }
  for (n in this._mEvents) {
    this._mEvents[n].generate(add);
  }
};

function Property(oClass, name, info) {
  info = typeof info !== 'object' ? { type: info } : info;
  this.name = name;
  this.type = info.type || 'string';
  this.group = info.group || 'Misc';
  this.defaultValue = info.defaultValue !== null ? info.defaultValue : null;
  this.bindable = !!info.bindable;
  this.deprecated = !!info.deprecated || false;
  this.visibility = 'public';
  this.appData = remainder(this, info);
  this._oParent = oClass;
  this._sUID = name;
  this._iKind = Kind.PROPERTY;
  var N = capitalize(name);
  this._sMutator = 'set' + N;
  this._sGetter = 'get' + N;
  if ( this.bindable ) {
    this._sBind =  'bind' + N;
    this._sUnbind = 'unbind' + N;
  } else {
    this._sBind =
    this._sUnbind = undefined;
  }
  this._oType = null;
}

Property.prototype.generate = function(add) {
  var that = this,
    n = that.name;

  add(that._sGetter, function() { return this.getProperty(n); });
  add(that._sMutator, function(v) { this.setProperty(n,v); return this; }, that);
  if ( that.bindable ) {
    add(that._sBind, function(p,fn,m) { this.bindProperty(n,p,fn,m); return this; }, that);
    add(that._sUnbind, function(p) { this.unbindProperty(n,p); return this; });
  }
};
```

Property类在构造时会甚至_sMutator为set+'propName'，_sGetter为get+'propName'；Property的generate方法会通过ManagedObjectMetadata里面的add函数将Property的_sMutator和_sGetter添加到属性的PublicMethods数组中，因此会自动出现属性的Getter和Setter方法。

基于类似的方式得到下面的汇总表：

|控件元数据|自动生成的部分方法
|-----
|Property|_sMutator：set+'propName'_sGetter：get+'propName'
|Aggregation（multiple="false"）|_sMutator：set+'aggrName'_sGetter：get+'aggrName'
|Aggregation（multiple="true"）|_sMutator：add+'aggrName'_sGetter：get+'aggrName'_sInsertMutator：insert+'aggrName'_sRemoveMutator：remove+'aggrName'_sRemoveAllMutator：removeAll+'aggrName'_sIndexGetter：indexOf+'aggrName'
|Association（multiple="false"）|_sMutator：set+'assoName'_sGetter：get+'assoName'
|Association（multiple="true"）|_sMutator：add+'assoName'_sGetter：get+'assoName'_sRemoveMutator：remove+'assoName'_sRemoveAllMutator：removeAll+'assoName'
|Event|_sMutator：attach+'eventName'_sDetachMutator：detach+'eventName'_sTrigger：fire+'eventName'


最后展示控件从开始构造到产生属性的函数栈：
![[OpenUI5] 控件的Property、Aggregation和Association如何自动具有的Getter和Setter？](/images/2015/11/0026uWfMgy724nxRWPwea.png)
[ sap.ui.base.ManagedObject](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObject.js)在构造时会创建运行时的元数据，从而驱动Property、Aggregation、Association和Event的Getter和Setter的生成。
