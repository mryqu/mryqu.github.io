---
title: '试用GoJS BPMN生成Activiti支持的process.bpmn.xml'
date: 2015-02-26 16:37:24
categories: 
- workflow
tags: 
- javascript
- gojs
- activiti
- process.bpmn.xml
- 生成
---
我在Activiti中建立一个简单的仅有startEvent、userTask和endEvent的BPMN模型，导出的process.bpmn.xml内容如下：
![试用GoJS BPMN生成Activiti支持的process.bpmn.xml](/images/2015/2/0026uWfMgy6QhvKjLSWb2.jpg)
前一博文[玩玩GoJS BPMN样例](/post/玩玩gojs_bpmn样例)中我给出了类似 BPMN模型的JSON数据。通过分析可知，除了两者的ID生成机制不同（GoJSBPMN生成的ID太简单，很容易重复），完全可以通过GoJS的JSON数据构造上面的process.bpmn.xml文件内容。
试了一下在Javascript中生成上面的process.bpmn.xml文档，大致可行。从[MDN](https://developer.mozilla.org/en-US/docs/Web/API/DOMImplementation/createDocument)查到的资料可知，仅支持IE9+浏览器。不支持低版本IE浏览器，估计现在不算什么问题。目前生成的XML文档有些瑕疵，第一个使用createElement_x方法创建的节点会自动添加命名空间xmlns=http://www.w3.org/1999/xhtml，但是应该可以避免。

|Chrome|Firefox (Gecko)|Internet Explorer|Opera|Safari
|-----
|(Yes)|1.0 (1.7 or earlier)|9.0|(Yes)|(Yes)

JS代码如下：
![试用GoJS BPMN生成Activiti支持的process.bpmn.xml](/images/2015/2/0026uWfMgy6QhMOqyQCd6.jpg)