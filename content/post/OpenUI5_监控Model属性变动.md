---
title: '[OpenUI5] 监控Model属性变动'
date: 2019-07-18 06:36:28
categories: 
- FrontEnd
tags: 
- web
- openui5
- model
- listener
- attachChange
---

设计了某个OpenUI5控件，当对控件的某些子控件进行设置时，想监控模型的变动。  
下面的代码完成了这样的功能：  
1. 该控件绑定路径为/someItems/{itemId}/objInfo  
2. 当控件下某些子控件修改设置，则路径为/someItems/{itemId}/objInfo的模型属性会发生变动   
3. 路径为/someItems/{itemId}/isModified的模型属性将被设置为true   
    
```
(function () {
  "use strict";

  ....
  var PATH_PART_OBJINFO = "/objInfo";
  var PATH_PART_ISMODIFIED = "/isModified";

  SomeControl.extend("com.yqu.MySomeControl", {
    metadata: {
      properties: {},
      publicMethods: [],
      events: {}
    },

    rb: sap.ui.getCore().getLibraryResourceBundle("com.yqu"),
    renderer: "SomeControlRenderer",

    init: function() {
      ....
    },

    onBeforeRendering: function() {
      if(SomeControl.prototype.onBeforeRendering)
        SomeControl.prototype.onBeforeRendering.apply(this, arguments);

      ....

      var context = this.getBindingContext();
      if (!!context && !!context.oModel && !!context.sPath) {
        var binding = new sap.ui.model.Binding(context.oModel, "/", context);
        binding.attachChange($.proxy(this._onDataModified, this));
      }
    },

    _onDataModified: function() {
      var context = this.getBindingContext();
      if (!!context && !!context.oModel && !!context.sPath &&
        context.sPath.indexOf(PATH_PART_OBJINFO)>0) {
        var flagPath = context.sPath.replace(PATH_PART_OBJINFO, PATH_PART_ISMODIFIED);
        context.oModel.setProperty(flagPath, true);
      }
    },

    _getText: function(sKey, aArgs, bCustomBundle, bSuppressAssertions) {
      return this.rb.getText(sKey, aArgs, bCustomBundle, bSuppressAssertions);
    },

    exit: function() {
      ....
    }
  });
}());
```