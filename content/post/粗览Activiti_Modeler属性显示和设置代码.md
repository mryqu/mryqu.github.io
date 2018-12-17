---
title: '粗览Activiti Modeler属性显示和设置代码'
date: 2015-03-06 08:47:29
categories: 
- workflow
tags: 
- activiti
- modeler
- 代码
- 分析
---
我的博文[粗览Activiti Modeler操作和源代码](/post/粗览activiti_modeler操作和源代码)介绍了Activiti ModelEditor组件的常用操作和对应源代码分析，本文接着介绍一下ActivitiModeler里BPMN元素属性的显示和设置。
[粗览Activiti Modeler操作和源代码](/post/粗览activiti_modeler操作和源代码)里提到的stencilset.json除了含有每个BPMN元素应该使用什么图标，也定义了每个BPMN元素的所有属性。以UserTask元素为例，它含有以下的属性包：
- "overrideidpackage"
- "namepackage"
- "documentationpackage"
- "asynchronousdefinitionpackage"
- "exclusivedefinitionpackage"
- "executionlistenerspackage"
- "multiinstance_typepackage"
- "multiinstance_cardinalitypackage"
- "multiinstance_collectionpackage"
- "multiinstance_variablepackage"
- "multiinstance_conditionpackage"
- "isforcompensationpackage"
- "usertaskassignmentpackage"
- "formkeydefinitionpackage"
- "duedatedefinitionpackage"
- "prioritydefinitionpackage"
- "formpropertiespackage"
- "tasklistenerspackage"

[tomcat]\webapps\activiti-explorer\editor-app\configuration\properties.js里提供了对各类BPMNstencil的所需要包含的HTML页面。
![粗览Activiti Modeler属性显示和设置代码](/images/2015/3/0026uWfMgy6QAfKW92T07.jpg)
[tomcat]\webapps\activiti-explorer\editor-app\stencil-controller.js中对ORYX.CONFIG.EVENT_SELECTION_CHANGED事件注册了匿名函数监听器。当某一BPMN元素被选中后，该监听器会设置$scope.selectedItem和$scope.selectedShape，其中包含BPMN元素的所有属性，每个属性都有对应的stencilreadModeTemplateUrl、writeModeTemplateUrl和templateUrl。
[tomcat]\webapps\activiti-explorer\editor-app\editor.html是ActivitiModelEditor组件的显示页面，其ID为propertiesHelpWrapper的DIV元素内对所选择的BPMN元素的每个属性放置templateUrl、readModeTemplateUrl或writeModeTemplateUrl对应的HTML子页面用于显示和设置stencil属性。
用于设置BPMNstencil属性的页面都位于[tomcat]\webapps\activiti-explorer\editor-app\configuration\properties\下。
这些页面和Anjugar.JS控制器为：
![粗览Activiti Modeler属性显示和设置代码](/images/2015/3/0026uWfMgy6QAhP6BQP3f.png)