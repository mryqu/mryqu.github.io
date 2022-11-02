---
title: '[Hadoop] 源码分析mapred.mapper.new-api/mapred.reducer.new-api设置与区别'
date: 2013-10-14 20:06:53
categories: 
- BigData
tags: 
- hadoop
- mapreduce
- mapper
- reducer
- new-api
---
即[mapred和mapreduce包的区别](/post/hadoop_mapred和mapreduce包的区别)后，本文再次从源码角度分析新老API（mapred.mapper.new-api/ mapred.reducer.new-api）的设置与区别。
mapred.mapper.new-api /mapred.reducer.new-api这两个参数很少显式去设置，默认为false，即使用mapred包下的老API。
不过MapReduce框架也会去自动识别应该使用老API还是新API。作业提交有两种方式，异步方式用submit，同步方式用waitForCompletion。不过org.apache.hadoop.mapreduce.Job.waitForCompletion(boolean)里调用了org.apache.hadoop.mapreduce.Job.submit()方法，submit方法又调用了org.apache.hadoop.mapreduce.Job.setUseNewAPI()方法。setUseNewAPI方法里面对新老API做了判断：
- 是否设置了mapred.mapper.class属性，则mapred.mapper.new-api为true，否则为false。说白了就是用org.apache.hadoop.mapreduce.Job.setMapperClass(Class)还是org.apache.hadoop.mapred.JobConf.setMapperClass(Class)设置的Mapper，前者设置的是mapreduce.job.map.class属性，后者设置的是mapred.mapper.class属性。
- 如果mapreduce.job.reduces属性值不为0，则看是否设置了mapred.reducer.class属性，则mapred.reducer.new-api为true，否则为false。说白了就是用org.apache.hadoop.mapreduce.Job.setReducerClass(Class)还是org.apache.hadoop.mapred.JobConf.setReducerClass(Class)设置的Mapper，前者设置的是mapreduce.job.reducer.class属性，后者设置的是mapred.reducer.class属性。

#### new-api相关区别

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>使用new-api</th><th>不使用new-api</th></tr><tr><td>不允许设置下列属性：<br><ul><li>mapred.input.format.class</li><li>mapred.mapper.class</li><li>mapred.partitioner.class</li><li>mapred.reducer.class</li><li>mapred.output.format.class</li></ul></td><td>不允许设置下列属性：<br><ul><li>mapreduce.job.inputformat.class</li><li>mapreduce.job.map.class</li><li>mapreduce.job.partitioner.class</li><li>mapreduce.job.reducer.class</li><li>mapreduce.job.outputformat.class</li></ul></td></tr><tr><td>使用下列类或接口的实现：<br><ul><li>o.a.h.conf.Configuration</li><li>o.a.h.mapreduce.Mapper抽象类</li><li>o.a.h.mapreduce.Reducer抽象类</li><li>o.a.h.mapreduce.OutputFormat抽象类</li><li>o.a.h.mapreduce.OutputCommitter抽象类</li><li>o.a.h.mapreduce.TaskID</li><li>o.a.h.mapreduce.TaskAttemptID</li><li>o.a.h.mapreduce.TaskAttemptContext接口</li><li>o.a.h.mapreduce.InputFormat抽象类</li><li>o.a.h.mapreduce.InputSplit抽象类</li></ul></td><td>使用下列类或接口的实现：<br><ul><li>o.a.h.mapred.JobConf</li><li>o.a.h.mapred.Mapper接口</li><li>o.a.h.mapred.Reducer接口</li><li>o.a.h.mapred.OutputFormat接口</li><li>o.a.h.mapred.OutputCommitter抽象类</li><li>o.a.h.mapred.TaskID</li><li>o.a.h.mapred.TaskAttemptID</li><li>o.a.h.mapred.TaskAttemptContext接口</li><li>o.a.h.mapred.InputFormat接口</li><li>o.a.h.mapred.InputSplit接口</li></ul></td></tr><tr><td>使用方法：<br><ul><li>o.a.h.mapred.MapTask.runNewMapper</li><li>o.a.h.mapreduce.JobSubmitter.writeNewSplits</li><li>o.a.h.mapred.ReduceTask.runNewReducer</li></ul></td><td>使用方法：<br><ul><li>o.a.h.mapred.MapTask.runOldMapper</li><li>o.a.h.mapreduce.JobSubmitter.writeOldSplits</li><li>o.a.h.mapred.ReduceTask.runOldReducer</li></ul></td></tr></tbody></table>
