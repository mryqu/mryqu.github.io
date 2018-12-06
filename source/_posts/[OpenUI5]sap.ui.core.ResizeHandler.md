---
title: '[OpenUI5] sap.ui.core.ResizeHandler'
date: 2015-06-14 09:10:23
categories: 
- 前端
tags: 
- openui5
- resize
- handler
- javascript
- html5
---
OpenUI5里窗口大小放生变化，各个控件如何收到通知跟着相应变化的呢？

### [ sap.ui.core.Core](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/Core.js)

首先我们看一下[sap.ui.core.Core](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/Core.js)的源代码：
```
Core._I_INTERVAL = 200;
ResizeHandler.prototype.I_INTERVAL = Core._I_INTERVAL;

Core.prototype.attachIntervalTimer = function(fnFunction, oListener) {
  if (!this.oTimedTrigger) {
    var IntervalTrigger = sap.ui.requireSync("sap/ui/core/IntervalTrigger");
    this.oTimedTrigger = new IntervalTrigger(Core._I_INTERVAL);
  }
  this.oTimedTrigger.addListener(fnFunction, oListener);
};

```

[ sap.ui.core.Core](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/Core.js)里面会起一个定时器，以200毫秒间隔周期触发。

### [ sap.ui.core.ResizeHandler](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/ResizeHandler.js)

接下来我们看一下[sap.ui.core.ResizeHandler](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/ResizeHandler.js)的源代码：
```
function initListener(){
  if (!this.bRegistered && this.aResizeListeners.length > 0) {
    this.bRegistered = true;
    sap.ui.getCore().attachIntervalTimer(this.checkSizes, this);
  }
}

ResizeHandler.prototype.checkSizes = function() {
  var bDebug = log.isLoggable();
  if ( bDebug ) {
    log.debug("checkSizes:");
  }
  jQuery.each(this.aResizeListeners, function(index, oResizeListener){
    if (oResizeListener) {
      var bCtrl = !!oResizeListener.oControl,
        oDomRef = bCtrl ? 
           oResizeListener.oControl.getDomRef() : oResizeListener.oDomRef;

      if ( oDomRef && jQuery.contains(document.documentElement, oDomRef)) { 
        //check that domref is still active

        var iOldWidth = oResizeListener.iWidth,
          iOldHeight = oResizeListener.iHeight,
          iNewWidth = oDomRef.offsetWidth,
          iNewHeight = oDomRef.offsetHeight;

        if (iOldWidth != iNewWidth || iOldHeight != iNewHeight) {
          oResizeListener.iWidth = iNewWidth;
          oResizeListener.iHeight = iNewHeight;

          var oEvent = jQuery.Event("resize");
          oEvent.target = oDomRef;
          oEvent.currentTarget = oDomRef;
          oEvent.size = {width: iNewWidth, height: iNewHeight};
          oEvent.oldSize = {width: iOldWidth, height: iOldHeight};
          oEvent.control = bCtrl ? oResizeListener.oControl : null;

          if ( bDebug ) {
            log.debug("resize detected for '" + oResizeListener.dbg +
                       "': " + oEvent.oldSize.width + "x" +
                       oEvent.oldSize.height + " -> " + 
                       oEvent.size.width + "x" + oEvent.size.height);
          }

          oResizeListener.fHandler(oEvent);
        }

      }
    }
  });

  if (ResizeHandler._keepActive != true && ResizeHandler._keepActive != false) {
    //initialize default
    ResizeHandler._keepActive = false;
  }

  if (!jQuery.sap.act.isActive() && !ResizeHandler._keepActive) {
    clearListener.apply(this);
  }
};

```

[ sap.ui.core.ResizeHandler](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/ResizeHandler.js)监听上一定时器触发事件，执行自己的checkSizes函数。checkSizes函数遍历向自己注册的所有Resize监听器，查看其元素Dom引用是否在窗口内且大小改变，则执行该Resize监听器的fHandler回调处理resize事件。

### 元素对resize事件的处理

最后我以[sap.m.Dialog](https://github.com/SAP/openui5/blob/master/src/sap.m/src/sap/m/Dialog.js)为例，看一下元素对resize事件的处理。

在Dialog.prototype.open里执行了_registerResizeHandler函数，其注册了_onResize回调用于处理resize事件；在Dialog.prototype.close里执行了_deregisterContentResizeHandler函数。
```
Dialog.prototype._onResize = function () {
  var $dialog = this.$(),
    $dialogContent = this.$('cont');

  //if height is set by manually resizing return;
  if (this._oManuallySetSize) {
    return;
  }

  if (!this.getContentHeight()) {
    //reset the height so the dialog can grow
    $dialogContent.css({
      height: 'auto'
    });

    //set the newly calculated size by getting it
    //from the browser rendered layout - by the max-height
    $dialogContent.height(parseInt($dialog.height(), 10));
  }

  if (this.getStretch() || this._bDisableRepositioning) {
    return;
  }

  this._applyCustomTranslate();
};
```
