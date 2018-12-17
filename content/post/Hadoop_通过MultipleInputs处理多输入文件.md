---
title: '[Hadoop] 通过MultipleInputs处理多输入文件'
date: 2014-09-29 06:35:57
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- mapreduce
- multipleinputs
- 源码分析
- 示例
---
一般MapReduce程序仅处理一个输入文件，但当我们必须处理多个输入文件时，普通MapReduce方法就无能为力了，这时候可以使用org.apache.hadoop.mapreduce.lib.input.MultipleInputs类搞定这一问题。

### MultipleInputs示例

#### MultipleInputsDemo.java源码
![[Hadoop] 通过MultipleInputs处理多输入文件](/images/2014/9/0026uWfMzy79A4n2gx3a1.jpg)
#### people.txt
```
1,Tomas,1
2,Edward,2
3,Henry,3
4,Gordon,4
5,James,4
6,Percy,3
7,Toby,2
8,Emily,1
9,Duke,3
10,Donald,3
11,Douglas,3
```

#### locations.txt
```
1,China
2,USA
3,Canada
4,New Zealand
```

#### 执行
```
hadoop jar YquMapreduceDemo.jar MultipleInputsDemo /user/hadoop/mijoin/people.txt /user/hadoop/mijoin/locations.txt /user/hadoop/mijoin_output
```

#### 测试结果
![[Hadoop] 通过MultipleInputs处理多输入文件](/images/2014/9/0026uWfMzy79A4xWbDae8.png)
### MultipleInputs分析

#### 与普通Driver的区别

##### 普通Driver

|API|Job属性
|---
|FileInputFormat.addInputPath|mapreduce.input.fileinputformat.inputdir<br>示例：/user/hadoop/wordcount/book.txt
|Job.setMapperClass|mapreduce.job.map.class<br>示例：WordCount.TokenizerMapper
|Job.setInputFormatClass|mapreduce.job.inputformat.class<br>示例：org.apache.hadoop.mapreduce.lib.input.TextInputFormat

##### 使用MultipleInputs的Driver

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>API</th><th>Job属性</th></tr><tr><td rowspan="4">MultipleInputs.addInputPath</td><td>mapreduce.input.multipleinputs.dir.formats<br>示例：/user/hadoop/mijoin/people.txt:o.a.h.m.l.i.TextInputFormat,<br>/user/hadoop/mijoin/locations.txt:o.a.h.m.l.i.TextInputFormat</td></tr><tr><td>mapreduce.input.multipleinputs.dir.mappers<br>示例：/user/hadoop/mijoin/people.txt:MultipleInputsDemo.PersonMapper,<br>/user/hadoop/mijoin/locations.txt:MultipleInputsDemo.LocationMapper</td></tr><tr><td>mapreduce.job.inputformat.class<br>示例：org.apache.hadoop.mapreduce.lib.input.DelegatingInputFormat</td></tr><tr><td>mapreduce.job.map.class<br>示例：org.apache.hadoop.mapreduce.lib.input.DelegatingMapper</td></tr></tbody></table>

由上可见，MultipleInputs方法不设置mapreduce.input.fileinputformat.inputdir属性，将mapreduce.job.inputformat.class和mapreduce.job.map.class属性设为多输入的委托类，增加了两个专用的属性mapreduce.input.multipleinputs.dir.formats和mapreduce.input.multipleinputs.dir.mappers已用于映射每一输入文件的格式和mapper类。

#### 调用每个输入文件的FileFormat
![[Hadoop] 通过MultipleInputs处理多输入文件](/images/2014/9/0026uWfMzy79A5fQD4mda.png)
#### 调用每个输入文件的Mapper
![[Hadoop] 通过MultipleInputs处理多输入文件](/images/2014/9/0026uWfMzy79A5ub0EY54.jpg)
#### 示例流程
![[Hadoop] 通过MultipleInputs处理多输入文件](/images/2014/9/0026uWfMzy79Aas39X056.jpg)