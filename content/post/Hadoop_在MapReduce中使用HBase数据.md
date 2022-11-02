---
title: '[Hadoop] 在MapReduce中使用HBase数据'
date: 2014-05-11 22:58:25
categories: 
- BigData
tags: 
- MapReduce
- hbase
- TableMapper
- TableReducer
- TableMapReduceUtil
---
对于MapReduce程序来说，除了可以用HDFS文件系统作为输入源和输出目标，同样可以使用HBase作为输入源和输出目标。下面做一个小练习进行学习。

### MapReduceOnHBaseDemo.java
![[Hadoop] 在MapReduce中使用HBase数据](/images/2014/5/0026uWfMzy792BlMwdae0.jpg)
### rebuild.sh
```
#!/bin/bash

CLASSPATH=.:$(hbase classpath):$(hadoop classpath)
javac -d classes -cp $CLASSPATH *.java
jar -cvf YquMapreduceDemo.jar  -C classes/ .
```

### 测试

执行下列命令运行MapReduce作业:
```
HADOOP_CLASSPATH=$(hbase mapredcp):${HBASE_HOME}/conf hadoop jar YquMapreduceDemo.jar MapReduceOnHBaseDemo -libjars $(hbase mapredcp | tr ':' ',')
```

HBase结果如下:
![[Hadoop] 在MapReduce中使用HBase数据](/images/2014/5/0026uWfMzy792yZMSQq9a.png)

### 与普通MapReduce程序的差异

- 本例中ScoreMapper类继承自抽象类TableMapper。TableMapper是Mapper抽象类的子类，指定输入键类型为ImmutableBytesWritable，输入值类型为Result。因此ScoreMapper类定义仅指定输出键和值类型，而其mapper方法前两个参数为ImmutableBytesWritable和Result类型。
- 本例中ScoreReducer类继承自抽象类TableReducer。TableReducer是Reduccer抽象类的子类，指定输出值类型为Mutation。因此ScoreReducer定义仅指定输入键和值、输出键的类型。有下图可知，TableReducer输出值类型支持Append、Delete、Increment和Put。![[Hadoop] 在MapReduce中使用HBase数据](/images/2014/5/0026uWfMzy79wvqMf45f9.png)
- 本例中Driver部分通过TableMapReduceUtil类的initTableMapperJob和initTableReducerJob方法合并Hadoop和HBase配置，配置job属性。

### 参考

[HBase and MapReduce](http://hbase.apache.org/book.html#mapreduce)    