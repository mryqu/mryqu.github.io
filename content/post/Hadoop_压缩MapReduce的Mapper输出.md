---
title: '[Hadoop] 压缩MapReduce的Mapper输出'
date: 2014-03-03 20:13:37
categories: 
- BigData
tags: 
- hadoop
- mapreduce
- mapper
- output
- compression
---
### 介绍

压缩map输出是以压缩和解压缩的CPU消耗为代价来减少磁盘和网络IO开销。Hadoop中，mapper的输出数据是写到Mapper所在的本地磁盘的，并以网络传输的方式传送到Reducer所在的节点上。mapreduce.map.output.compress默认为false，即不对map输出进行压缩。如果中间数据不是二进制的，通常建议使用map输出压缩。

Hadoop支持的的内建压缩编码如下：
![[Hadoop] 压缩MapReduce的Mapper输出](/images/2014/3/0026uWfMzy78QLla46Kd2.png)
如果设置mapreduce.map.output.compress为true且没有设置mapreduce.map.output.compression.codec的话，默认使用org.apache.hadoop.io.compress.DefaultCodec。

|压缩格式|算法|工具|默认扩展名|说明
|-----
|DEFLATE|DEFLATE|N/A|.deflate|DEFLATE是一种压缩算法，标准实现是zlib，尚没有命令行工具支持。文件扩展名.deflate是一个Hadoop的约定。所有的压缩算法都存在空间与时间的权衡：更快的压缩速率和解压速率是以牺牲压缩率为代价的。org.apache.hadoop.io.compress.zlib.ZlibCompressor.CompressionLevel中定义了0~9压缩级别，0为无压缩，9为最佳压缩。支持Java实现和原生库实现。
|GZip|DEFLATE|gzip|.gz|GZip与DEFLATE使用同样的压缩算法，不过相对于DEFLATE压缩格式增加了额外的头部和尾部。GZip是一种常规的压缩工具，空间与时间得到很好的权衡。支持Java实现和原生库实现。
|BZip2|[BZip2](http://www.bzip2.org/)|BZip2|.bz2|BZip2压缩率高于GZip，但压缩速度较慢；解析速度优于它的压缩速度，但还是较其它压缩算法偏慢。由上图可知，BZip2是Hadoop内嵌压缩算法中唯一可以被分割的，这样一个输入文件可分成多个InputSplit，便于本地数据加载并被Mapper处理。相关技术可见[处理跨块边界的InputSplit](/post/hadoop_处理跨块边界的inputsplit)一文。支持Java实现和原生库实现。
|LZ4|[LZ4](https://github.com/lz4/lz4)|N/A|.lz4|LZ4和Snappy相对于GZip压缩速度得到很大提升，但没有GZip的压缩率高。仅支持原生库实现。org.apache.hadoop.io.compress.Lz4Codec.isNativeCodeLoaded()用于检查是否加载原生库，其调用者在没有加载原生库时会抛异常。
|Snappy|[Snappy](http://google.github.io/snappy/)|N/A|.snappy|LZ4和Snappy相对于GZip压缩速度得到很大提升，但没有GZip的压缩率高。仅支持原生库实现。org.apache.hadoop.io.compress.SnappyCodec.checkNativeCodeLoaded()在没有加载原生库时会抛异常。

如果使用原生库压缩编码，需配置LD_LIBRARY_PATH。默认情况下，Hadoop自动在本地库路径（java.library.path）下查询并加载合适的本地库实现。通过设置属性io.native.lib.available为false禁用原生库，此时内建的Java实现将被使用。

### Hadoop源码分析

在org.apache.hadoop.mapred.MapTask.MapOutputBuffer.init(Context)和org.apache.hadoop.mapred.ReduceTask.initCodec()方法中检查mapreduce.map.output.compress属性，如果为true，则加载mapreduce.map.output.compression.codec属性所设的压缩编解码器。
MapTask当将数据spill到硬盘时使用压缩编码器进行数据压缩。
ReduceTask在使用Shuffle结果是使用压缩解码器进行数据解压缩。

### 使用map输出压缩的应用示例

![[Hadoop] 压缩MapReduce的Mapper输出](/images/2014/3/0026uWfMzy78S3IGJoZ51.png)
