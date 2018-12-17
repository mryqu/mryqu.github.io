---
title: '玩玩GoJS BPMN样例'
date: 2015-02-25 19:50:09
categories: 
- workflow
tags: 
- gojs
- bpmn
- svg
- png
- json
---
玩一玩[GoJS](http://www.gojs.net/latest)，[GoJS](http://www.gojs.net/latest)是[Northwoods Software](http://www.nwoods.com/about.html)的产品。[Northwoods Software](http://www.nwoods.com/about.html)创立于1995年，专注于交互图控件和类库。旗下四款产品：
- [GoJS](http://www.nwoods.com/products/gojs/)：用于在HTML上创建交互图的纯javaSCript库，GoJS支持复杂的模板定义和数据绑定。
- [GoDiagram](http://www.nwoods.com/products/godiagram/)：用于WinForms的.NET图控件。
- [GoXam](http://www.nwoods.com/products/goxam/)：用于WPF/Silverlight的图控件。
- [JGo](http://www.nwoods.com/products/jgo/)：用于Swing/SWT中创建交互图的java库。

试了一下GoJS的BPMN样例，很容易导出SVG或PNG/JPEG等格式的图像数据。其中：
- 由于GoJS是经过代码混淆的，不能对makeSVG方法进行确定的分析，大概是采用HTMLCanvasElement.getContext('2d').drawImage(...).getImageData(...)获得的
- makeImage和makeImageData方法通过[HTMLCanvasElement.toDataURL()方法实现的](https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/toDataURL)

![玩玩GoJS BPMN样例](/images/2015/2/0026uWfMgy6QfHGRPkc08.jpg)
在控制台执行window.myDiagram.model.toJson()，返回如下结果：
```
{
  "class": "go.GraphLinksModel",
  "linkFromPortIdProperty": "fromPort",
  "linkToPortIdProperty": "toPort",
  "nodeDataArray": [
    {
      "category": "activity",
      "item": "User task",
      "key": 7,
      "loc": "388.33645784919577 140.35229369949943",
      "text": "User Task",
      "taskType": 2,
      "boundaryEventArray": [
        
      ],
      "size": "120 80"
    },
    {
      "category": "event",
      "item": "End",
      "key": 104,
      "loc": "569.86545617508 140.90913111767696",
      "text": "End",
      "eventType": 1,
      "eventDimension": 8
    },
    {
      "category": "event",
      "item": "start",
      "key": 101,
      "loc": "183.42028795985397 135.34075693590137",
      "text": "Start",
      "eventType": 1,
      "eventDimension": 1
    }
  ],
  "linkDataArray": [
    {
      "from": 101,
      "to": 7,
      "fromPort": "",
      "toPort": "",
      "points": [
        204.92028795985,
        135.3407569359,
        214.92028795985,
        135.3407569359,
        261.62837290452,
        135.3407569359,
        261.62837290452,
        140.3522936995,
        308.3364578492,
        140.3522936995,
        328.3364578492,
        140.3522936995
      ]
    },
    {
      "from": 7,
      "to": 104,
      "fromPort": "",
      "toPort": "",
      "points": [
        448.3364578492,
        140.3522936995,
        458.3364578492,
        140.3522936995,
        492.60095701214,
        140.3522936995,
        492.60095701214,
        140.90913111768,
        526.86545617508,
        140.90913111768,
        546.86545617508,
        140.90913111768
      ]
    }
  ]
}
```

(newXMLSerializer()).serializeToString(window.myDiagram.makeSvg())可以获得SVG的字符串表示。