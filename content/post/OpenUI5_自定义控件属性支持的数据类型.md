---
title: '[OpenUI5] 自定义控件属性支持的数据类型'
date: 2015-08-08 08:05:21
categories: 
- FrontEnd
tags: 
- openui5
- control
- perperty
- data
- type
---
创建一个OpenUI5控件时免不了声明几个属性，例如：
```
metadata: {
  properties: {
    "msg" : {type : "string", defaultValue : "kx123"},
    "byProxy" : {type : "boolean", defaultValue : true}
  },
  publicMethods: [
  ],
  events: {
    complete : {enablePreventDefault : true}
  }
}
```

可是属性都支持那些数据类型呢？搜了一下[OpenUI5 开发指南](https://openui5.hana.ondemand.com/)，并没有找到什么有用的信息。还是得从代码里面寻觅，结果发现答案就在[sap.ui.base.DataType](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/DataType.js)里。
```
var mTypes = {
 "any" :
  createType("any", {
   defaultValue : null,
   isValid : function(vValue) {
    return true;
   }
  }),
 "boolean" :
  createType("boolean", {
   defaultValue : false,
   isValid : function(vValue) {
    return typeof vValue === "boolean";
   }
  }),
 "int" :
  createType("int", {
   defaultValue : 0,
   isValid : function(vValue) {
    return typeof vValue === "number" && Math.floor(vValue) == vValue;
   }
  }),
 "float" :
  createType("float", {
   defaultValue : 0.0,
   isValid : function(vValue) {
    return typeof vValue === "number";
   }
  }),
 "string" :
  createType("string", {
   defaultValue : "",
   isValid : function(vValue) {
    return typeof vValue === "string" || vValue instanceof String;
   }
  }),
 "object" :
  createType("object", {
   defaultValue : null,
   isValid : function(vValue) {
    return typeof vValue === "object" || typeof vValue === "function";
   }
  })
};

DataType.getType = function(sTypeName) {
 var oType = mTypes[sTypeName];
 if ( !oType ) {
  // check for array types
  if (sTypeName.indexOf("[]") > 0) {
   var sComponentTypeName = sTypeName.slice(0, -2),
    oComponentType = this.getType(sComponentTypeName);
   oType = oComponentType && createArrayType(oComponentType);
   if ( oType ) {
    mTypes[sTypeName] = oType;
   }
   return oType;
  } else {
   oType = jQuery.sap.getObject(sTypeName);
   if ( oType instanceof DataType ) {
    mTypes[sTypeName] = oType;
   } else if ( jQuery.isPlainObject(oType) ) {
    oType = mTypes[sTypeName] = createEnumType(sTypeName, oType);
   }
  }
 }
 return oType;
};
```

有上面代码可知，首先支持的基本数据类型有any、boolean、int、float、string和object。

支持数组，但是数组项的类型必须是支持的基本数据类型。例如"messages" : {type : "string[]",defaultValue : "mryqu,kx123"}。其中类型以[]结尾，值用逗号分隔。

此外支持可枚举的属性，即扁平对象(使用"{}"或"new Object"创建而得)
![[OpenUI5] 自定义控件属性支持的数据类型](/images/2015/8/0026uWfMgy721hB5wtMfe.png)
对[sap.ui.base.DataType](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/base/DataType.js)的值解析、属性有效性验证等细节除了研究代码外，还可参考[单元测试DataType.qunit.html](https://github.com/SAP/openui5/blob/master/src/sap.ui.core/test/sap/ui/core/qunit/DataType.qunit.html)。
