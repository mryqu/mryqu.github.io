---
title: '[Hadoop] 使用MRUnit进行MapReduce单元测试'
date: 2014-06-15 22:59:22
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- mrunit
- mapreduce
- unittest
- junit
---
### MRUnit介绍

![[Hadoop] 使用MRUnit进行MapReduce单元测试](/images/2014/6/0026uWfMzy78PQgdkdw6e.png) MRUnit是一个用于帮助开发者进行HadoopMapReduce作业单元测试的Java库。它是JUnit架构扩展，无需将代码运行在集群上即可在开发环境测试Mapper和Reducer类的功能。MRUnit由Cloudera开发，并在2012年成为Apache基金会顶级项目。
MRUnit使用LocalJobRunner使用样本数据集模拟一次Mapper/Reducer执行过程。通过定义一或多个输入记录，使用LocalJobRunner运行测试代码，判定是否与期望输出相符。如相符，则安静退出；否则，默认抛出异常。

### 测试代码

本测试代码基于MRUnit指南中示例代码修改而成，使用junit:junit:4.11和org.apache.mrunit:mrunit:1.1.0:hadoop2两个Java库进行编译和测试。
#### SMSCDR.java
![[Hadoop] 使用MRUnit进行MapReduce单元测试](/images/2014/6/0026uWfMzy78PRw9Boz5f.png)
#### SMSCDRMapperReducerTest
![[Hadoop] 使用MRUnit进行MapReduce单元测试](/images/2014/6/0026uWfMzy78PS6rAiw94.png)
### 执行测试
#### 成功测试演示
![[Hadoop] 使用MRUnit进行MapReduce单元测试](/images/2014/6/0026uWfMzy78PSsHR0r57.jpg)
#### 失败测试演示
为了演示测试失败情况，我将testReducer方法中期望值改为错误值123。
![[Hadoop] 使用MRUnit进行MapReduce单元测试](/images/2014/6/0026uWfMzy78PSREcOe6a.jpg)

### 参考

[Apache MRUnit](http://mrunit.apache.org/)    
[MRUnit Tutorial](https://cwiki.apache.org/confluence/display/MRUNIT/MRUnit+Tutorial)    