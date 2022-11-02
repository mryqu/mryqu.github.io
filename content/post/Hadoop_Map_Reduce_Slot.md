---
title: '[Hadoop] Map Reduce Slot'
date: 2014-10-17 19:29:17
categories: 
- BigData
tags: 
- hadoop
- mapreduce
- slot
---
### MR1

在MR1中，每个节点可以启动的并发map和reduce任务数(即slot数)由管理员通过mapred-site.xml中`mapred.tasktracker.map.tasks.maximum` (MR2中为`mapreduce.tasktracker.map.tasks.maximum` )和`mapred.tasktracker.reduce.tasks.maximum` (MR2中为`mapreduce.tasktracker.reduce.tasks.maximum` )配置指定。(下面的参考帖子提到过作业级参数mapred.map.tasks.maximum和mapred.reduce.tasks.maximum，但是在[HADOOP-4295](https://issues.apache.org/jira/browse/HADOOP-4295)并没有通过。)

此外，管理员通过`mapred.child.配置设置mapper或reducer默认的内存分配量。`

