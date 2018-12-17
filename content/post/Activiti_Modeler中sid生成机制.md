---
title: 'Activiti Modeler中sid生成机制'
date: 2015-02-28 19:28:15
categories: 
- workflow
tags: 
- activiti
- modeler
- sid
- 机制
- gojs
---
昨天跟同事说Activiti Modeler中的sid比GoJS中的元素ID讲究，估计是由时戳和随机数混合生成的。
今天看了一下，发现原来就是一个纯随机数。

[tomcat]\webapps\activiti-explorer\editor-app\editor.html里对类为stencil-item的HTML元素设置的拖拽处理函数在[tomcat]\webapps\activiti-explorer\editor-app\stencil-controller.js中定义。
![Activiti Modeler中sid生成机制](/images/2015/2/0026uWfMgy6QkEps2iu32.png)
sid生成方法在[tomcat]\webapps\activiti-explorer\editor-app\editor\oryx.debug.js中定义。
```
ORYX.Editor.provideId = function() {
  var res=[], hex='0123456789ABCDEF';
  for(var i=0; i<36; i  ) res[i]=Math.floor(Math.random()*0x10);
  res[14]=4;
  res[19]=(res[19] & 0x3) | 0x8;
  for(var i=0; i<36; i  ) res[i] = hex[res[i]];
  res[8] = res[13] = res[18] = res[23] = '-';
  return "sid-"   res.join('');
};
```

当然，GoJSBPMN样例中的ID就更简单的不得了，全都是预定义的简单数字。例如，userTask的key预定义为7，当一个BPMN元素加入GoJSmodel时，GoJS会让model中的key变成唯一的（代码混淆过，我猜估计没混淆前叫makeUniqueKeyFunction）。在我的小测试中，第一个userTask的key仍然为7，第二个userTask的key被改成了-3。
感觉要是借鉴MongoDB的[ObjectId](http://docs.mongodb.org/manual/reference/object-id/)生成机制，ID的冲撞概率可能会更低。