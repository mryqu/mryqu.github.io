---
title: '[Hive] Hive表文件存储格式'
date: 2015-08-14 06:25:23
categories: 
- BigData
tags: 
- hive
- ddl
- table
- storage
- format
---
Hive支持的内建表文件存储格式如下：

|存储格式|介绍
|-----
|TEXTFILE|按照纯文本文件格式存储。如果配置hive.default.fileformat没有设置的话，TEXTFILE是默认文件格式。<br>此存储格式下，数据不做压缩的话，磁盘开销大，数据解析开销大。使用Gzip、Bzip2、Snappy等进行压缩使用（系统自动检查，执行查询时自动解压）的话，Hive不能对数据进行切分，从而无法对数据进行并行操作。
|SEQUENCEFILE|按照压缩的Sequence File格式存储。<br>SequenceFile一般是在HDFS FileSystem中生成，供map调用的原始文件。Hive中的SequenceFile继承自Hadoop API 的SequenceFile，不过它的key为空，使用value存放实际的值，这样是为了避免MR在运行map阶段的排序过程。
|RCFILE|按照RCFile (Record Columnar File)格式存储。<br>在Hive0.6.0引入。RCFile是在计算机集群中判断如何存储关系型表的数据存放结构，是Facebook、俄亥俄州立大学、中科院计算所联合研究成果。FCFile结构是由数据存储格式、数据压缩方式、数据读取优化技术等多种模块的系统组合，可以实现数据存放的四个要求：(1)快速加载，(2) 快速处理查询，(3) 高效利用存储空间 (4) 非常适用于动态数据访问模式。<br>它遵循“先按行划分，再垂直划分”的设计理念。当查询过程中，针对它并不关心的列时，它会在IO上跳过这些列。需要说明的是，RCFile在map阶段从远端拷贝仍然是拷贝整个数据块，并且拷贝到本地目录后RCFile并不是真正直接跳过不需要的列，并跳到需要读取的列，而是通过扫描每一个row group的头部定义来实现的，但是在整个HDFS Block 级别的头部并没有定义每个列从哪个rowgroup起始到哪个row group结束。所以在读取所有列的情况下，RCFile的性能反而没有SequenceFile高。
|ORC|在Hive 0.11.0引入。ORC(Optimized RowColumnar)存储源自于RCFile。FCFile把每列都当作二进制blob处理，而ORC存储列元数据，针对列类型使用特定的读写器。ORC支持ACID、内建索引和复杂类型。官网上介绍“其性能显著快于RCFile或Parquet”。Facebook和Yahoo等大公司都在使用。
|PARQUET|在Hive 0.13.0引入。Parquet源自于google Dremel系统。Parquet最初的设计动机是存储嵌套式数据，将这类数据存储成列式格式，以方便对其高效压缩和编码，且使用更少的IO操作取出需要的数据，这也是Parquet相比于ORC的优势，它能够透明地将Protobuf和thrift类型的数据进行列式存储，在Protobuf和thrift被广泛使用的今天，与parquet进行集成，是一件非容易和自然的事情。除了上述优势外，相比于ORC,Parquet没有太多其他可圈可点的地方，比如它不支持update操作（数据写成后不可修改），不支持ACID等。
|AVRO|在Hive 0.13.0引入。Avro是数据序列化系统，由Hadoop项目开发的。


### 测试

```
$ echo -e '1\x01foo' > tabft.txt
$ echo -e '2\x01bar' >> tabft.txt

$ hive

hive> create table tabft (id int, name string);
hive> quit;

$ hadoop fs -put tabft.txt /user/hive/warehouse/tabft
$ hive

hive> create table tabft_txt (id int, name string) STORED AS TEXTFILE;
hive> insert into table tabft_txt select * from tabft;

hive> create table tabft_seq (id int, name string) STORED AS SEQUENCEFILE;
hive> insert into table tabft_seq select * from tabft;

hive> create table tabft_rc (id int, name string) STORED AS RCFILE;
hive> insert into table tabft_rc select * from tabft;

hive> create table tabft_orc (id int, name string) STORED AS ORC;
hive> insert into table tabft_orc select * from tabft;

hive> create table tabft_parq (id int, name string) STORED AS PARQUET;
hive> insert into table tabft_parq select * from tabft;

hive> create table tabft_avro (id int, name string) STORED AS AVRO;
hive> insert into table tabft_avro select * from tabft;
```

#### 获取Sequence文件信息

![[Hive] Hive表文件存储格式](/images/2015/8/0026uWfMzy78d0KTye85c.png)
在我的环境下，按照压缩的Sequence File格式存储后的文件是非压缩的。
![[Hive] Hive表文件存储格式](/images/2015/8/0026uWfMzy78cRQJQSm32.png)

#### 获取ORC文件信息

![[Hive] Hive表文件存储格式](/images/2015/8/0026uWfMzy78bBBaxLu24.jpg)

### 参考

[Hive 语言手册 - DDL](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL)  
[Hadoop WIKI：SequenceFile](https://wiki.apache.org/hadoop/SequenceFile)  
[SequenceFile文件](http://blog.csdn.net/xhh198781/article/details/7693358)  
[WIKI：RCFile](https://en.wikipedia.org/wiki/RCFile)  
[Apache ORC官网](https://orc.apache.org/)  
[Orcfile文件格式解析（1）](http://www.cppblog.com/whspecial/archive/2013/08/14/202544.html)  
[Apache Parquet官网](https://parquet.apache.org/)  
[Apache Avro官网](https://avro.apache.org/)  
[Hive文件存储格式的测试比较](http://yugouai.iteye.com/blog/1851606)  
[大数据开源列式存储引擎Parquet和ORC](http://dongxicheng.org/mapreduce-nextgen/columnar-storage-parquet-and-orc/)  