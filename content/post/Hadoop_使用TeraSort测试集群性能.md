---
title: '[Hadoop] 使用TeraSort测试集群性能'
date: 2015-05-25 06:04:00
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- terasort
- teragen
- performance
- benchmark
---
Terasort是Hadoop自带的用于集群性能基准测试的工具，其源码位于[https://github.com/apache/hadoop/tree/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort](https://github.com/apache/hadoop/tree/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort)下。

### TeraSort用法

该性能基准测试工具针对Hadoop集群的HDFS和MapReduce层进行综合测试。完整的测试步骤为：

- 使用[TeraGen](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraGen.java)程序生成官方GraySort输入数据集。(注：[SortBenchmark](http://sortbenchmark.org/)是JimGray自98年建立的一项排序竞技活动，其对排序的输入数据制定了详细规则，要求使用其提供的[gensort](http://www.ordinal.com/gensort.html)工具生成输入数据。而Hadoop的[TeraGen](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraGen.java)数据生成工具的算法与[gensort](http://www.ordinal.com/gensort.html)一致。）
- 在输入数据上运行真正的[TeraSort](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraSort.java)性能基准测试工具
- 通过[TeraValidate](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraValidate.java)程序验证排序后的输出数据

[TeraGen](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraGen.java)程序生成数据的格式为（详见[TeraSort](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraSort.java).generateRecord方法实现）：
- 10字节键：一个16字节随机数的高10字节
- 2字节常量：0x0011
- 32字节rowid
- 4字节常量：0x8899AABB
- 48字节填充：由一个16字节随机数的低48比特生成
- 4字节常量:0xCCDDEEFF

也就是说[TeraGen](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraGen.java)程序生成的一行数据有100字节。[TeraGen](https://github.com/apache/hadoop/blob/trunk/hadoop-mapreduce-project/hadoop-mapreduce-examples/src/main/java/org/apache/hadoop/examples/terasort/TeraGen.java)程序参数需要指定行数，可指定单位：
- t：1000,000,000,000
- b：1000,000,000
- m：1000,000
- k：1000

### TeraSort测试

依次运行teragen、terasort和teravalidate：
```
hadoop@node50064:~$ yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.x.jar teragen 5m /user/hadoop/teragen-data
hadoop@node50064:~$ yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.X.jar terasort /user/hadoop/teragen-data /user/hadoop/terasort-data
15/05/24 08:29:03 INFO terasort.TeraSort: starting
15/05/24 08:29:04 INFO input.FileInputFormat: Total input paths to process : 2
Spent 123ms computing base-splits.
Spent 2ms computing TeraScheduler splits.
Computing input splits took 127ms
Sampling 4 splits of 4
Making 1 from 100000 sampled records
Computing parititions took 558ms
Spent 686ms computing partitions.
......
15/05/24 08:34:23 INFO terasort.TeraSort: done
hadoop@node50064:~$ yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.X.jar teravalidate /user/hadoop/terasort-data /user/hadoop/teravalidate-data
```

terasort默认使用一个reduce任务，如需通过增加reduce任务提升性能的话，可以通过指定mapreduce.job.reduces增加reduce任务个数，例如-Dmapreduce.job.reduces=2。

完成性能分析后，删除HDFS上的数据：
```
hadoop@node50064:~$ hadoop fs -rm -r -skipTrash tera*
Deleted teragen-data
Deleted terasort-data
Deleted teravalidate-data
```