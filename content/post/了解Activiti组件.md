---
title: '了解Activiti组件'
date: 2015-02-07 18:19:05
categories: 
- workflow
tags: 
- activiti
- bpmn
- process
- flow
- component
---
### Activiti 简介

[Activiti](http://activiti.org/)作为一个遵从 Apache许可的工作流和业务流程管理开源平台，其核心是基于 Java 的超快速、超稳定的 BPMN 2.0流程引擎，强调流程服务的可嵌入性和可扩展性，同时更加强调面向业务人员。Activiti可以运行在任何JAVA程序中：单机、服务器、集群或云上。

### Activiti 组件

![了解Activiti组件](/images/2015/2/0026uWfMgy6PPTKPFYhe5.png)
- Activiti Modeler—建模器Activiti建模器是基于开源的Signavio流程编辑器的一个定制版本，可以使用浏览器图形化地编辑BPMN2.0兼容流程，流程文件被存储在数据库模型仓库内。Activiti团队已经停止Activiti建模器的活跃开发，目前仍保留在ActivitiExplorer内。![了解Activiti组件](/images/2015/2/0026uWfMgy6PPbIDgFHc1.jpg)
- Activiti Designer—设计器Activiti设计器是Eclipse插件形式的，除了可以建模BPMN2.0流程，还支持Activiti特定的扩展，可以发挥Activiti流程和引擎的全部潜能。![了解Activiti组件](/images/2015/2/0026uWfMgy6PQaYGMmace.jpg)
- Activiti Kickstart—基于表格的流程设计在Activiti Explorer的Model workspace里新建模型时选择Table-drivendefination时就是所谓的ActivitiKickstart，现在Activiti Designer里也包含这一功能。
- Activiti ExplorerExplorer是流程引擎的Web用户控制台。使用它来进行任务管理、流程实例检查、管理和基于历史统计数据查看报表等等。它不是一个的最终客户可用的成熟监控和管理应用程序，仅用于演示Activiti如何用于用户的应用中。
- Activiti RestActiviti引擎的 REST API。此外，曾经存在过下面两个组件（至少 [Activiti 5.0-alpha4](https://github.com/vanto/activiti/tree/master/modules)版本）：
- ActivitiProbe：一个对流程引擎运行期实例提供管理及监控的web应用程序。包含部署的管理、流程定义的管理、数据库表的检视、日志查看、事务的平均执行时间、失败多次的工作等功能。已经变成ActivitiExplorer的一部分
- Activiti Cycle：BPM协作用具，改用[camunda Cycle](http://docs.camunda.org/latest/guides/user-guide/#cycle)了

### 参考

[Activiti官方网站](http://activiti.org/)    
[Activiti用户指南](http://activiti.org/userguide/index.html)    
[Activiti组件](http://activiti.org/components.html)    
[Activiti开发指南](http://docs.codehaus.org/display/ACT/Developers+Guide)    
[Activiti Javadoc](http://activiti.org/javadocs/index.html)    
[Activiti源代码(GitHub)](https://github.com/Activiti)    
[ Adhoc workflow with Activiti: introducing Activiti KickStart](http://www.jorambarrez.be/blog/2011/01/05/adhoc-workflow-with-activiti-kickstart/)    
[Activiti Cycle explained](http://www.bpm-guide.de/2010/08/27/activiti-cycle-explained/)    
[ Easy Workflows - Activiti Kickstart](http://www.bataon.com/blogs/amandaluniz/easy-workflows-activiti-kickstart)    
[Activiti - 新一代的开源 BPM 引擎](http://www.ibm.com/developerworks/cn/java/j-lo-activiti1/)    