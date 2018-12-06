---
title: '[Ambari] 了解Ambari'
date: 2015-07-26 07:35:28
categories: 
- Hadoop/Spark
- Ambari
tags: 
- ambari
- hadoop
- provision
- manage
- monitor
---
今天看到一篇帖子《[Ambari——大数据平台的搭建利器](http://www.ibm.com/developerworks/cn/opensource/os-cn-bigdata-ambari/)》介绍了[Apache Ambari](https://ambari.apache.org/)的使用。感觉Ambari确实不错，很便捷地支持Apache Hadoop集群的配置、管理和监控，堪称利器！

Ambari对系统管理员提供如下功能：
- 配置Hadoop集群
  - Ambari提供逐步的的安装向导在任意多台机器上安装Hadoop集群。
  - Ambari处理集群中Hadoop服务的配置。
- 管理Hadoop集群
  - Ambari提供对整个集群范围内启动、停止和重新配置Hadoop服务的集中管理。
- 监控Hadoop集群
  - Ambari提供仪表盘用于监控Hadoop集群（HDFS、MapReduce、HBase、Hive和HCatalog）的健康和状态。
  - Ambari通过[Ambari 运维指标系统](https://issues.apache.org/jira/browse/AMBARI-5707)收集指标。
  - Ambari提供用于系统告警的[Ambari告警框架](https://issues.apache.org/jira/browse/AMBARI-6354)，可在需要时（例如节点宕机、剩余磁盘空间不足等）通知你。

Ambari对应用开发者和系统集成者提供如下功能：
- 通过[Ambari REST APIs](https://github.com/apache/ambari/blob/trunk/ambari-server/docs/api/v1/index.md)轻松将Hadoop配置、管理和监控功能与自己的应用集成。

Ambari当前可在一些64位Linux系统上安装。

另，Ambari中文为洋麻。
