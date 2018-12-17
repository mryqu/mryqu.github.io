---
title: 'Windows下MongoDB安装与配置'
date: 2014-03-30 07:57:15
categories: 
- DB/NoSQL
tags: 
- mongodb
- 安装
- 配置
- nosql
- windows
---
到官网http://www.mongodb.org/downloads下载MongoDB并安装在c:\mongodb目录下，安装后需要进行配置才能启动MongoDB。首先创建如下目录：
- md c:\mongodb\data
- md c:\mongodb\db
- md c:\mongodb\log
- md c:\mongodb\etc
接着创建MongoDB配置文件：c:\mongodb\etc\mongo.conf
```
systemLog:
   destination: file
   path: C:/mongodb/log/mongo.log
   logAppend: true
storage:
   dbPath: C:/mongodb/data/db
   journal:
      enabled: true
net:
   http:
      enabled: true
      RESTInterfaceEnabled: true
```

通过如下命令启动MongoDB：
```
C:\mongodb\bin\mongod.exe --config C:\mongodb\etc\mongo.conf
```
可以通过以下三种方式验证MongoDB是否安装成功：
- 访问MongoDB监听端口 http://localhost:27017/ ，确认出现类似信息。![Windows下MongoDB安装与配置](/images/2014/3/0026uWfMgy6QjpUAH5cee.png)
- 通过C:\mongodb\bin\mongo.exe登录Javascript shell并使用
- 访问HTTP接口 http://localhost:28017/ 并查看MongoDB服务器信息

在启动MongoDB的窗口通过`Ctrl`+ `C`停止MongoDB的运行。
最后通过如下命令将MongoDB配置成Windows服务：
```
C:\mongodb\bin\mongod.exe --config C:\mongodb\etc\mongo.conf--install
```
当然也可以通过如下命令手工配置Windows服务：
```
sc create MongoDB binPath= "C:\mongodb\bin\mongod.exe--config=C:\mongodb\etc\mongo.conf--service" start= demand DisplayName= "MongoDB"
```

### 参考

[ Install MongoDB on Windows](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/)    
[MongoDB Configuration Options](http://docs.mongodb.org/manual/reference/configuration-options/)    