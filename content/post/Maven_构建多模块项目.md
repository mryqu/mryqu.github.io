---
title: '[Maven] 构建多模块项目'
date: 2016-09-03 07:07:55
categories: 
- Service+JavaEE
tags: 
- maven
- module
- parent
- multiple
---
在前一篇博文[[Gradle] 将多项目转换成Maven项目](/post/gradle_将多项目转换成maven项目)中利用Gradle转换成Maven构建脚本，将朋友糊弄过去了。后来想想，还是给他做一个重头搭建多模块Maven项目的演示吧。

### 创建根（父）项目

下列脚本可以创建一个包含pom.xml的yqu-ts-parent目录：
```
mvn archetype:generate -DgroupId=com.yqu.ts -DartifactId=yqu-ts-parent -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```
测试结果：
![[Maven] 构建多模块项目](/images/2016/9/0026uWfMzy767HeCeUbe3.jpg) 进入yqu-ts-parent目录，删除src子目录，然后将pom.xml文件中packaging节点内容由jar改为pom。pom表示它是一个被继承的模块

### 创建子项目

在yqu-ts-parent目录中运行下列脚本可以创建两个包含pom.xml文件的子目录yqu-ts-service和yqu-ts-webapp：
```
mvn archetype:generate -DgroupId=com.yqu.ts -DartifactId=yqu-ts-service -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
mvn archetype:generate -DgroupId=com.yqu.ts -DartifactId=yqu-ts-webapp -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```
测试结果：
![[Maven] 构建多模块项目](/images/2016/9/0026uWfMzy767HfCknX3d.jpg) 这两个命令会修改yqu-ts-parent项目的pom.xml，增加了两个子模块yqu-ts-service和yqu-ts-webapp。对于两个字模块的pom.xml，增加packaging节点，由于这两个子模块将用SpringBoot实现因而内容都为jar。

### 确认项目/模块的pom.xml

#### yqu-ts-parent项目的pom.xml
![[Maven] 构建多模块项目](/images/2016/9/0026uWfMzy767HeZTfuf4.jpg)
#### yqu-ts-service模块的pom.xml
![[Maven] 构建多模块项目](/images/2016/9/0026uWfMzy767HfPbp4f6.jpg)
#### yqu-ts-webapp模块的pom.xml
![[Maven] 构建多模块项目](/images/2016/9/0026uWfMzy767HgoOsu4e.jpg)