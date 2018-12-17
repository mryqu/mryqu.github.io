---
title: '[OpenUI5] 通过sap.ui.core.Core的registerElement和deregisterElement函数监控View和控件的构造和析构'
date: 2015-06-13 21:47:32
categories: 
- 前端
tags: 
- openui5
- core
- registerelement
- deregisterelement
- control
---
在[sap.ui.core.Core](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/Core.js)中有registerElement和deregisterElement函数，它们可用于在调试中监控Element（包括View和控件）的构造和析构。
- **registerElement**：在控件构造时被调用![[OpenUI5] 通过sap.ui.core.Core的registerElement和deregisterElement函数监控View和控件的构造和析构](/images/2015/6/0026uWfMgy725mG9aOx3d.png)
- **deregisterElement**：在控件析构时被调用![[OpenUI5] 通过sap.ui.core.Core的registerElement和deregisterElement函数监控View和控件的构造和析构](/images/2015/6/0026uWfMgy725mHhvhW7c.png)

通过下面的代码可知，Core类的mElements存储着元素Id和元素的散列表：
```
Core.prototype.registerElement = function(oElement) {

  var sId = oElement.getId(),
    oldElement = this.mElements[sId];

  if ( oldElement && oldElement !== oElement ) {
    if ( oldElement._sapui_candidateForDestroy ) {
      jQuery.sap.log.debug("destroying dangling template " + 
                           oldElement + 
                           " when creating new object with same ID");
      oldElement.destroy();
    } else {
      // duplicate ID detected => fail or at least log a warning
      if (this.oConfiguration.getNoDuplicateIds()) {
        jQuery.sap.log.error("adding element with duplicate id '" + sId + "'");
        throw new Error("Error: adding element with duplicate id '" + sId + "'");
      } else {
        jQuery.sap.log.warning("adding element with duplicate id '" + sId + "'");
      }
    }
  }

  this.mElements[sId] = oElement;

};

Core.prototype.deregisterElement = function(oElement) {
  delete this.mElements[oElement.getId()];
};
```

可以通过过如下方法获得所有已注册元素的Id。
```
var keys = $.map(this.mElements, function(v, i){
  return i;
});
```