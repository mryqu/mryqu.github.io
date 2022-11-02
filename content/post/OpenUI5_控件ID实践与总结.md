---
title: '[OpenUI5] 控件ID实践与总结'
date: 2015-05-03 06:53:44
categories: 
- FrontEnd
tags: 
- openui5
- javascript
- control
- id
- practice
---
### 显式定义而不是自生成OpenUI5控件ID

为了便于开发和测试，为控件设置一个便于理解的ID尤为重要。我的博文[《快速定位OpenUI5问题的一个方法》](/post/openui5_快速定位openui5问题的一个方法)中的工具函数就是利用控件ID快速定位故障控件的。
在[OpenUI5](http://sww.sas.com/saspedia/OpenUI5)中，可在创建控件实例时使用JSON对象作为控件构造器参数。其中一个可选属性就是"id"，OpenUI5不仅用它（在"注册信息"中）追踪控件，也用在渲染控件的DOM输出。
如果没有显式指定一个控件的ID，OpenUI5框架就会使用基于实例数量的算法自生成控件ID。
自生成ID有两个缺点：
- 调试的时候，不容易定位使用控件的代码位置。例如，异常跟某个控件相关，如果该类型控件实例很多，很难定位该控件定义在那个视图里。
- 测试代码相对显式定义ID更加难写。如果对控件使用显式定义ID，相应的测试代码可以很容易通过该ID进行控件查找或验证。

### 控件ID命名惯例

使用驼峰式写法、有意义且语法正确的ID来反映控件的本质。
例如：
- 一个表单上的提交按钮，其id="submit"
- 到不同图形设置的导航控件，其id="graphNav"

### OpenUI5控件ID内幕

sap.ui.base.ManagedObject是OpenUI5框架包括控件在内的大部分类的父类，它的构造器里有对ID的处理：
```
if (!sId) {
  sId = this.getMetadata().uid() || jQuery.sap.uid();
} else {
  var preprocessor = ManagedObject._fnIdPreprocessor;
  sId = (preprocessor ? preprocessor.call(this, sId) : sId);
  var oType = DataType.getType("sap.ui.core.ID");
  if (!oType.isValid(sId)) {
    throw new Error("\"" + sId + "\" is not a valid ID.");
  }
}
this.sId = sId;
```

sap.ui.base.ManagedObjectMetadata的ID生成代码：
```
(function() {
  
  var mUIDCounts = {};

  function uid(sId) {
    jQuery.sap.assert(!/[0-9]+$/.exec(sId), "AutoId Prefixes must not end with numbers");

    sId = sap.ui.getCore().getConfiguration().getUIDPrefix() + sId;

    // 初始化计数器
    mUIDCounts[sId] = mUIDCounts[sId] || 0;

    // 组合 前缀+计数器
    // 由于不许sId结尾为数字，因此sId和计数器的连接串是安全的!
    return (sId + mUIDCounts[sId]++);
  }
  
  ManagedObjectMetadata.uid = uid;
  
  ManagedObjectMetadata.prototype.uid = function() {
    var sId = this._sUIDToken;
    if ( typeof sId !== "string" ) {
      // 从全类名开始操作
      sId  = this.getName();
      // 降为不带命名空间的类名
      sId = sId.slice(sId.lastIndexOf('.')+1);
      // 降为一个驼峰式写法, 多个词仅取最后一个
      sId = sId.replace(/([a-z])([A-Z])/g, "$1 $2").split(" ").slice(-1)[0];
      // 删除不要的字符(结尾无数字!)并转换为小写
      sId = this._sUIDToken = sId.replace(/([^A-Za-z0-9-_.:])|([0-9]+$)/g,"").toLowerCase();
    }

    return uid(sId);
  };

}());
```

所有带元数据的ManagedObject对象，都采用这种生成方式。示例如下：
![[OpenUI5] 控件ID实践与总结](/images/2015/5/0026uWfMgy6So69EaqV3d.png)
不带元数据的ManagedObject对象，采用jQuery.sap.uid()方法生成ID，比上一种缺少了类信息。
```
var iIdCounter = 0;

jQuery.sap.uid = function uid() {
  return "id-" + new Date().valueOf() + "-" + iIdCounter++;
};
```

### 控件ID最好包含父控件ID
例如在名为"Update.view.xml"的xml视图文件中定义一个图像控件：
![[OpenUI5] 控件ID实践与总结](/images/2015/5/0026uWfMgy6Sob9sBPu5c.jpg)
图像相应的DOM输出为：
![[OpenUI5] 控件ID实践与总结](/images/2015/5/0026uWfMgy6SobcxAAlb5.png)
DOM输出中的id和data-sap-id属性为父视图名和给定控件Id的连接串。同样在Javascript代码中，要巧妙利用creatId方法使控件ID为视图/UI组件/HTML片段的Id和给定控件Id的连接串。
```
sap.ui.core.Fragment.prototype.createId = function(sId) {
  // no ID Prefixing by Fragments! This is called by the template parsers, 
  // but only if there is not a View which defines the prefix.
  var id = this._sExplicitId ? this._sExplicitId + "--" + sId : sId;
  
  if (this._oContainingView && this._oContainingView != this) {
    // if Fragment ID is added to the control ID and Fragment ID already 
    // contains the View prefix, the View prefix does not need to be added again
    // (this will now be checked inside the createId function already!)
    id = this._oContainingView.createId(id);
  }
  
  return id;
};
    
sap.ui.core.mvc.View.prototype.createId = function(sId) {
  if (!this.isPrefixedId(sId)) {
    // views have 2 dashes as separator, components 3 and controls/elements 1
    sId = this.getId() + "--" + sId;
  }
  return sId;
};

sap.ui.core.mvc.Controller.prototype.createId = function(sId) {
  return this.oView ? this.oView.createId(sId): undefined;
};
  
sap.ui.core.UIComponent.prototype.createId = function(sId) {
  if (!this.isPrefixedId(sId)) {
    // components have 3 dashes as separator, views 2 and controls/elements 1
    sId = this.getId() + "---" + sId;
  }
  return sId;
};
```

从上述代码可知，OpenUI5的惯例是：
- UI组件使用两个连接符作为分隔符
- 视图/控件和HTML片段使用两个连接符作为分隔符
- 控件使用一个连接符作为分隔符在控件内部，可以手工将控件Id与子控件Id连接。下面以sap.ui.unified.FileUploader为例，其中的子控件Id为this.getId()+ "-fu_input"。

```
sap.ui.unified.FileUploader.prototype.init = function(){
  // Instantiate browser-specific UI-Elements (IE8 only): 
  // works fine with applySettings() after init() - most things are done in onAfterRendering
  // IE8 should render a native file uploader and the SAPUI5 controls should be exactly behind
  if (!!sap.ui.Device.browser.internet_explorer && sap.ui.Device.browser.version == 8) {
    this.oFilePath = new sap.ui.commons.TextField(<font color="#FF0000">**this.getId() + "-fu_input"**</font>,
                          {width: "225px"});
    
    this.oBrowse = new sap.ui.commons.Button({enabled : this.getEnabled(),
      text: "Browse..",
      width: "0px",
      height: "0px"});
  } else {
    //all other browsers will load the respective UI-Elements from the FileUploaderHelper
    this.oFilePath = sap.ui.unified.FileUploaderHelper.createTextField(<font color="#FF0000">**this.getId() + "-fu_input"**</font>);
    this.oBrowse = sap.ui.unified.FileUploaderHelper.createButton();
  }
  this.oFilePath.setParent(this);
  this.oBrowse.setParent(this);

  this.oFileUpload = null;

  //retrieving the default browse button text from the resource bundle
  this.oBrowse.setText(this.getBrowseText());
};
```

控件ID最好包含父控件ID可以很好地表达层次关系，因此在调试时很有帮助！

### 定义聚合

当开发控件时，应该假定当其被使用时可在任何时候被销毁或重新创建。例如，控件的容器由于数据异步更新而销毁并重新创建，控件自身也要被销毁和重新创建。应此，对控件内使用的任何引用进行适当清理尤为重要。
上述场景中一个常见的错误是"duplicate ID"错误，例如
```
Uncaught Error: Error: adding element with duplicate id 'Slider-basic-slider-valueLabel'
```

这可能是一个控件创建了另外一个控件实例(例如Label)并用变量引用它。当主控件进入销毁阶段，该引用没有自动清理。下次当控件重新创建时，它尝试使用相同ID创建Label实例从而导致上述错误。
在与此类似的场景中，该错误可以通过将Label定义为主组件元数据块内的"aggregation"来进行避免。子控件从而算是“被管理”了，OpenUI5将负责管理控件的生命周期，包括清除其引用。并且这种方式也提供了库内一致性和自文档。详情和示例请参见[Creating Custom Controls in SAPUI5](https://www.nabisoft.com/tutorials/sapui5/creating-custom-controls-in-sapui5#Step2)。

最佳实践是在开发中故意销毁并重新创建控件以验证其能正常清理资源。