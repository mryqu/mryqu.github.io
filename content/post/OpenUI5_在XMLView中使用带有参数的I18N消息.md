---
title: '[OpenUI5] 在XMLView中使用带有参数的I18N消息'
date: 2017-03-01 06:14:39
categories: 
- 前端
tags: 
- openui5
- javascript
- xmlview
- i18n
- parameter
---

在做的一个新项目中，美国团队那边齐刷刷地一色用XMLView而不是JSView，碰到一个小问题：那就是怎么在XMLView中设置带有参数的I18N消息。

参考[Passing parameters to i18n model within XML view](http://stackoverflow.com/questions/27295385/passing-parameters-to-i18n-model-within-xml-view)帖子中的方案，基本搞定：
```
<Input id="myInput" type="Text" required="true" value="{myyquInput}"
 placeholder="{parts:['i18n>myKey.txt', 'myModel>myProp'], formatter: 'jQuery.sap.formatMessage'}"
 change=".handleChangeForMyInput">
  <layoutData>
    <l:GridData span="L6 M8 S9" />
  </layoutData>
</Input>
```

messagebundle.properties：
```
myKey.txt="(Example: {0})"
```
使用[sap.ui.model.CompositeBinding](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/model/CompositeBinding.js)可以通过XMLView中的parts加载多个参数，达到我的目的。缺点就是每个参数只能是model/path组合，或者省略model的path。我没有找到直接输入参数值的便捷方法。
阅读[sap.ui.base.ManagedObject](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/ManagedObject.js)的bindProperty方法可知，它对part中每一元素查找是否有“>”，有则认为是model/path组合，否则即为path。
```
ManagedObject.prototype.bindProperty = 
                 function(sName, oBindingInfo,  _vFormat, _sMode) {
  var iSeparatorPos,
    bAvailable = true,
    oProperty = this.getMetadata().getPropertyLikeSetting(sName);

  // check whether property or alternative type on aggregation exists
  if (!oProperty) {
    throw new Error("Property \"" + sName + "\" does not exist in " + this);
  }

  // old API compatibility (sName, sPath, _vFormat, _sMode)
  if (typeof oBindingInfo == "string") {
    oBindingInfo = {
      parts: [ {
        path: oBindingInfo,
        type: _vFormat instanceof Type ? _vFormat : undefined,
        mode: _sMode
      } ],
      formatter: typeof _vFormat === 'function' ? _vFormat : undefined
    };
  }

  // only one binding object with one binding specified
  if (!oBindingInfo.parts) {
    oBindingInfo.parts = [];
    oBindingInfo.parts[0] = {
      path: oBindingInfo.path,
      targetType: oBindingInfo.targetType,
      type: oBindingInfo.type,
      suspended: oBindingInfo.suspended,
      formatOptions: oBindingInfo.formatOptions,
      constraints: oBindingInfo.constraints,
      model: oBindingInfo.model,
      mode: oBindingInfo.mode
    };
    delete oBindingInfo.path;
    delete oBindingInfo.targetType;
    delete oBindingInfo.mode;
    delete oBindingInfo.model;
  }

  for ( var i = 0; i < oBindingInfo.parts.length; i++ ) {

    var oPart = oBindingInfo.parts[i];
    if (typeof oPart == "string") {
      oPart = { path: oPart };
      oBindingInfo.parts[i] = oPart;
    }

    // if a model separator is found in the path, extract model name and path
    iSeparatorPos = oPart.path.indexOf(">");
    if (iSeparatorPos > 0) {
      oPart.model = oPart.path.substr(0, iSeparatorPos);
      oPart.path = oPart.path.substr(iSeparatorPos + 1);
    }
    // if a formatter exists the binding mode can be one way or one time only
    if (oBindingInfo.formatter && 
        oPart.mode != BindingMode.OneWay && 
        oPart.mode != BindingMode.OneTime) {
      oPart.mode = BindingMode.OneWay;
    }

    if (!this.getModel(oPart.model)) {
      bAvailable = false;
    }

  }

  // if property is already bound, unbind it first
  if (this.isBound(sName)) {
    this.unbindProperty(sName, true);
  }

  // store binding info to create the binding, as soon as the model is available, 
  // or when the model is changed
  this.mBindingInfos[sName] = oBindingInfo;

  // if the models are already available, create the binding
  if (bAvailable) {
    this._bindProperty(sName, oBindingInfo);
  }
  return this;
};
```
