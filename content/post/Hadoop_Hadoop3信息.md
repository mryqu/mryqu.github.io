---
title: '[Hadoop] Hadoop3信息'
date: 2016-02-21 07:12:33
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- 3.0.0
---
查看了一下Hadoop 3.0.0-alpha1，结果没查到什么太多信息。
[Hadoop Roadmap](http://wiki.apache.org/hadoop/Roadmap)
- HADOOP
  - Move to JDK8+
  - Classpath isolation on bydefault [HADOOP-11656](https://issues.apache.org/jira/browse/HADOOP-11656)
  - Shell scriptrewrite [HADOOP-9902](https://issues.apache.org/jira/browse/HADOOP-9902)
  - Move default ports out of ephemeralrange [HDFS-9427](https://issues.apache.org/jira/browse/HDFS-9427)
- HDFS
  - Removal of hftp in favor ofwebhdfs [HDFS-5570](https://issues.apache.org/jira/browse/HDFS-5570)
  - Support for more than twostandby [NameNodes](http://wiki.apache.org/hadoop/NameNodes) [HDFS-6440](https://issues.apache.org/jira/browse/HDFS-6440)
  - Support for Erasure Codes inHDFS [HDFS-7285](https://issues.apache.org/jira/browse/HDFS-7285)
- YARN
- MAPREDUCE
  - Derive heap size ormapreduce.*.memory.mb automatically [MAPREDUCE-5785](https://issues.apache.org/jira/browse/MAPREDUCE-5785)

[Apache Hadoop 3.0.0-alpha1-SNAPSHOT](http://aajisaka.github.io/hadoop-project/)
[JIRA: Hadoop Common 3.0.0-alpha1](https://issues.apache.org/jira/browse/HADOOP/fixforversion/12335733/?selectedTab=com.atlassian.jira.jira-projects-plugin:version-summary-panel)
[http://search-hadoop.com/?q=Hadoop+3](http://search-hadoop.com/?q=Hadoop+3): 在Hadoop及其子项目中搜索Hadoop3
Hadoop 3支持最低的JDK版本是JDK8，可在hadoop-commontrunck分支（当前默认分支trunck分支为3.0.0-alpha1，master分支为2.8.0）获得其源码。