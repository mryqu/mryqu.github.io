---
title: '[RabbitMQ] 在Widnows平台安装配置RabbitMQ'
date: 2016-08-06 05:29:19
categories: 
- Service+JavaEE
- MQ
tags: 
- rabbitmq
- windows
- install
- configure
---
### RabbitMQ介绍

RabbitMQ是基于高级消息队列协议的消息代理软件。RabiitMQ服务器由Erlang语言开发，客户端支持多种主流编程语言。
RabbitMQ由LShift和CohesiveFT合营公司Rabbit技术有限公司开发，在2010年4月被SpringSource收购，2013年5月归入Pivotal软件。
RabbitMQ项目包括：
- RabbitMQ交换服务器自身
- 用于HTTP、流文本定向消息协议(STOMP)和消息队列遥测传输协议(MQTT)的网关
- Java、.NET Framework和Erlang语言的AMQP客户端库
- 支持定制插件的插件平台，内建插件集合为:
  - Shovel插件，负责从一个消息代理（broker）向另一个移动/复制消息。
  - Federation插件，在消息代理之间有效共享消息(基于exchange这一级)
  - Management插件，监控和管理消息代理
  - STOMP插件，提供STOMP协议支持
  - MQTT插件，提供MQTT协议支持
  - LDAP插件，RabbitMQ通过外部LDAP服务器进行认证和授权

### 在Widnows平台安装RabbitMQ

根据[http://www.rabbitmq.com/install-windows.html](http://www.rabbitmq.com/install-windows.html)安装Erlang和RabbitMQ服务器，运行RabbitMQ安装程序时需要选择“**Runas Administrator**”，否则事后需要执行下列命令修正.erlang.cookie位置错误。
```
copy /Y %SystemRoot%\.erlang.cookie %HOMEDRIVE%%HOMEPATH%
```
设置环境变量（及安装并启动RabbitMQ服务）
```
SET　ERLANG_HOME=C:\tools\erl8.0
SET RABBITMQ_SERVER＝C:\tools\RabbitMQ_Server\rabbitmq_server-3.6.5
SET　RABBITMQ_BASE=C:\rabbitmq-data
ECHO []. > C:\rabbitmq-data\rabbitmq.config
%RABBITMQ_SERVER%\sbin\rabbitmq-service.bat install
%RABBITMQ_SERVER%\sbin\rabbitmq-service.bat start
```
#### 安装管理插件
rabbitmq-management插件提供用于管理和监控RabbitMQ服务器的基于HTTP的API，以及基于浏览器的界面和一个控制台工具rabbitmqadmin。功能包括：
- 声明、列举和删除exchange、queue、binding、用户、虚拟主机和权限。
- 监控队列长度、消息总速率和每通道速率、连接数据速率等。
- 发送和接受消息。
- 监控Erlang进程、文件描述符和内存使用。
- 导出/导入对象定义到JSON格式
- 强制关闭连接、清除队列。![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74vsO9YwJf5.jpg)

重启RabbitMQ后登录http://guest:guest@localhost:15672/，即可见到管理页面。
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74vxtT5yC2e.jpg)
#### rabbitmqctl
通过rabbitmqctl创建一个管理员用户admin和一个对虚拟主机有读写权限的普通用户mryqu：
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74wHf4qcEe8.png)
自建管理员用户admin的默认用户guest的区别在于：guest仅能本机访问RabbitMQ，除非在rabbitmq.config增加loopback_users设置。
#### 使用HTTP管理API
将配置导出成JSON格式：
```
curl -i -u guest:guest http://localhost:15672/api/definitions
```
![[RabbitMQ] 在Widnows平台安装配置RabbitMQ](/images/2016/8/0026uWfMzy74wO9zc3s3e.jpg)
#### 激活其他插件
例如激活shovel插件：
```
%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat enable rabbitmq_shovel
%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat enable rabbitmq_shovel_management
```

### 测试RabbitMQ
使用[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)中的代码即可，由于我想试验非本机访问RabbitMQ，因此添加了application.properties：
```
spring.rabbitmq.host=rabbitmqServer
spring.rabbitmq.port=5672
spring.rabbitmq.username=mryqu
spring.rabbitmq.password=XXXXXXXXXXXXXX
```

### 参考

[RabbitMQ - Installing on Windows](http://www.rabbitmq.com/install-windows.html)    
[RabbitMQ - Access Control (Authentication, Authorisation)](http://www.rabbitmq.com/access-control.html)    
[RabbitMQ - Windows Quirks](https://www.rabbitmq.com/windows-quirks.html)    
[RabbitMQ - plugins](https://www.rabbitmq.com/plugins.html)    
[RabbitMQ - Management Plugin](https://www.rabbitmq.com/management.html)    
[RabbitMQ - Shovel plugin](https://www.rabbitmq.com/shovel.html)    
[RabbitMQ - rabbitmqctl(1) manual page](https://www.rabbitmq.com/man/rabbitmqctl.1.man.html)    
[RabbitMQ Management HTTP API](https://cdn.rawgit.com/rabbitmq/rabbitmq-management/rabbitmq_v3_6_5/priv/www/api/index.html)    
[GETTING STARTED: Messaging with RabbitMQ](https://spring.io/guides/gs/messaging-rabbitmq/)    
[Spring AMQP](http://docs.spring.io/spring-amqp/reference/html/index.html)    
[RabbitMQ for Windows: Introduction](https://lostechies.com/derekgreer/2012/03/05/rabbitmq-for-windows-introduction/)    