---
title: '[Hadoop] MapReduce输出SequenceFile实践'
date: 2014-01-01 23:19:23
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- mapreduce
- output
- format
- sequencefile
---
Hadoop的Mapper输出默认格式为SequenceFile，而Reducer默认输出则为TextFile。在一个MapReduce工作流中，经常有多个MapReduce作业级联完成应用功能。如果中间MapReduce是输入输出都为SequenceFile，则性能很可能获得很大提升。
SequenceFile文件是Hadoop用来存储二进制形式的键值对而设计的一种平面文件(FlatFile)。SequenceFile可压缩可切分,非常适合Hadoop文件存储特性，SequenceFile的写入由org.apache.hadoop.io.SequenceFile.Writer来实现，根据压缩类型Writer又派生出两个子类BlockCompressWriter和RecordCompressWriter，压缩方式由SequenceFile类的内部枚举类CompressionType来表示：
- NONE: 对记录不进行压缩;
- RECORD: 仅压缩每一个记录中的值;
- BLOCK: 将一个块中的所有记录压缩在一起;

### 输入SequenceFile示例

```
job.setInputFormatClass(SequenceFileInputFormat.class);
```

### 输出SequenceFile示例

![[Hadoop] MapReduce输出SequenceFile实践](/images/2014/1/0026uWfMzy78TZTFMTP8d.png)