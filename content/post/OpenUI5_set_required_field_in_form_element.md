---
title: '[OpenUI5] set required field in form element'
date: 2015-03-19 19:27:48
categories: 
- 前端
tags: 
- openui5
- form
- required
- field
---
对FormElement中的sap.m.Input设置了required属性，但是界面上的标签并没有显示星号*。
```
new FormElement({
  label: "name",
  fields: [ 
    new sap.m.Input({
      id: sFormId+"-name",
      type: sap.m.InputType.Text,
      value: "{/name}",
      required: true,
      layoutData: new GridData({span: "L3 M5 S6"})
    })
 ]
})
```

通过阅读[Q: UI5 Setting field as required](https://scn.sap.com/thread/3709334)得知，需要对label属性赋值一个带有required为true的Label控件。
```
new FormElement({
  label: new sap.m.Label({
    text:"name",
    required:true
  }),
  fields: [ 
    new sap.m.Input({
      id: sFormId+"-name",
      type: sap.m.InputType.Text,
      value: "{/name}",
      required: true,
      layoutData: new GridData({span: "L3 M5 S6"})
    })
 ]
})
```
![[OpenUI5] set required field in form element](/images/2015/3/0026uWfMgy71xX7jJu434.png)