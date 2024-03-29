---
title: '[Hadoop] 处理跨块边界的InputSplit'
date: 2014-01-02 07:50:10
categories: 
- BigData
tags: 
- hadoop
- inputformat
- inputsplit
- recordreader
---
Mapper从HDFS中读取文件进行数据处理的。凭借InputFormat、InputSplit、RecordReader、LineReader等类，Mapper用户代码可以处理输入键值对进行数据处理。下面学习一下MapReduce是如何分割无压缩文本文件输入的。

涉及的类有：
- InputFormat及其子类![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78Kl76P5W5c.png)InputFormat类执行下列操作：
  - 检验作业的输入文件和目录是否存在。
  - 将输入文件分割策划功能InputSlit，基于文件的InputFormat根据文件大小将文件分割为逻辑上的Split。
  - 实例化用于对每个文件分割块解析记录的RecordReaderInputFormat类包括下列两个主要的子类：
  - TextInputFormat：用于解析文本文件。将文件按行生成记录；键为LongWritable，文件偏移量；值为Text，行的内容。
  - SequenceFileInputFormat：用于解析Hadoop压缩二进制文件。SequenceFile可为无压缩、记录压缩或块压缩。与TextInputFormat不同，SequenceFileInputFormat的键值对是泛型的。
- InputSplit及其子类![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78Kled9SDb7.png)InputSplit是单个Mapper所要处理的数据子集逻辑表现形式。每个InputSplit很可能不会包含完整记录数，即在输入分割中首尾记录有可能是不完整的，处理全部记录由RecordReader负责。InputSplit的子类包括：
  - FileSplit代表输入文件的GetLength()大小的一个片段。FileSplit由InputFormat.getSplits(JobContext)调用返回，并传给InputFormat类用于实例化RecordReader。
  - CombineFileSplit将多个文件并入一个分割内（默认每个文件小于分割大小）
- RecordReader及其子类![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78KlnWUdg96.png)RecordReader将输入分割片内的数据分析成Mapper所要处理的键值对。记录跟分割边界/块边界不一定匹配，RecordReader判断记录位置并处理日志边界。RecordReader包括下列子类：
  - LineRecordReader：处理文本文件。
  - SequenceFileRecordReader：处理Sequence文件。
- LineReader：用于对文件进行读取操作、分析行并获得键值对。

处理的具体流程如下：
- [ FileInputFormat](https://github.com/apache/hadoop/blob/branch-2.2.0/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapreduce/lib/input/FileInputFormat.java).getSplits(JobContext)方法主要完成计算InputSplit的工作。
  - 首先判断输入文件是否可被分割的。如果文件流没有被压缩或者使用bzip2这种可分割的压缩算法，则文件可被分割；否则整个文件作为一个InputSplit。
  - 如果文件可被分割的话，分割尺寸为max( max( 1,mapreduce.input.fileinputformat.split.minsize), min(mapreduce.input.fileinputformat.split.maxsize, blockSize))。如果没有对分割最小/大值进行设置的话，则分割尺寸即等于块大小，而块大小默认为64MB。
  - 文件按照上述分割尺寸分割记录文件路径、每一分割的起始偏移量、分割块实际尺寸、输入文件所在机器。只要文件剩余数据量在1.1倍分割尺寸范围内，就会放到一个InputSplit中。![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78KAfdADMba.png)
- [ LineRecordReader](https://github.com/apache/hadoop/commits/branch-2.2.0/hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core/src/main/java/org/apache/hadoop/mapreduce/lib/input/LineRecordReader.java)主要完成从InputSplit获取键值对的工作。
  - LineRecordReader构造方法获知行分隔符是否为定制分割符；
  - initialize(InputSplit,TaskAttemptContext)方法获知InputSplit的start和end(=start+splitLength)，如果start不为0的话，跳过第一行（不用管第一行是否完整）。即处理上一InputSplit的RecordReader处理本InputSplit的第一行，处理本InputSplit的RecordReader处理下一个InputSplit的第一行。
  - nextKeyValue()方法处理第一个InputSplit，需要跳过可能存在的UTF BOM。![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78KIBGCNHa1.png)
- [ LineReader](https://github.com/apache/hadoop/blob/branch-2.2.0/hadoop-common-project/hadoop-common/src/main/java/org/apache/hadoop/util/LineReader.java)主要完成从从文件输入流获取数据、如没有定制换行符则需判别CR/LF/CRLF换行符，并获得键值对。![[Hadoop] 处理跨块边界的InputSplit](/images/2014/1/0026uWfMzy78M0FIjYr1f.png)

以上类都不涉及对HDFS文件和块的实际读操作，本地和远程读取可学习org.apache.hadoop.hdfs.client.HdfsDataInputStream、org.apache.hadoop.hdfs.DFSInputStream等类的代码。

### 参考

[How does Hadoop process records split across block boundaries?](http://stackoverflow.com/questions/14291170/how-does-hadoop-process-records-split-across-block-boundaries)    