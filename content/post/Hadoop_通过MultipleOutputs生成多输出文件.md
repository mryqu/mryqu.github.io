---
title: '[Hadoop] 通过MultipleOutputs生成多输出文件'
date: 2014-09-29 18:39:27
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- mapreduce
- multipleoutputs
- 源码分析
- 示例
---
即前一博文[[Hadoop] 通过MultipleInputs处理多输入文件](/post/hadoop_通过multipleinputs处理多输入文件)展示如何处理MapReduce多输入问题，本文将展示一下如何处理MapReduce多输出的方法。

### MultipleOutputs示例

#### MultipleOutputsDemo.java源码

![[Hadoop] 通过MultipleOutputs生成多输出文件](/images/2014/9/0026uWfMzy79EaCfa4M78.jpg)

#### Scores.txt

```
Tomas,100
Edward,81
Henry,59
Gordon,60
James,97
Percy,93
Toby,77
Emily,87
Duke,68
Donald,47
Douglas,35
```

#### 执行

```
hadoop jar YquMapreduceDemo.jar MultipleOutputsDemo /user/hadoop/mos_input/scores.txt /user/hadoop/mos_output
```

#### 测试结果

![[Hadoop] 通过MultipleOutputs生成多输出文件](/images/2014/9/0026uWfMzy79E9QCUVp37.jpg)

### MultipleOutputs分析

#### 普通Driver

|API|Job属性
|-----
|Job.setOutputFormatClass|mapreduce.job.outputformat.class示例：org.apache.hadoop.mapreduce.lib.output.TextOutputFormat
|Job.setOutputKeyClass|mapreduce.job.output.key.class示例：org.apache.hadoop.io.Text
|Job.setOutputValueClass|mapreduce.job.output.value.class示例：org.apache.hadoop.io.IntWritable

#### 使用MultipleOutputs的Driver

|API|Job属性
|-----
|MultipleOutputs.addNamedOutput|mapreduce.multipleoutputs<br>示例：pass fail<br>mapreduce.multipleoutputs.namedOutput.pass.format<br>示例：org.apache.hadoop.mapreduce.lib.output.TextOutputFormat<br>mapreduce.multipleoutputs.namedOutput.pass.key<br>示例：org.apache.hadoop.io.NullWritable<br>mapreduce.multipleoutputs.namedOutput.pass.value<br>示例：org.apache.hadoop.io.Text<br>mapreduce.multipleoutputs.namedOutput.fail.format<br>示例：org.apache.hadoop.mapreduce.lib.output.TextOutputFormat<br>mapreduce.multipleoutputs.namedOutput.fail.key<br>示例：org.apache.hadoop.io.NullWritable<br>mapreduce.multipleoutputs.namedOutput.fail.value<br>示例：org.apache.hadoop.io.Text

通过调用org.apache.hadoop.mapreduce.lib.output.MultipleOutputs.write方法，根据相应NamedOutput相应的OutputFormat、OutputKeyClass和OutputValueClass创建NamedOutput自己的RecordWriter，完成相应的输出。
