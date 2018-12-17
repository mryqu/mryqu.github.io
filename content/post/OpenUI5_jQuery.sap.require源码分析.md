---
title: '[OpenUI5] jQuery.sap.require源码分析'
date: 2015-08-22 07:32:23
categories: 
- 前端
tags: 
- openui5
- jquery.sap.require
- javascript
- modularization
---
jQuery.sap.require用于解析一个或多个模块依赖。

jQuery.sap.require函数源码在[jquery.sap.global.js](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/jquery.sap.global.js)，执行时可在sap-ui-core.js中找到。

通过下面的源代码可知，jQuery.sap.require首先通过ui5ToRJS将javascript类名转换为js文件名，例如sap.m.Dialog转换为sap/m/Dialog.js，然后执行requireModule函数。

requireModule函数查找该模块在sap.ui.core.Core对象的mModules中是否存在，不存在则添加并设为INITIAL状态，判断模块是否已经被加载、执行过，如果没有则设为LOADING状态并通过ajax以同步方式加载代码（如果当前是debug模式则选择-dbg版本的js文件URL），加载失败设为FAILED状态，加载成功则设为LOADED状态并执行代码，执行失败设为FAILED状态，执行成功设为READY状态。
```
jQuery.sap.require = function(vModuleName, fnCallback) {

  if ( arguments.length > 1 ) {
    // legacy mode with multiple arguments, each representing a dependency
    for (var i = 0; i < arguments.length; i++) {
      jQuery.sap.require(arguments[i]);
    }
    return this;
  }

  // check for an object as parameter for sModuleName
  // in case of this the object contains the module name and the type
  // which could be {modName: "sap.ui.core.Dev", type: "view"}
  if (typeof (vModuleName) === "object") {
    jQuery.sap.assert(!vModuleName.type || 
         jQuery.inArray(vModuleName.type, mKnownSubtypes.js) >= 0, 
         "type must be empty or one of " + mKnownSubtypes.js.join(", "));
    vModuleName = ui5ToRJS(vModuleName.modName) + 
                  (vModuleName.type ? "." + vModuleName.type : "") + ".js";
  } else {
    vModuleName = ui5ToRJS(vModuleName) + ".js";
  }

  requireModule(vModuleName);

  return this; // TODO
};

function ui5ToRJS(sName) {
  if ( /^sap\.ui\.thirdparty\.jquery\.jquery-/.test(sName) ) {
    return "sap/ui/thirdparty/jquery/jquery-" + 
               sName.slice("sap.ui.thirdparty.jquery.jquery-".length);
  } else if ( /^jquery\.sap\./.test(sName) ) {
    return sName;
  }
  return sName.replace(/\./g, "/");
}

function requireModule(sModuleName) {
  var m = rJSSubtypes.exec(sModuleName),
    sBaseName, sType, oModule, aExtensions, i;

  // only for robustness, should not be possible
  // by design (all callers append '.js')
  if ( !m ) {
    log.error("can only require Javascript module, not " + sModuleName);
    return;
  }

  // in case of having a type specified ignore the type for the module path
  // creation and add it as file extension
  sBaseName = sModuleName.slice(0, m.index);
  sType = m[0];      // must be a normalized resource 
                     // name of type .js sType can be empty
                     // or one of view|controller|fragment

  oModule = mModules[sModuleName] || 
            (mModules[sModuleName] = { state : INITIAL });

  if ( log.isLoggable() ) {
    log.debug(sLogPrefix + "require '" + sModuleName +
              "' of type '" + sType + "'");
  }

  // check if module has been loaded already
  if ( oModule.state !== INITIAL ) {
    if ( oModule.state === PRELOADED ) {
      oModule.state = LOADED;
      execModule(sModuleName);
    }

    if ( oModule.state === READY ) {
      if ( log.isLoggable() ) {
        log.debug(sLogPrefix + "module '" + sModuleName +
                  "' has already been loaded (skipped).");
      }
      return this;
    } else if ( oModule.state === FAILED ) {
      throw new Error("found in negative cache: '" + sModuleName +  
                       "' from " + oModule.url + ": " + oModule.error);
    } else {
      // currently loading
      return this;
    }
  }

  // set marker for loading modules (to break cycles)
  oModule.state = LOADING;

  // if debug is enabled, try to load debug module first
  aExtensions = window["sap-ui-loaddbg"] ? ["-dbg", ""] : [""];
  for (i = 0; i < aExtensions.length && oModule.state !== LOADED; i++) {
    // create module URL for the current extension
    oModule.url = getResourcePath(sBaseName, aExtensions[i] + sType);
    if ( log.isLoggable() ) {
      log.debug(sLogPrefix + "loading " + (aExtensions[i] ? aExtensions[i] + 
                " version of " : "") + "'" + sModuleName +
                "' from '" + oModule.url + "'");
    }
    
    jQuery.ajax({
      url : oModule.url,
      dataType : 'text',
      async : false,
      success : function(response, textStatus, xhr) {
        oModule.state = LOADED;
        oModule.data = response;
      },
      error : function(xhr, textStatus, error) {
        oModule.state = FAILED;
        oModule.error = xhr ? xhr.status + " - " + xhr.statusText : textStatus;
      }
    });
    
  }

  // execute module __after__ loading it, this reduces the required stack space!
  if ( oModule.state === LOADED ) {
    execModule(sModuleName);
  }

  if ( oModule.state !== READY ) {
    throw new Error("failed to load '" + sModuleName +  
                     "' from " + oModule.url + ": " + oModule.error);
  }

}

// sModuleName must be a normalized resource name of type .js
function execModule(sModuleName) {

  var oModule = mModules[sModuleName],
    sOldPrefix, sScript, vAMD;

  if ( oModule && oModule.state === LOADED && 
       typeof oModule.data !== "undefined" ) {

    // check whether the module is known to use an existing AMD loader, 
    // remember the AMD flag
    vAMD = mAMDShim[sModuleName] && typeof window.define === "function" &&
           window.define.amd;

    try {

      if ( vAMD ) {
        // temp. remove the AMD Flag from the loader
        delete window.define.amd;
      }

      if ( log.isLoggable() ) {
        log.debug(sLogPrefix + "executing '" + sModuleName + "'");
        sOldPrefix = sLogPrefix;
        sLogPrefix = sLogPrefix + ": ";
      }

      // execute the script in the window context
      oModule.state = EXECUTING;
      _execStack.push(sModuleName);
      if ( typeof oModule.data === "function" ) {
        oModule.data.call(window);
      } else {

        sScript = oModule.data;

        // sourceURL: Firebug, Chrome, Safari and IE11 debugging help, 
        // appending the string seems to cost ZERO performance
        // Note: IE11 supports sourceURL even when running in IE9 or IE10 mode
        // Note: make URL absolute so Chrome displays the file tree correctly
        // Note: do not append if there is already a sourceURL / sourceMappingURL
        if (sScript && !sScript.match(/\/\/[#@] source(Mapping)?URL=.*$/)) {
          sScript += "\n//# sourceURL=" + 
                     URI(oModule.url).absoluteTo(sDocumentLocation);
        }

        // framework internal hook to intercept the loaded script and modify
        // it before executing the script - e.g. useful for client side coverage
        if (typeof jQuery.sap.require._hook === "function") {
          sScript = jQuery.sap.require._hook(sScript, sModuleName);
        }

        if (_window.execScript && (!oModule.data || 
            oModule.data.length < MAX_EXEC_SCRIPT_LENGTH) ) {
          try {
            oModule.data && _window.execScript(sScript); 
            // execScript fails if data is empty
          } catch (e) {
            _execStack.pop();
            // eval again with different approach - 
            // should fail with a more informative exception
            jQuery.sap.globaleval_r(oModule.data);
            throw e; // rethrow err in case globalEval succeeded unexpectedly
          }
        } else {
          _window.eval_r(sScript);
        }
      }
      _execStack.pop();
      oModule.state = READY;
      oModule.data = undefined;
      // best guess for legacy modules that don't use sap.ui.define
      // TODO implement fallback for raw modules
      oModule.content = oModule.content || 
                        jQuery.sap.getObject(urnToUI5(sModuleName));

      if ( log.isLoggable() ) {
        sLogPrefix = sOldPrefix;
        log.debug(sLogPrefix + "finished executing '" + sModuleName + "'");
      }

    } catch (err) {
      oModule.state = FAILED;
      oModule.error = ((err.toString && err.toString()) || err.message) + 
                      (err.line ? "(line " + err.line + ")" : "" );
      oModule.data = undefined;
      if ( window["sap-ui-debug"] && 
           (/sap-ui-xx-show(L|-l)oad(E|-e)rrors=(true|x|X)/.test(location.search) 
            || oCfgData["xx-showloaderrors"]) ) {
        log.error("error while evaluating " + sModuleName + 
         ", embedding again via script tag to enforce a stack trace (see below)");
        jQuery.sap.includeScript(oModule.url);
        return;
      }

    } finally {

      // restore AMD flag
      if ( vAMD ) {
        window.define.amd = vAMD;
      }
    }
  }
}
```

### 参考

[jQuery.sap.require jsDoc](https://openui5.hana.ondemand.com/docs/api/symbols/sap.ui.html#.require)  