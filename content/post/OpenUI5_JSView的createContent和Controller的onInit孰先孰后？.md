---
title: '[OpenUI5] JSView的createContent和Controller的onInit孰先孰后？'
date: 2014-11-14 20:06:02
categories: 
- FrontEnd
tags: 
- openui5
- createcontent
- oninit
- mvc
- javascript
---
首先在这个两个函数设置断点，很容易知道JSView的createContent先于Controller的onInit被调用。
![[OpenUI5] JSView的createContent和Controller的onInit孰先孰后？](/images/2014/11/0026uWfMgy728yWgxibcb.png)![[OpenUI5] JSView的createContent和Controller的onInit孰先孰后？](/images/2014/11/0026uWfMgy728yQ9nq363.png)
通过[sap.ui.core.mvc.View](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/mvc/View.js)源码片段可知，View的_initCompositeSupport函数中首先调用createAndConnectController函数创建Controller,之后调用的onControllerConnected函数会调用createContent函数，最后调用的fireAfterInit函数会触发Controller的onInit函数回调。
```
View.prototype._initCompositeSupport = function(mSettings) {

  // init View with constructor settings
  // (e.g. parse XML or identify default controller)

  // make user specific data available during view instantiation
  this.oViewData = mSettings.viewData;
  // remember the name of this View
  this.sViewName = mSettings.viewName;
  // remember the preprocessors
  this.mPreprocessors = mSettings.preprocessors || {};

  //check if there are custom properties configured for this view, 
  //and only if there are, create a settings preprocessor applying these
  if (sap.ui.core.CustomizingConfiguration && 
      sap.ui.core.CustomizingConfiguration.hasCustomProperties(
                     this.sViewName, this)) {
    var that = this;
    this._fnSettingsPreprocessor = function(mSettings) {
      var sId = this.getId();
      if (sap.ui.core.CustomizingConfiguration && sId) {
        if (that.isPrefixedId(sId)) {
          sId = sId.substring((that.getId() + "--").length);
        }
        var mCustomSettings = sap.ui.core.CustomizingConfiguration.
                  getCustomProperties(that.sViewName, sId, that);
        if (mCustomSettings) {
          // override original property initialization 
          // with customized property values
          mSettings = jQuery.extend(mSettings, mCustomSettings); 
        }
      }
    };
  }

  if (this.initViewSettings) {
    this.initViewSettings(mSettings);
  }

  createAndConnectController(this, mSettings);

  // the controller is connected now => notify the view implementations
  if (this.onControllerConnected) {
    this.onControllerConnected(this.oController);
  }
  
  this._preprocessViewContent();

  // notifies the listeners that the View is initialized
  this.fireAfterInit();

};
```

通过[sap.ui.core.mvc.JSView](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/mvc/JSView.js)源码片段可知，JSView的onControllerConnected函数中会调用createContent函数。
```
JSView.prototype.onControllerConnected = function(oController) {
  var that = this;
  var oPreprocessors = {};
  // when auto prefixing is enabled we add the prefix
  if (this.getAutoPrefixId()) {
    oPreprocessors.id = function(sId) {
      return that.createId(sId);
    };
  }
  oPreprocessors.settings = this._fnSettingsPreprocessor;
  // unset any preprocessors (e.g. from an enclosing JSON view)
  sap.ui.base.ManagedObject.runWithPreprocessors(function() {
    that.applySettings({ content : that.createContent(oController) });
  }, oPreprocessors);
};
```

通过[sap.ui.core.mvc.Controller](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/mvc/Controller.js)源码片段可知，Controller的connectToView方法就是将回调注册到View的生命周期事件监听器上。
```
Controller.prototype.connectToView = function(oView) {
  this.oView = oView;

  if (this.onInit) {
    oView.attachAfterInit(this.onInit, this);
  }
  if (this.onExit) {
    oView.attachBeforeExit(this.onExit, this);
  }
  if (this.onAfterRendering) {
    oView.attachAfterRendering(this.onAfterRendering, this);
  }
  if (this.onBeforeRendering) {
    oView.attachBeforeRendering(this.onBeforeRendering, this);
  }
  //oView.addDelegate(this);
};
```
