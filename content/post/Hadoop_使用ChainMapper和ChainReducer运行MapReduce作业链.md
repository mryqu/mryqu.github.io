---
title: '[Hadoop] 使用ChainMapper和ChainReducer运行MapReduce作业链'
date: 2015-05-24 00:07:44
categories: 
- BigData
tags: 
- hadoop
- chainmapper
- chainreducer
- jobchaining
- mapreduce
---
启动多个MapReduce作业并实现作业控制，大概有以下几种方式：

- 在Driver中通过waitForCompletion方法同步启动并运行作业，根据执行结果同样同步启动并运行后继作业。作业控制逻辑完全是自己实现，仅适用于作业不多的应用。
- 使用ChainMapper和ChainReducer运行MapReduce作业链
- 使用Oozie管理复杂MapReduce工作流
本文将针对第二种方式进行学习总结。

使用MapReduce作业链模式的数据和执行流如下：

- 一或多个mapper
- shuffle阶段
- 一个reducer
- 零或多个mapper
即，mapper可以输出给mapper，也可以输出给reducer；reducer只能输出给mapper；reducer之前必有shuffle阶段。

### JobChaining示例

#### JobChainingDemo.java源码
![[Hadoop] 使用ChainMapper和ChainReducer运行MapReduce作业链](/images/2015/5/0026uWfMzy79Eov9jIK4a.jpg)
#### londonbridge.txt
```
London Bridge is falling down,
Falling down, falling down.
London Bridge is falling down,
My fair lady.

Build it up with wood and clay,
Wood and clay, wood and clay,
Build it up with wood and clay,
My fair lady.

Wood and clay will wash away,
Wash away, wash away,
Wood and clay will wash away,
My fair lady.

Build it up with bricks and mortar,
Bricks and mortar, bricks and mortar,
Build it up with bricks and mortar,
My fair lady.

Bricks and mortar will not stay,
Will not stay, will not stay,
Bricks and mortar will not stay,
My fair lady.

Build it up with iron and steel,
Iron and steel, iron and steel,
Build it up with iron and steel,
My fair lady.

Iron and steel will bend and bow,
Bend and bow, bend and bow,
Iron and steel will bend and bow,
My fair lady.

Build it up with silver and gold,
Silver and gold, silver and gold,
Build it up with silver and gold,
My fair lady.

Silver and gold will be stolen away,
Stolen away, stolen away,
Silver and gold will be stolen away,
My fair lady.

Set a man to watch all night,
Watch all night, watch all night,
Set a man to watch all night,
My fair lady.

Suppose the man should fall asleep,
Fall asleep, fall asleep,
Suppose the man should fall asleep,
My fair lady.

Give him a pipe to smoke all night,
Smoke all night, smoke all night,
Give him a pipe to smoke all night,
My fair lady.
```

#### 执行
```
 hadoop jar YquMapreduceDemo.jar JobChainingDemo /user/hadoop/chain_input/londonbridge.txt /user/hadoop/chain_output2
```

#### 测试结果
![[Hadoop] 使用ChainMapper和ChainReducer运行MapReduce作业链](/images/2015/5/0026uWfMzy79Eo3kEpsda.png)