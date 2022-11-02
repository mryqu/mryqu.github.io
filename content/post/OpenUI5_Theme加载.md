---
title: '[OpenUI5] Theme加载'
date: 2017-12-28 05:37:36
categories: 
- FrontEnd
tags: 
- openui5
- javascript
- html
- theme
- loading
---
瞄了一下OpenUI5中UI主题加载，关键点在sap.ui.core.Core.includeLibraryTheme方法。其调用者主要为：
- sap.ui.core.Core._boot：启动OpenUI5核心时加载必要的主题 
- sap.ui.core.Core.initLibrary：加载某个库时会尝试加载其主题 
假定config.js内容如下：
```
window['sap-ui-config'] = {
    bindingSyntax: 'complex',
    modules: [
        "sap.m.library",
        "sap.ui.commons.library",
        "sap.ui.table.library",
        "sap.ui.layout.library",
        "yqu.ui.kexiao.library"        
        ]
    }
};
```
OpenUI5在加载yqu.ui.kexiao.library库时会尝试加载其主题。
```
Core.includeLibraryTheme (Core.js?eval:xxxx)
Core.initLibrary (Core.js?eval:xxxx)
(anonymous) (Interface.js?eval:xx)
(anonymous) (library.js?eval:xx)
evalModuleStr (sap-ui-core-dbg.js:xxxxx)
execModule (sap-ui-core-dbg.js:xxxxx)
requireModule (sap-ui-core-dbg.js:xxxxx)
jQuery.sap.require (sap-ui-core-dbg.js:xxxxx)
Core.loadLibrary (Core.js?eval:xxxx)
.............
```