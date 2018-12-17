---
title: '将GoJS和Activiti Explorer熬成一锅粥'
date: 2015-02-27 20:05:26
categories: 
- workflow
tags: 
- gojs
- activiti
- bpmn
- modeler
- integration
---
![将GoJS和Activiti Explorer熬成一锅粥](/images/2015/2/0026uWfMgy6QkwOPjJFe3.jpg)
熬粥时，一开始创建一个跟editor-app平行的独立目录gojs-editor-app，结果我的Chrome浏览器报“Resourceinterpreted as stylesheet but transferred with MIME typetext/html”错误，GoJS的所有Javascript和stylesheet文件(例如BPMN.js和BPMN.css)都被加了料从Tomcat发给浏览器变成了html格式。
看了下面两个帖子，没有丝毫头绪：
http://stackoverflow.com/questions/3467404/chrome-says-resource-interpreted-as-script-but-transferred-with-mime-type-tex  
thttp://stackoverflow.com/questions/22631158/resource-interpreted-as-stylesheet-but-transferred-with-mime-type-text-html-see  

搜了一下ActivitiExplorer的配置，看到org.activiti.explorer.filter.ExplorerFilter里有六个路径("/ui"、"/VAADIN"、"/modeler.html"、"/editor-app"、"/service"、"/diagram-viewer")走了特殊的过滤器。只好将GoJS的内容都转到Activiti已有的editor-app目录，这下齐活了。