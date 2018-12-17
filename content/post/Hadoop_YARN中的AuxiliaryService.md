---
title: '[Hadoop] YARN中的AuxiliaryService'
date: 2015-02-01 12:39:55
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- yarn
- auxiliaryservice
- mapreduce
- shufflehandler
---
一个附属服务（AuxiliaryService）是由YARN中节点管理器（NM）启动的通用服务。该服务由YARN配置["yarn.nodemanager.aux-services"](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)定义。默认值为mapreduce_shuffle，即MRv2中的ShuffleHandler。
![[Hadoop] YARN中的AuxiliaryService](/images/2015/2/0026uWfMzy732UdbbSLe7.jpg)

AuxiliaryService是节点管理器内的服务，接收应用/容器初始化和停止事件并作相应处理。
![[Hadoop] YARN中的AuxiliaryService](/images/2015/2/0026uWfMzy73aAUC3lF1b.png)

MRv2提供了一个叫做org.apache.hadoop.mapred.ShuffleHandler的内建AuxiliaryService，用于将节点内map输出文件提供给reducer(<font color="#8E8188">上图中除ShuffleHandler之外的其他AuxiliaryService子类均为测试类</font>)。
节点管理器可能有多个AuxiliaryService，类AuxServices用于处理此类服务集合。
![[Hadoop] YARN中的AuxiliaryService](/images/2015/2/0026uWfMzy73c3qEEpT65.png)

当AuxServices对象启动，它从YarnConfiguration.NM_AUX_SERVICES（即"yarn.nodemanager.aux-services"）获得附属服务名，从YarnConfiguration.NM_AUX_SERVICE_FMT（即"yarn.nodemanager.aux-services.%s.class"）获得对应的服务类名。例如"yarn.nodemanager.aux-services.mapreduce_shuffle.class"对应ShuffleHandler类。之后它将服务置入serviceMap并调用init()方法对服务进行初始化。
Hadoop实现是一个事件驱动系统。AuxServices既是ServiceStateChangeListener也是EventHandler，用于处理AuxServicesEventType事件。
```
public enum AuxServicesEventType {
  APPLICATION_INIT,
  APPLICATION_STOP,
  CONTAINER_INIT,
  CONTAINER_STOP
}

public class AuxServicesEvent extends AbstractEvent {
  private final String user;
  private final String serviceId;
  private final ByteBuffer serviceData;
  private final ApplicationId appId;
  private final Container container;
}

public abstract class AbstractEvent> 
    implements Event {
  private final TYPE type;
  private final long timestamp;
}
```

在handle(AuxServicesEventevent)方法中，每个事件与AuxiliaryService中的一个API调用相关连。例如，只要AuxServices收到一个APPLICATION_INIT事件，对应AuxiliaryService的initializeApplication()方法就会被调用。
那一个事件如何被传递给AuxServices的？
![[Hadoop] YARN中的AuxiliaryService](/images/2015/2/0026uWfMzy73cxeNYd0ce.jpg)
NodeManager类包含一个ContainerManagerImpl对象变量，而ContainerManagerImpl类包含一个AuxServices对象变量。此外ContainerManagerImpl类有自己的AsyncDispatcher,它会向AuxServices分发所有AuxServicesEventType类型事件。
AuxServicesEventType.APPLICATION_STOP事件在ApplicationImpl类中被创建，节点管理器中应用表述的状态机触发。
其他三个的AuxServicesEventType事件，例如APPLICATION_INIT、CONTAINER_INIT和CONTAINER_STOP，在ContainerImpl类中随着容器的生命周期被创建。

### 参考

[AuxiliaryService in Hadoop 2](http://johnjianfang.blogspot.com.au/2014/09/auxiliaryservice-in-hadoop-2.html)    
[Implementing a Custom Shuffle and a Custom Sort](https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/PluggableShuffleAndPluggableSort.html)    