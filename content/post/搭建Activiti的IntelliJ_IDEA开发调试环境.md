---
title: '搭建Activiti的IntelliJ IDEA开发调试环境'
date: 2015-02-09 20:03:46
categories: 
- workflow
tags: 
- activiti
- intellij
- idea
- 开发
- 调试
---
## 准备工作

在搭建Activiti的IntelliJ IDEA开发调试环境前，确保下列软件已经安装：
- JDK 1.6
- ant
- Maven
- IntelliJ IDEA

## 导入Activiti

### Import Project

通过Activiti的Maven pom.xml导入IntelliJ IDEA项目。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFzq5MVad.png)![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFzCm3779.png)

### Import Modules

导入IntelliJ IDEA项目后，仅有几个Activiti模块变成了IntelliJIDEA项目中的模块。为了可以调试所有模块，通过ProjectStructure菜单简单粗暴地将剩余的Activiti模块导入IntelliJ模块。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFzVRLL2d.jpg)
对每个手工导入的模块设置源代码、资源、测试代码和测试资源。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFAa35fa1.jpg)

### Frameworks Dection

手工导入所有模块后，重启IntelliJ IDEA，它会自动检测所有模块的类型，例如Spring、WEB、JPA和GWT等。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFAtdYMa4.jpg)

## 构建Activiti

Activiti项目可以通过下面的ant命令构建：
```
.....\wfgitws\Activiti\distro>ant -Dnodocs=true clean distro
```

也可以在IntelliJ IDEA IDE中构建： 
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCy9BYdWf8.jpg)

## 本地调试

### To make sure that the necessary application server plugin isenabled

本测试中使用Apache Tomcat服务器。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCya21ml3d.jpg)

### Defining application servers in IntelliJ IDEA

![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyacONF4f.jpg)

### Check and configure artifacts in IntelliJ IDEA

![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyarL8ec2.jpg)

### Add run/local configuration in IntelliJ IDEA

![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyaJNYFed.jpg)
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyb0tOf8f.jpg)
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCybkoCF0d.jpg)
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCybJYqTfb.jpg)

### Run in IntelliJ IDEA

![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyc5eosfc.jpg)

### Add Jetbrain IDE plugin in Chrome

![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6QCyeAHIw74.jpg)

## 远程调式

### Remote Debugging Configuration

通过Run-Edit Configuration菜单命令，添加一个远程调试配置。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFAFIR0de.png)
该调试配置需要同Tomcat保持一致
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFARKXJ27.jpg)

### Remote Debugging

设置断点，在Activiti Explorer上的操作触发断点，该Activiti的IntelliJIDEA开发调试环境已经可以工作了。
![搭建Activiti的IntelliJ IDEA开发调试环境](/images/2015/2/0026uWfMgy6PQFBoB3543.jpg)