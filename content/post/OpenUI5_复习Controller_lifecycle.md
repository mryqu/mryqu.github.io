---
title: '[OpenUI5] 复习Controller lifecycle'
date: 2016-05-27 05:36:54
categories: 
- FrontEnd
tags: 
- openui5
- controller
- lifecycle
- javascript
- mvc
---
昨天看到有同事添加了几个Controller的回调，对其中的onBeforeExit、beforeExit没一点印象。
```
sap.ui.controller("kx123.foo", {
    onInit: function () {
        console.info("foo onInit called");
    },
    onBeforeExit: function(){
          console.info("foo onBeforeExit called") ;
    } ,
    beforeExit: function() {
         console.info("foo beforeExit called") ;
    },
    onBeforeRendering: function() {
        console.info("foo onBeforeRendering called");
    },
    onExit: function() {
        console.info("foo onExit called");
    }
});
```
查了一下如下OpenUI5开发指南 [MVC](https://sapui5.hana.ondemand.com/#docs/guide/MVC.html)中关于Controllers的介绍。
> SAPUI5 provides predefined lifecycle hooks forimplementation. You can add event handlers or other functions tothe controller and the controller can fire events, for which othercontrollers or entities can register.
> SAPUI5 provides the following lifecyclehooks:
> - onInit(): Called when a view is instantiated and its controls(if available) have already been created; used to modify the viewbefore it is displayed to bind event handlers and do other one-timeinitialization
> - onExit(): Called when the view is destroyed; used to freeresources and finalize activities
> - onAfterRendering(): Called when the view has been rendered and,therefore, its HTML is part of the document; used to dopost-rendering manipulations of theHTML. SAPUI5 controls get thishook after being rendered.
> - onBeforeRendering(): Invoked before the controller view isre-renderedand **not** beforethe first rendering;use onInit() for invoking thehook before the first rendering

看来sap.ui.controller确实不存在onBeforeExit、beforeExit回调。倒是sap.ui.core.mvc.View有beforeExit事件，它跟sap.ui.controller的onExit回调是捆一起的。
