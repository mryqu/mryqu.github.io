---
title: '[OpenUI5] 加载时替换JavaScript源文件'
date: 2015-08-16 07:22:40
categories: 
- 前端
tags: 
- openui5
- replace
- javascript
- source
- loading
---
我有一些自己定制的OpenUI5控件，有时会修改某个方法内的逻辑，这个好处理，在ChromedevTool直接修改加载后JS代码并保存就可以直接调试。如果修改了property、aggregation或者init方法内的逻辑的话，由于错过了初始化就不灵了，而重新加载的话又丢失了自己新加的调试代码。

我的解决方法如下：
- 清除Chrome缓存
- 在sap-ui-core-dbg.js里requireModule方法内设置断点，设置断点条件为response.indexOf("Dialog.extend(\"mryqu.test.control.KexiaoDialog")>0![[OpenUI5] 加载时替换Javascript源文件](/images/2015/8/0026uWfMzy77eqSpSzId6.png)这样当OpenUI5加载KexiaoDialog.js文件时就会触发断点。
- 重新加载我的OpenUI5项目：http://www.mryqu.com/test123/?sap-ui-debug=true&sap-ui-preload=false
- 当断点被触发时，在Console执行：
   ```
   response='(function ()\n\
   {\n\
     "use strict";\n\
   \n\
     jQuery.sap.require("sap.m.Button");\n\
     jQuery.sap.require("sap.m.Dialog");\n\
     jQuery.sap.require("sap.m.HBox");\n\
     jQuery.sap.require("sap.m.Input");\n\
     jQuery.sap.require("sap.m.RadioButton");\n\
     jQuery.sap.require("sap.m.VBox");\n\
     jQuery.sap.require("sap.m.Text");\n\
   \n\
     var Button = sap.m.Button;\n\
     var Dialog = sap.m.Dialog;\n\
     var HBox = sap.m.HBox;\n\
     var Icon = sap.ui.core.Icon;\n\
     var Input = sap.m.Input;\n\
     var RadioButton = sap.m.RadioButton;\n\
     var Text = sap.m.Text;\n\
     var VBox = sap.m.VBox;\n\
   \n\
     Dialog.extend("mryqu.test.control.KexiaoDialog", {\n\
       metadata: {\n\
         properties: {\n\
           "tableName" : {type : "string", defaultValue : ""},\n\
         },\n\
         associations: {\n\
           invoker: {type: "sap.ui.core.Control", multiple: false}\n\
         }\n\
       },\n\
   \n\
       renderer: "sap.m.DialogRenderer",\n\
   .............
   .............
       exit: function() {\n\
         if(Dialog.prototype.exit)\n\
           Dialog.prototype.exit.apply(this, arguments);\n\
       },\n\
   \n\
       _onAfterClose: function(evt) {\n\
         this.destroy();\n\
       }\n\
     });\n\
   }());';
   ```
response中字符串是控件的新代码。有两点注意事项：
1. 如果源文件包含'，则需要使用\'转义；
2. 对源文件中的换行使用\n\。

这样就可以轻轻松松地从起始点替换掉一个Javascript文件，可以开心玩耍了。