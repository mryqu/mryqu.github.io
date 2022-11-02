---
title: '[OpenUI5] 折腾了一下JSView转换XMLView'
date: 2017-02-21 05:49:10
categories: 
- FrontEnd
tags: 
- openui5
- javascript
- diagnostics
- jsview
- xmlview
- conversion
---

根据[OpenUI5 Developer Guide - Diagnostics Window](https://openui5.netweaver.ondemand.com/#docs/guide/6ec18e80b0ce47f290bc2645b0cc86e6.html)中的介绍，尝试一下XML View Conversion。  

> Many code samples are written in JavaScript. To facilitate the conversion of these code samples into XML, OpenUI5 provides a generic conversion tool. To run the tool, proceed as follows:
> 1.  Run the OpenUI5 app in your browser, for example, open a page in the test suite.
> 2.  Open the support tool by choosing CTRL+ALT+SHIFT+S.
> 3.  Open the **Control Tree** panel.
> 4.  Select the root UI area in the tree on the left hand side.
> 5.  Open the **Export** tab and choose **Export XML**.
> 6.  Open the ZIP archive and extract the files to your file system.
>
>If your app does **not** contain views, the content is put in one view in the output. If your app contains views and all views are loaded, the content is output as separate files.

采用我之前的博文[[OpenUI5] MVC和EventBus示例](/post/openui5_mvc和eventbus示例)中的示例做一下实验：
首先打开SAPUI5 Diagnostics，在Control Tree中选择一个JSView：![Openui5 Diagnostics](/images/2017/02/Openui5_Diagnostics.png)
看到Export to XML按钮了：![Openui5 Diagnostics ExportToXml](/images/2017/02/Openui5_Diagnostics_ExportToXml.png)
悲剧了，无法导出，说什么p.indexOfContent is not a function：![Openui5 Diagnostics ExportToXml error](/images/2017/02/Openui5_Diagnostics_ExportToXml_Error.png)
一开始怀疑自己的代码不规范，然后尝试很多其他JSView，甚至去转换openui5.hana.ondemand.com中的例子，结果是无一成功。
好吧，现在我开始怀疑SAPUI5这个功能了，可是找不到源码在哪里，最后凭借万能的搜索引擎，查到了[sap.ui.core.support.plugins.ControlTree](https://github.com/frank3b/DemoMaestro/blob/master/resources/sap/ui/core/support/plugins/ControlTree-dbg.js)。
开始用Chrome Dev Tool调试，不用点击按钮就可以触发转换了：![Openui5 Diagnostics ExportToXml debug error](/images/2017/02/Openui5_Diagnostics_ExportToXml_debugError.png)
再进一步替换成如下代码：
```
var o = 
{
"eventId": "sapUiSupportControlTreeRequestControlTreeSerialize",
"params": { controlID:"leftView", sType:"XML"}
};
var s = "SAPUI5SupportTool*" + JSON.stringify(o);
window.sap.ui.core.support.Support.getStub("IFRAME")._oRemoteWindow.postMessage(s, "http://null.jsbin.com");
```
又跳到了[sap.ui.core.support.plugins.ControlTree](https://github.com/frank3b/DemoMaestro/blob/master/resources/sap/ui/core/support/plugins/ControlTree-dbg.js)的onsapUiSupportControlTreeRequestControlTreeSerialize 方法，大致扫了一眼代码：
* OpenUI5元素不限于JSView，如果元素不是sap.ui.core.mvc.View，则会在外边裹一层View  
  ```
  if (oControl instanceof sap.ui.core.mvc.View) {
    oViewSerializer = new ViewSerializer(oControl, window, "sap.m");
  } else {
    var oView = sap.ui.jsview(sType + "ViewExported");
    oView.addContent(oControl);
    oViewSerializer = new ViewSerializer(oView, window, "sap.m");
  }
  ```
* 查找OpenUI5元素的父元素，调用indexOfContent去查看该元素在父元素内的顺序下标，问题就出在这里！！！

[indexOfContent](https://openui5.hana.ondemand.com/#docs/api/symbols/sap.ui.core.mvc.View.html#indexOfContent)方法仅在sap.ui.core.mvc.View及其子类中存在，[sap.ui.core.Control](https://openui5.hana.ondemand.com/#docs/api/symbols/sap.ui.core.Control.html)及[sap.ui.core.Element](https://openui5.hana.ondemand.com/#docs/api/symbols/sap.ui.core.Element.html)并无该方法，所以这个出问题的概率很大呀！
接着又尝试了一下非JSView的元素，点击按钮没反应！
**尝试失败，看来只能寄希望于SAP的改进了！**