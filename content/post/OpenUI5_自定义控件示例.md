---
title: '[OpenUI5] 自定义控件示例'
date: 2015-06-05 05:42:01
categories: 
- 前端
tags: 
- openui5
- custom
- control
- web
- javascript
---
最近在写一个OpenUI5自定义控件，参考了如下文章，搞定。

需要注意的是，控件内的property在init函数内不会获得构造函数的属性值。通过源码可知，EventProvider.extend.constructor内先回调用init函数，然后再调用applySettings将构造函数内的属性设置进去。
```
constructor : function(sId, mSettings, oScope) {

  EventProvider.call(this); // no use to pass our arguments
  if (typeof (sId) != "string" && arguments.length > 0) {
    // shift arguments in case sId was missing, but mSettings was given
    oScope = mSettings;
    mSettings = sId;
    if (mSettings && mSettings.id) {
      sId = mSettings["id"];
    } else {
      sId = null;
    }
  }

  if (!sId) {
    sId = this.getMetadata().uid() || jQuery.sap.uid();
  } else {
    var preprocessor = ManagedObject._fnIdPreprocessor;
    sId = (preprocessor ? preprocessor.call(this, sId) : sId);
    var oType = DataType.getType("sap.ui.core.ID");
    if (!oType.isValid(sId)) {
      throw new Error("\"" + sId + "\" is not a valid ID.");
    }
  }
  this.sId = sId;

  // managed object interface
  // create an empty property bag that uses a map of 
  // defaultValues as its prototype
  this.mProperties = this.getMetadata().createPropertyBag();
  this.mAggregations = {};
  this.mAssociations = {};
  this.mMethods = {};
  
  // private properties
  this.oParent = null;

  this.aDelegates = [];
  this.aBeforeDelegates = [];
  this.iSuppressInvalidate = 0;
  this.oPropagatedProperties = {oModels:{}, oBindingContexts:{}};
  this.mSkipPropagation = {};

  // data binding
  this.oModels = {};
  this.oBindingContexts = {};
  this.mElementBindingContexts = {};
  this.mBindingInfos = {};
  this.sBindingPath = null;
  this.mBindingParameters = null;
  this.mBoundObjects = {};

  // apply the owner id if defined
  this._sOwnerId = ManagedObject._sOwnerId;

  // make sure that the object is registered before initializing
  // and to deregister the object in case of errors
  try {

    // registers the object in the Core
    if (this.register) {
      this.register();
    }

    // TODO: generic concept for init hooks?
    if ( this._initCompositeSupport ) {
      this._initCompositeSupport(mSettings);
    }

    // Call init method here instead of specific Controls constructor.
    if (this.init) {
      this.init();
    }   
```

### 参考

[How to Create a Custom Control Using SAPUI5 Framework](http://www.skybuffer.com/blog/9/)  
[How to create custom control from scratch](http://scn.sap.com/community/developer-center/front-end/blog/2014/02/11/how-to-create-custom-control-from-scratch)  
[Creating Custom Controls in SAPUI5](https://www.nabisoft.com/tutorials/sapui5/creating-custom-controls-in-sapui5)  
[Custom controls for SAPUI5/OpenUI5](http://rayell.github.io/openui5-custom/)  