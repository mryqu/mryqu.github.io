---
title: '[Hive] Hive 表UDTF和汇聚UDAF学习'
date: 2015-08-20 05:48:48
categories: 
- Hadoop/Spark
- Hive
tags: 
- hive
- table
- aggregate
- udtf
- udaf
---
在之前的博文[[Hive] Hive Macro和UDF实践](/post/hive_hive_macro和udf实践)中，我对Hive的宏和普通UDF进行学习并实践，这里将针对Hive表UDF（UDTF）和汇聚UDF（UDAF）进行学习。
普通UDF可以对一行表数据进行处理输出一个单元格数据；UDTF可以对一行表数据进行处理输出多列甚至多行数据；UDAF可以对整表数据进行处理输出某种汇聚结果。

### UDTF

Hive支持的内建UDTF有explode()、json_tuple()和inline()等函数。

#### 查看UDTF介绍

选个好理解的explode函数吧。
```
hive> describe function explode;
OK
explode(a) - separates the elements of array a into multiple rows, or the elements of a map into multiple rows and columns
Time taken: 0.009 seconds, Fetched: 1 row(s)
```

#### 测试内建UDTF

像inline函数需要根元素为ARRAY，第二层元素为STRUCT，搭建环境有点麻烦。所以还是接着擼explode函数吧。
![[Hive] Hive 表UDTF和汇聚UDAF学习](/images/2015/8/0026uWfMzy7aOm9zNnIba.png)
上述命令将三行的列a中数组元素拆成7行字符串。那执行"select explode(a), b fromcomplex_datatypes_example;"会返回什么呢？结果是7行还是3行？
谜底就是错误提示"Only a single exp.ression in the SELECT clause issupported with UDTF's."！

#### UDTF实现

一个定制UDTF要继承GenericUDTF抽象类并实现initialize、process及close方法。Hive调用initialize方法以将参数类型通知给UDTF。UDTF必须返回UDTF之后产生的行对象相应的对象观察器。一旦initialize()被调用后，Hive将使用process()方法将行传递给UDTF。在process()方法中，UDTF生成行并调用forward()方法将行转给其他运算符。当所有的行都传递给UDTF后，Hive将最终调用close()方法。
通过[FunctionRegistry类](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/exec/FunctionRegistry.java)可知explode函数的实现类为[GenericUDTFExplode](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/udf/generic/GenericUDTFExplode.java)。下面通过[GenericUDTFExplode](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/udf/generic/GenericUDTFExplode.java)对照参考四[Hive Developer Guide - UDTF](https://cwiki.apache.org/confluence/display/Hive/DeveloperGuide+UDTF)学习一下UDTF实现。
- [ GenericUDTFExplode](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/udf/generic/GenericUDTFExplode.java)继承了抽象父类[GenericUDTF](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/udf/generic/GenericUDTF.java)
- 在initialize方法中，[GenericUDTFExplode](https://github.com/apache/hive/blob/master/ql/src/java/org/apache/hadoop/hive/ql/udf/generic/GenericUDTFExplode.java)检查输入列是否为ARRAY或MAP类型，不是的话抛出异常。如果输入列为ARRAY类型，则输出列名为col，类型为输入列数组中元素类型；如果输入列为MAP类型，则输出列名为key和value，类型分别为输入列MAP的键与值相应的类型；
- 在process方法中，针对输入列ARRAY或MAP的每一个元素调用forward()方法将所生成的行转给其他运算符；
- 在close()方法中，实现为空。

### UDAF

Hive支持的内建UDAF有sum()、count()、min()和histogram_numeric()等函数。

#### 查看UDAF介绍

sum函数就是一个UDAF---简单实惠，好用不贵！
```
hive> describe function sum;
OK
sum(x) - Returns the sum of a set of numbers
Time taken: 0.007 seconds, Fetched: 1 row(s)
```

#### 测试内建UDAF

```
hive> select a from primitive_dataytpes_example;
OK
123
NULL
-1
hive> select sum(a) from primitive_dataytpes_example;
Query ID = hadoop_20150819044201_XXXX
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1438392006960_0012, Tracking URL = http://node50064.mryqu.com:8088/proxy/application_1438392006960_0012/
Kill Command = /usr/local/hadoop/bin/hadoop job  -kill job_1438392006960_0012
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2015-08-19 04:42:47,272 Stage-1 map = 0%,  reduce = 0%
2015-08-19 04:42:54,771 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.44 sec
2015-08-19 04:43:54,907 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.44 sec
2015-08-19 04:44:55,668 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.44 sec
2015-08-19 04:45:56,611 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 1.44 sec
2015-08-19 04:46:20,327 Stage-1 map = 100%,  reduce = 67%, Cumulative CPU 7.87 sec
2015-08-19 04:46:28,516 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 16.81 sec
MapReduce Total cumulative CPU time: 16 seconds 810 msec
Ended Job = job_1438392006960_0012
MapReduce Jobs Launched:
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 16.81 sec   HDFS Read: 9201 HDFS Write: 4 SUCCESS
Total MapReduce CPU Time Spent: 16 seconds 810 msec
OK
122
Time taken: 268.746 seconds, Fetched: 1 row(s)
```

#### UDAF实现

Hive允许两种UDAF：简单UDAF和通用UDAF。
- 简单UDAF，显而易见更好好实现，但是由于使用了Java反射技术造成性能下降，并且不接受可变长参数等特性。简单UDAF需要继承org.apache.hadoop.hive.ql.exec.UDAF类，并实现一个或多个UDAFEvaluator接口的静态内部类。在运行时，Hive使用反射查找匹配接受参数的UDAFEvaluator，这会降低作业性能，但是易于实现。![[Hive] Hive 表UDTF和汇聚UDAF学习](/images/2015/8/0026uWfMzy7aPTzjvNtef.png)percentile函数的实现类UDAFPercentile就是一个简单UDAF。
- 通用UDAF可以接受所有特性，但是不如简单UDAF实现的那么直观。
  要实现一个通用UDAF，需要实现resolver类和evaluator类。resolver负责类型检查，操作符重载，通过输入参数类型发现正确的evaluator。evaluator真正实现UDAF的逻辑。通常来说，顶层UDAF类实现org.apache.hadoop.hive.ql.udf.GenericUDAFResolver接口(GenericUDAFResolver2接口继承自GenericUDAFResolver接口，AbstractGenericUDAFResolver抽象类实现了GenericUDAFResolver2接口)，重写getEvaluator(TypeInfo[]parameters)或getEvaluator(GenericUDAFParameterInfoparamInfo)方法实现以返回给Hive正确的evalutor，实现较复杂，但相对反射更加高效。顶层UDAF类中实现一个或多个GenericUDAFEvaluator接口的静态内部类evaluator实现UDAF的逻辑。
  所有的evaluator都必须继承自抽线类GenericUDAFEvaluator，该类提供了一些扩展类必须实现的抽象方法。

|方法|介绍
|------
|init|由Hive调用以初始化你的UDAF类实例
|getNewAggregationBuffer|返回用于存储临时汇聚结果的对象
|iterate|将一行新数据传给汇聚缓冲区
|terminatePartial|以可持久化的方式返回当前汇聚内容。持久化在这里意指返回值只能为Java原始类型、数组、原始包装类型（例如Double）及HadoopWritable、List、Map。不可以使用自己定义的类（即使实现Serializable）。
|merge|将terminatePartial返回的局部汇聚合并到当前汇聚
|terminate|将最终汇聚结果返回Hive

通用UDAF的例子很多，例如sum函数的实现类GenericUDAFSum、count函数的实现类GenericUDAFCount......

下面通过GenericUDAFSum对照参考五[Hive Generic UDAF Case Study](https://cwiki.apache.org/confluence/display/Hive/GenericUDAFCaseStudy)学习一下UDAF实现。
- GenericUDAFSum继承了抽象类AbstractGenericUDAFResolver。
- GenericUDAFSum类中首先构建一个Log对象用于往Hive日志写告警和错误消息。
- GenericUDAFSum类重写的两个getEvaluator方法，会收到UDAF被调用时的SQL参数信息，进行类型检查和选出evaluator工作：
  1. 首先我们检查是否为一个参数，不是的话抛出异常；
  2. 接着检查参数所对应的SQL类型为原始类型，不是的话抛出异常；
  3. 如果SQL类型为BYTE、SHORT、INT、LONG之一的话，返回GenericUDAFSumLongevalutor实例；
  4. 如果SQL类型为TIMESTAMP、FLOAT、DOUBLE、STRING、VARCHAR、CHAR之一的话，返回GenericUDAFSumDoubleevalutor实例；
  5. 如果SQL类型为DECIMAL的话，返回GenericUDAFSumHiveDecimal evalutor实例；
  6. 如果SQL类型不是上述类型的话，抛出异常。
- 这里以GenericUDAFSumDouble为例介绍一下evaluator 。
  - init方法中初始化result为0，通知输出列类型为writableDouble；
  - iterate方法中将输入行相应单元格数值加入汇聚缓冲区的sum；
  - merge方法中将局部汇聚值加入当前汇聚缓冲区的sum；
  - terminate返回当前汇聚缓冲区的sum
  - terminatePartial（GenericUDAFSumEvaluator类）通过调用terminate返回当前汇聚缓冲区的sum

### 参考

[Hive Operators and User-Defined Functions (UDFs)](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF)  
[Hive Plugins](https://cwiki.apache.org/confluence/display/Hive/HivePlugins)  
[Hive Data Definition Language - Create/Drop/Reload Function](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-CreateFunction)  
[Hive Developer Guide - UDTF](https://cwiki.apache.org/confluence/display/Hive/DeveloperGuide+UDTF)  
[Hive Generic UDAF Case Study](https://cwiki.apache.org/confluence/display/Hive/GenericUDAFCaseStudy)  
[Apache Hive Customization Tutorial Series](http://blog.matthewrathbone.com/2015/07/27/ultimate-guide-to-writing-custom-functions-for-hive.html)  