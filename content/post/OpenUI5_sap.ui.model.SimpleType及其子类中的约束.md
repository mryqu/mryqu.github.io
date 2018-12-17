---
title: '[OpenUI5] sap.ui.model.SimpleType及其子类中的约束'
date: 2016-04-12 05:57:21
categories: 
- 前端
tags: 
- openui5
- model
- type
- constraints
- javascript
---
对OpenUI5模型中的数据项如何设置类型，如何设置最大最小值等约束呢？这一切可以通过研究sap.ui.model.SimpleType及其子类获得答案。

### sap.ui.model.SimpleType类图

![[OpenUI5] sap.ui.model.SimpleType及其子类中的约束](/images/2016/4/0026uWfMgy71bDxZaUw60.jpg)
### SimpleType子类Integer约束测试

下面的示例中有两个sap.m.Input控件，第一个为文本类型输入没有约束，第二个整数类型输入有约束：
```
that.oNameInput = new Input({
  id: sFormId+"-name",
  type: sap.m.InputType.Text,
  value: "{/name}",
  layoutData: new GridData({span: "L3 M5 S6"})
});
that.oCountInput = new Input({
  id: sFormId+"-count",
  type: sap.m.InputType.Number,
  value: {
        path:'/count',
        type: 'sap.ui.model.type.Integer',
        constraints: {
                minimum : 1,
                maximum : 50 
        }
  },
  placeholder: "(1-50)",
  layoutData: new GridData({span: "L3 M5 S6"})
});
```
完整示例代码：![[OpenUI5] sap.ui.model.SimpleType及其子类中的约束](/images/2016/4/0026uWfMgy71bETwZDy38.png)
二者调试信息的差异：![[OpenUI5] sap.ui.model.SimpleType及其子类中的约束](/images/2016/4/0026uWfMgy71bFDozrjf9.jpg)
一个仅指定了映射路径；另一个除了指定映射路径外，明确指定了模型数据项类型及约束。
#### 测试结果
that.oCountInput施加了范围1到50的约束。如果输入值在范围内，则界面和模型中的count值都会改变；如果输入值不再范围内，则模型中的count值保留上一有效值，而界面发生改变且无告警。
调试堆栈如下：
```
PropertyBinding.setExternalValue (sap-ui-core-dbg.js:57174)
ManagedObject.updateModelProperty (sap-ui-core-dbg.js:34286)
ManagedObject.setProperty (sap-ui-core-dbg.js:32531)
InputBase.setProperty (InputBase-dbg.js:690)
InputBase.setValue (InputBase-dbg.js:1007)
Input.setValue (Input-dbg.js:1792)
InputBase.onChange (InputBase-dbg.js:467)
InputBase.onsapfocusleave (InputBase-dbg.js:426)
Input.onsapfocusleave (Input-dbg.js:827)
Element._handleEvent (sap-ui-core-dbg.js:45792)
UIArea._handleEvent (sap-ui-core-dbg.js:50984)
triggerFocusleave (sap-ui-core-dbg.js:47117)
FocusHandler.checkForLostFocus (sap-ui-core-dbg.js:47062)
(anonymous function) (sap-ui-core-dbg.js:26472)
```
PropertyBinding的setExternalValue代码如下，它会先解析输入值，然后调用类型的validateValue函数检查输入值有效性，通过[sap.ui.model.type.Integer源代码](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/model/type/Integer.js)可知无效值会抛出异常，从而导致数据模型和界面都不会更新。
```
PropertyBinding.prototype.setExternalValue = function(oValue) {
  // formatter doesn't support two way binding
  if (this.fnFormatter) {
    jQuery.sap.log.warning("Tried to use twoway binding, but a formatter function is used");
    return;
  }

  var oDataState = this.getDataState();
  try {
    if (this.oType) {
      oValue = this.oType.parseValue(oValue, this.sInternalType);
      this.oType.validateValue(oValue);
    }
  } catch (oException) {
    oDataState.setInvalidValue(oValue);
    this.checkDataState(); //data ui state is dirty inform the control
    throw oException;
  }
  // if no type specified set value directly
  oDataState.setInvalidValue(null);
  this.setValue(oValue);
};
```

### 参考

[sap.ui.model.SimpleType源代码](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/model/SimpleType.js)    
[sap.ui.model.Type源代码](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/model/Type.js)    
[sap.ui.model.type.Integer源代码](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/model/type/Integer.js)    
[sap.ui.model.SimpleType jsDoc](https://openui5.hana.ondemand.com/#docs/api/symbols/sap.ui.model.SimpleType.html)    