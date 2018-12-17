---
title: '粗览Activiti Modeler操作和源代码'
date: 2015-02-15 20:24:21
categories: 
- workflow
tags: 
- activiti
- modeler
- 代码
- 分析
---
## Activiti Model Editor组件

我的[了解Activiti Explorer及其Vaadin实现方式](/post/了解activiti_explorer及其vaadin实现方式)博文里提到ActivitiExplorer使用的是Vaadin架构，但是Activiti 模型编辑器组件却没用使用Vaadin架构，而是采用Angular.JS的MVC模式。Activiti模型编辑器组件的客户端代码位于Activiti\modules\activiti-webapp-explorer2\src\main\webapp\editor-app\。
该目录下的editor.html是Activiti Modeler Editor的主界面HTML代码
![粗览Activiti Modeler操作和源代码](/images/2015/2/0026uWfMgy6Qex1KLT311.jpg)
其中palette区是通过Angular.JS使用stencilsets\bpmn2.0\icons下多个子目录内的PNG图像形成的多组列表。其节点层次关系获取相关代码为：
- stencil-controller.js
- Activiti\modules\activiti-modeler\src\main\java\org\activiti\rest\editor\main\StencilsetRestResource.java
- Activiti\modules\activiti-webapp-explorer2\src\main\resources\stencilset.json

![粗览Activiti Modeler操作和源代码](/images/2015/2/0026uWfMgy6QeECefVIa6.jpg)

editor.html中的视图与两个控制器进行了绑定:
- stencil-controller.js：处理对canvas中BPMN元素的操作，很多处理是通过editor目录下的QRYX库完成的
- toolbar-controller.js：处理对工具栏的操作，很多处理由configuration\toolbar-default-actions.js完成

### 保存模型操作

保存模型操作，是通过toolbar-default-actions.js中的SaveModel方法完成的，它需要将三部分信息传给服务器：
- 模型的元数据：例如模型名称、分类、创建时间、最后一次更新时间等等
- 模型JSON数据：将canvas内的图像数据转换成JSON数据UTF8字符串
   ```
   {
    "resourceId": 53,
    "properties": {
     "process_id": "process",
     "name": "",
     "documentation": "",
     "process_author": "",
     "process_version": "",
     "process_namespace": "http://www.activiti.org/processdef",
     "executionlisteners": "",
     "eventlisteners": ""
    },
    "stencil": {
     "id": "BPMNDiagram"
    },
    "childShapes": [
     {
      "resourceId": "sid-4F7484B9-11EC-4FCE-8950-FEFFB723D88B",
      "properties": {
       "overrideid": "",
       "name": "",
       "documentation": "",
       "executionlisteners": "",
       "initiator": "",
       "formkeydefinition": "",
       "formproperties": ""
      },
      "stencil": {
       "id": "StartNoneEvent"
      },
      "childShapes": [],
      "outgoing": [
       {
        "resourceId": "sid-B589A0D9-FA79-4C12-95B7-253E72480384"
       }
      ],
      "bounds": {
       "lowerRight": {
        "x": 259,
        "y": 139
       },
       "upperLeft": {
        "x": 229,
        "y": 109
       }
      },
      "dockers": []
     },
     {
      "resourceId": "sid-1A762474-62B9-4F3D-A81C-1ADD46AF7D2F",
      "properties": {
       "overrideid": "",
       "name": "",
       "documentation": "",
       "asynchronousdefinition": "false",
       "exclusivedefinition": "false",
       "executionlisteners": "",
       "multiinstance_type": "None",
       "multiinstance_cardinality": "",
       "multiinstance_collection": "",
       "multiinstance_variable": "",
       "multiinstance_condition": "",
       "isforcompensation": "false",
       "usertaskassignment": "",
       "formkeydefinition": "",
       "duedatedefinition": "",
       "prioritydefinition": "",
       "formproperties": "",
       "tasklisteners": ""
      },
      "stencil": {
       "id": "UserTask"
      },
      "childShapes": [],
      "outgoing": [
       {
        "resourceId": "sid-4134C10E-B589-42FF-AACC-463D35D52016"
       }
      ],
      "bounds": {
       "lowerRight": {
        "x": 746,
        "y": 172
       },
       "upperLeft": {
        "x": 646,
        "y": 92
       }
      },
      "dockers": []
     },
     {
      "resourceId": "sid-B22A5CAB-94D0-419E-BB1E-E8538C6A7283",
      "properties": {
       "overrideid": "",
       "name": "",
       "documentation": "",
       "executionlisteners": ""
      },
      "stencil": {
       "id": "EndNoneEvent"
      },
      "childShapes": [],
      "outgoing": [],
      "bounds": {
       "lowerRight": {
        "x": 1089,
        "y": 138
       },
       "upperLeft": {
        "x": 1061,
        "y": 110
       }
      },
      "dockers": []
     },
     {
      "resourceId": "sid-B589A0D9-FA79-4C12-95B7-253E72480384",
      "properties": {
       "overrideid": "",
       "name": "",
       "documentation": "",
       "conditionsequenceflow": "",
       "executionlisteners": "",
       "defaultflow": "false"
      },
      "stencil": {
       "id": "SequenceFlow"
      },
      "childShapes": [],
      "outgoing": [
       {
        "resourceId": "sid-1A762474-62B9-4F3D-A81C-1ADD46AF7D2F"
       }
      ],
      "bounds": {
       "lowerRight": {
        "x": 645.5626565925471,
        "y": 131.10730365650525
       },
       "upperLeft": {
        "x": 259.12484340745283,
        "y": 124.26769634349473
       }
      },
      "dockers": [
       {
        "x": 15,
        "y": 15
       },
       {
        "x": 50,
        "y": 40
       }
      ],
      "target": {
       "resourceId": "sid-1A762474-62B9-4F3D-A81C-1ADD46AF7D2F"
      }
     },
     {
      "resourceId": "sid-4134C10E-B589-42FF-AACC-463D35D52016",
      "properties": {
       "overrideid": "",
       "name": "",
       "documentation": "",
       "conditionsequenceflow": "",
       "executionlisteners": "",
       "defaultflow": "false"
      },
      "stencil": {
       "id": "SequenceFlow"
      },
      "childShapes": [],
      "outgoing": [
       {
        "resourceId": "sid-B22A5CAB-94D0-419E-BB1E-E8538C6A7283"
       }
      ],
      "bounds": {
       "lowerRight": {
        "x": 1060.676003953202,
        "y": 130.93202152143962
       },
       "upperLeft": {
        "x": 746.595480421798,
        "y": 124.30235347856038
       }
      },
      "dockers": [
       {
        "x": 50,
        "y": 40
       },
       {
        "x": 14,
        "y": 14
       }
      ],
      "target": {
       "resourceId": "sid-B22A5CAB-94D0-419E-BB1E-E8538C6A7283"
      }
     }
    ],
    "bounds": {
     "lowerRight": {
      "x": 1200,
      "y": 1050
     },
     "upperLeft": {
      "x": 0,
      "y": 0
     }
    },
    "stencilset": {
     "url": "stencilsets/bpmn2.0/bpmn2.0.json",
     "namespace": "http://b3mn.org/stencilset/bpmn2.0#"
    },
    "ssextensions": []
   }
   ```
- 模型的SVG图像数据：将canvas中的SVG图像数据经过过滤处理而得

服务器侧保存模型的代码位于 Activiti\modules\activiti-modeler\src\main\java\org\activiti\rest\editor\model\ModelSaveRestResource.java。
- 通过RepositoryService的saveModel方法将模型的元数据存入数据库的ACT_RE_MODEL表
- 通过RepositoryService的addModelEditorSource方法将模型JSON数据UTF8字符串存入数据库的ACT_GE_BYTEARRAY表
- 通过[Apache™ Batik SVG Toolkit](http://xmlgraphics.apache.org/batik/)将模型的SVG图像数据转换成PNG格式，通过RepositoryService的addModelEditorSourceExtra方法将PNG图像存入数据库的ACT_GE_BYTEARRAY表

## Activiti Explorer操作已保存模型

对模型的编辑操作是在Activiti Model Editor组件里实现的，对已保存模型的其他操作还是在ActivitiExplorer里基于Vaadin架构实现的。
客户端代码位于：Activiti\modules\activiti-explorer\src\main\java\org\activiti\editor\ui\。
下图的HTML界面由EditorProcessDefinitionDetailPanel.java实现。 
![粗览Activiti Modeler操作和源代码](/images/2015/2/0026uWfMgy6QfphZz8A68.jpg)

### 显示已保存模型

- 选择模型，会调用EditorProcessDefinitionPage类的showProcessDefinitionDetail方法
- EditorProcessDefinitionDetailPanel类的initUI方法调用initProcessDefinitionInfo方法，它会加入EditorProcessDefinitionInfoComponent实例
- 在构造EditorProcessDefinitionInfoComponent实例时，其initImage方法会被调用，通过RepositoryService的getModelEditorSourceExtra方法获得PNG格式图像，最终被显示到浏览器界面上。

### 部署已保存模型

EditorProcessDefinitionDetailPanel类的deployModel方法处理部署已保存模型的操作。
- 通过RepositoryService的getModelEditorSource方法获得模型JSON数据的UTF8字符串
- 通过[FasterXML/jackson-databind](https://github.com/FasterXML/jackson-databind)转换成Java对象树
- 通过Activiti\modules\activiti-json-converter\src\main\java\org\activiti\editor\language\json\converter\BpmnJsonConverter.java将模型JSON数据的Java对象树转换成BpmnModel实例
- 通过Activiti\modules\activiti-bpmn-converter\src\main\java\org\activiti\bpmn\converter\BpmnXMLConverter.java将BpmnModel实例转成BPMN XML数据
- 通过RepositoryService的createDeployment方法将BPMN XML数据进行部署

### 导出已保存模型

EditorProcessDefinitionDetailPanel类的exportModel方法处理导出已保存模型的操作。
- 通过RepositoryService的getModelEditorSource方法获得模型数据的JSON字符串
- 通过[FasterXML/jackson-databind](https://github.com/FasterXML/jackson-databind)转换成Java对象树
- 通过Activiti\modules\activiti-json-converter\src\main\java\org\activiti\editor\language\json\converter\BpmnJsonConverter.java将模型JSON数据的Java对象树转换成BpmnModel实例
- 通过Activiti\modules\activiti-bpmn-converter\src\main\java\org\activiti\bpmn\converter\BpmnXMLConverter.java将BpmnModel实例转成BPMN XML数据

### 编辑已保存模型

EditorProcessDefinitionDetailPanel类内注册了EditModelClickListener监听器用于处理导入BPMN模型操作。EditModelClickListener的showModeler会生成访问模型编辑器组件的URL地址，打开指定的模型。
- Activiti\modules\activiti-webapp-explorer2\src\main\webapp\editor-app\app.js中的监听器处理$includeContentLoaded事件，调用了fetchModel方法
- Activiti\modules\activiti-modeler\src\main\java\org\activiti\rest\editor\model\ModelEditorJsonRestResource.java处理该REST请求，返回由RepositoryService的getModel和getModelEditorSource方法获得Activiti模型元数据和JSON数据

### 导入BPMN模型

EditorProcessDefinitionDetailPanel类内注册了ImportModelClickListener监听器用于处理导入BPMN模型操作。ImportPopupWindow界面完成BPMN模型操作后，ImportUploadReceiver类的deployUploadedFile方法处理上传的BPMNXML数据。
- 通过Activiti\modules\activiti-bpmn-converter\src\main\java\org\activiti\bpmn\converter\BpmnXMLConverter.java将BPMN XML数据转换成BpmnModel实例
- 通过BpmnModel实例生成模型的元数据，通过RepositoryService的saveModel方法将模型的元数据存入数据库的ACT_RE_MODEL表
- 通过Activiti\modules\activiti-json-converter\src\main\java\org\activiti\editor\language\json\converter\BpmnJsonConverter.java将BpmnModel实例转换成模型JSON数据的Java对象树，通过RepositoryService的addModelEditorSource方法将模型JSON数据UTF8字符串存入数据库的ACT_GE_BYTEARRAY表

- - -

一些疑惑和想法：
- 这里BpmnXMLConverter和BpmnJsonConverter用的比较频繁，而且成对出现。为什么不跳过中间的BpmnModel？
- 导入BPMN模型为什么不生成PNG图像？
- 数据库存储的模型数据不采用BPMNXML格式而是采用JSON格式，很灵活，可以随意添加Activiti扩展内容。但是如果没有现成的JSONschema，分析起来够麻烦。