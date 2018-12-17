---
title: '[Hadoop] YARN中Application Manager和Application Master区别'
date: 2015-11-28 05:56:33
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- yarn
- hadoop
- application
- manager
- master
---
术语Application Master和Application Manager经常被交换使用。其实，ApplicationMaster是一个主要的容器，用于请求、启动和监控应用特定资源；而ApplicationManager是资源管理器中的一个部件。
![[Hadoop] YARN中Application Manager和Application Master区别](/images/2015/11/0026uWfMgy71U5fKi7T91.jpg)
一个作业在YARN中启动流程如下：
- 首先客户端向YARN资源管理器提交应用，包括请求容器启动上下文所需的信息。
- 接着资源管理器中的应用管理器协商好一个容器，为应用引导一个Application Master实例。
- 之后Application Master向资源管理器注册并请求容器。
- 当ApplicationMaster同节点管理器进行通信启动所授予的容器之后，为每个容器指定容器启动上下文描述（CLC，包括执行启动的命令、安全令牌、依赖[可执行文件、压缩包]、环境变量等等）。
- Application Master管理应用执行。在执行期间，应用向ApplicationMaster提供进度和状态信息。客户端通过查询资源管理器或直接与ApplicationMaster联系，可以监控应用的状态。
- Application Master向资源管理器报告应用结束。

应用管理器负责维护一系列已提交的应用。当应用提交后，它首先验证应用规格，为ApplicationMaster拒绝任何请求无法满足资源的应用（例如，集群中没有节点有足够资源运行ApplicationMaster自身）。之后确保没有已经运行的使用相同应用ID的其他应用，错误的客户端或恶意客户端有可能导致此类问题。最后，将提交的应用转给调度器。已结束应用从资源管理器内存完全清除之前，此部件也负责记录和管理这些已结束应用。当应用结束，它将应用汇总信息放在守护进程的日志文件。最后，应用管理器在应用完成用户请求后很久都会在缓存中保留该已结束应用。配置参数[yarn.resourcemanager.max-completed-applications](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)控制资源管理器在任意时刻可以记住的已结束应用的最大数量。该缓存是先入先出队列，为了存放最新的已结束应用，最老的应用将被移出。
![[Hadoop] YARN中Application Manager和Application Master区别](/images/2015/11/0026uWfMzy72ZqCTf0S1a.jpg)

### 参考

[Difference between Application Manager and Application Master in YARN?](http://stackoverflow.com/questions/30967247/difference-between-application-manager-and-application-master-in-yarn)    
[Application Master 启动流程与服务简介](http://www.veryhuo.com/a/view/1370.html)    