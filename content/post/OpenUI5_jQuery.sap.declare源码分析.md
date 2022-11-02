---
title: '[OpenUI5] jQuery.sap.declare源码分析'
date: 2015-08-23 00:03:20
categories: 
- FrontEnd
tags: 
- openui5
- jquery.sap.declare
- javascript
- modularization
---
jQuery.sap.declare用于宣称一个模块已存在。

在OpenUI5开发指南--精粹--优化应用--模块化和依赖管理中对declare介绍是:

> Modules can declare themselves by calling the static `jQuery.sap.declare` functionwith their name. This helpsSAPUI5tocheck at runtime whether a loaded module contains the expectedcontent by comparing the required name against the declared name.As a side effect,`jQuery.sap.declare` ensures that the parent namespace of the module name exists in the currentglobal namespace (window).Formore information, see [jQuery.sap.declare](https://sapui5.hana.ondemand.com/sdk/docs/api/symbols/jQuery.sap.html).
> 
> For modules without declaration, the framework assumes that themodule has the expected content and declares it with the name thatwas used for loading. In some cases a module declaration ismandatory, see [Avoiding Duplicates](https://sapui5.hana.ondemand.com/sdk/docs/guide/47e5d26dfca54ce8a4de5882bfd40b18.html).

jQuery.sap.declare函数源码在[jquery.sap.global.js](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/jquery.sap.global.js)，执行时可在sap-ui-core.js中找到。

通过下面的源代码可知，jQuery.sap.delcare首先通过ui5ToRJS将javascript类名转换为js文件名，例如sap.m.Dialog转换为sap/m/Dialog.js，然后执行declareModule函数。declareModule函数查找Core的mModules是否包含该模块且非初始状态，如果不包含该模块则添加模块并直接设为READY状态（说是避免循环？！！），且在_execStack为空时当作bootstrap模块加入_execStack。最后在bCreateNamespace不为false的情况下，执行jQuery.sap.getObject检查类的命名空间是否存在，不存在则创建。例如sap.m.Dialog，如果命名空间不存在的话，则创建window.sap={}，window.sap.m={}。
```
  var sNamespaceObj = sModuleName;

  // check for an object as parameter for sModuleName
  // in case of this the object contains the module name and the type
  // which could be {modName: "sap.ui.core.Dev", type: "view"}
  if (typeof (sModuleName) === "object") {
    sNamespaceObj = sModuleName.modName;
    sModuleName = ui5ToRJS(sModuleName.modName) + 
          (sModuleName.type ? "." + sModuleName.type : "") + ".js";
  } else {
    sModuleName = ui5ToRJS(sModuleName) + ".js";
  }

  declareModule(sModuleName);

  // ensure parent namespace even if module was declared already
  // (as declare might have been called by require)
  if (bCreateNamespace !== false) {
    // ensure parent namespace
    jQuery.sap.getObject(sNamespaceObj, 1);
  }

  return this;
};

function declareModule(sModuleName) {
  var oModule;

  // sModuleName must be a unified resource name of type .js
  jQuery.sap.assert(/\.js$/.test(sModuleName), "must be a Javascript module");

  oModule = mModules[sModuleName] || 
            (mModules[sModuleName] = { state : INITIAL });

  if ( oModule.state > INITIAL ) {
    return oModule;
  }

  if ( log.isLoggable() ) {
    log.debug(sLogPrefix + "declare module '" + sModuleName + "'");
  }

  // avoid cycles
  oModule.state = READY;

  // the first call to declareModule is assumed to identify the bootstrap module
  // Note: this is only a guess and fails e.g. when multiple modules are loaded 
  // via a script tag to make it safe, we could convert 'declare' calls to 
  // e.g. 'subdeclare' calls at build time.
  if ( _execStack.length === 0 ) {
    _execStack.push(sModuleName);
    oModule.url = oModule.url || _sBootstrapUrl;
  }

  return oModule;
}
```

一般在定制控件的js文件中，第一行就是通过jQuery.sap.declare宣称该控件已经存在了。
