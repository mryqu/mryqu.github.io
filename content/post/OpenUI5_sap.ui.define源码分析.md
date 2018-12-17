---
title: '[OpenUI5] sap.ui.define源码分析'
date: 2015-08-23 06:35:00
categories: 
- 前端
tags: 
- openui5
- sap.ui.define
- javascript
- modularization
---
jQuery.sap.define通过名字、依赖、模块值或工厂定义一个Javascript模块。

jQuery.sap.define函数源码在[jquery.sap.global.js](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/jquery.sap.global.js)，执行时可在sap-ui-core.js中找到。

通过判断jQuery.sap.define的sModuleName参数类型是否为string类型，获得参数实际对应使用用途，通过移换参数获得真实的sResourceName（js文件路径）、vFactory（模块工厂）、aDependencies（依赖模块）及bExport。

通过[[OpenUI5] jQuery.sap.declare源码分析](/post/openui5_jquery.sap.declare源码分析)里介绍过的declareModule函数宣称当前模块已存在，通过[[OpenUI5] jQuery.sap.require源码分析](/post/openui5_jquery.sap.require源码分析)里介绍过的requireModule函数解析当前模块的每一个依赖。
```
sap.ui.define = function(sModuleName, aDependencies, vFactory, bExport) {
  var sResourceName, i;

  // optional id
  if ( typeof sModuleName === 'string' ) {
    sResourceName = sModuleName + '.js';
  } else {
    // shift parameters
    bExport = vFactory;
    vFactory = aDependencies;
    aDependencies = sModuleName;
    sResourceName = _execStack[_execStack.length - 1];
  }
  
  // convert module name to UI5 module name syntax (might fail!)
  sModuleName = urnToUI5(sResourceName);

  // optional array of dependencies
  if ( !jQuery.isArray(aDependencies) ) {
    // shift parameters
    bExport = vFactory;
    vFactory = aDependencies;
    aDependencies = [];
  } else {
    // resolve relative module names
    var sPackage = sResourceName.slice(0,1 + sResourceName.lastIndexOf('/'));
    for (i = 0; i < aDependencies.length; i++) {
      if ( /^\.\//.test(aDependencies[i]) ) {
        // 2 == length of './' prefix
        aDependencies[i] = sPackage + aDependencies[i].slice(2);
      }
    }
  }

  if ( log.isLoggable() ) {
    log.debug("define(" + sResourceName + ", " + 
              "['" + aDependencies.join("','") + "']" + ")");
  }

  var oModule = declareModule(sResourceName);

  // note: dependencies will be converted from RJS to URN inside requireAll
  requireAll(aDependencies, function(aModules) {

    // factory
    if ( log.isLoggable() ) {
      log.debug("define(" + sResourceName + "): calling factory " +
                 typeof vFactory);
    }

    if ( bExport ) {
      // ensure parent namespace
      jQuery.sap.getObject(sModuleName, 1);
    }

    if ( typeof vFactory === 'function' ) {
      oModule.content = vFactory.apply(window, aModules);
    } else {
      oModule.content = vFactory;
    }

    // HACK: global export
    if ( bExport ) {
      if ( oModule.content == null ) {
        log.error("module '" + sResourceName + 
                  "' returned no content, but should be exported");
      } else {
        if ( log.isLoggable() ) {
          log.debug("exporting content of '" + 
                    sResourceName + "': as global object");
        }
        jQuery.sap.setObject(sModuleName, oModule.content);
      }
    }

  });

};

function requireAll(aDependencies, fnCallback) {

  var aModules = [],
    i, sDepModName;

  for (i = 0; i < aDependencies.length; i++) {
    sDepModName = aDependencies[i];
    log.debug(sLogPrefix + "require '" + sDepModName + "'");
    requireModule(sDepModName + ".js");
    // best guess for legacy modules that don't use sap.ui.define
    // TODO implement fallback for raw modules
    aModules[i] = mModules[sDepModName + ".js"].content || 
                  jQuery.sap.getObject(urnToUI5(sDepModName + ".js"));
    log.debug(sLogPrefix + "require '" + sDepModName + "': done.");
  }

  fnCallback(aModules);
}
```

### 参考

[sap.ui.define jsDoc](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.html#.define)  
[An introduction to sap.ui.define](http://pipetree.com/qmacro/blog/2015/07/an-introduction-to-sap-ui-define/)  
[[OpenUI5] jQuery.sap.require源码分析](/post/openui5_jquery.sap.require源码分析)  
[[OpenUI5] jQuery.sap.declare源码分析](/post/openui5_jquery.sap.declare源码分析)  