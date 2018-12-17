---
title: 'Windows服务的创建、查询及删除操作'
date: 2013-05-14 21:04:27
categories: 
- Tool
tags: 
- windows service
- sc
---
SC是与Windows服务管理器和服务通信的命令行程序。
### 查询SC帮助
![Windows服务的创建、查询及删除操作](/images/2013/5/0026uWfMgy6Qj2lrEhGe0.jpg)

### 创建Windows服务
![Windows服务的创建、查询及删除操作](/images/2013/5/0026uWfMgy6Qj2zkV9n39.png)
示例：`sc create akxService binPath= C:\Test\akxService.exe`

### 查询Windows服务
![Windows服务的创建、查询及删除操作](/images/2013/5/0026uWfMgy6Qj2OiT9c26.png)

### 删除Windows服务
![Windows服务的创建、查询及删除操作](/images/2013/5/0026uWfMgy6Qj2SEGCw9c.png)
示例：`sc delete akxService`
如果服务名含有空格，可在服务名上加双引号。
