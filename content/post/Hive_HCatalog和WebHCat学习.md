---
title: '[Hive] HCatalog和WebHCat学习'
date: 2015-07-29 05:39:31
categories: 
- BigData
tags: 
- hive
- hcatalog
- cli
- webhcat
- 元数据服务
---
### HCatalog

访问数据的常见方法之一是通过表抽象，该方法通常用于访问关系型数据库，并且为许多开发者所熟知(和广泛采用)。一些流行的Hadoop系统，例如Hive和Pig，也采用了这种方法。这种抽象解除了数据如何存储(HDFS文件、HBase表)与应用程序如何处理数据(表格式)之间的耦合。此外，它允许从较大的数据语料库中"过滤"感兴趣的数据。
Hadoop的元数据服务HCatalog扩展了Hive的元存储，同时保留了HiveDDL中用于表定义的组件。其结果是，Hive的表抽象(当使用了HCatalog时)可以用于Pig和MapReduce应用程序，这带来了以下一些主要优势：

- 它使得数据消费者不必知道其数据存储的位置和方式。
- 它允许数据生产者修改物理数据存储和数据模型，同时仍然支持以旧格式存储的现有数据，从而数据消费者不需要修改他们的处理流程。
- 它为Pig、Hive和MapReduce提供了共享的结构和数据模型。

HCatalog支持读写任何SerDe支持的文件格式。默认情况下，HCatalog支持RCFile、CSV、JSON、SequenceFile和ORC文件格式。如果使用订制格式，必须提供InputFormat、OutputFormat和SerDe。
![[Hive] HCatalog和WebHCat学习](/images/2015/7/0026uWfMzy7b5vDB6jG04.jpg)

### WebHCat

WebHCat是WebHCat的REST API。这样应用无需使用Hadoop API就可以通过HTTP请求访问HadoopMapReduce (或YARN)、Pig、Hive及HCatalog DDL。WebHCat所使用的代码和数据必须存放在HDFS中。HCatalogDDL命令在请求后即直接执行，MapReduce、Pig和Hive作业则放置在WebHCat(Templeton)服务器的队列中，并监控进展过程或按需停止。程序员指定Pig、Hive和MapReduce结果存放的HDFS位置。
![[Hive] HCatalog和WebHCat学习](/images/2015/7/0026uWfMzy7b5w3cB36e4.jpg)

### 使用

HCatalog和WebHCat都已随Hive安装，所以可以直接使用

#### 使用HCatalog

HCatalog CLI与Hive CLI功能大致一样：
```
cd $HIVE_HOME
./hcatalog/bin/hcat
```

![[Hive] HCatalog和WebHCat学习](/images/2015/7/0026uWfMzy7b5I1LPso84.png)

#### 使用WebHCat

在.bashrc中添加PYTHON_CMD：
```
export PYTHON_CMD=/usr/bin/python
```

启动WebHCat服务器：
```
cd $HIVE_HOME
./hcatalog/sbin/webhcat_server.sh start
```

![[Hive] HCatalog和WebHCat学习](/images/2015/7/0026uWfMzy7b5K79VyD6f.png)

### 参考

[HCatalog](https://cwiki.apache.org/confluence/display/Hive/HCatalog)  
[HCatalog CLI](https://cwiki.apache.org/confluence/display/Hive/HCatalog+CLI)  
[WebHCat](https://cwiki.apache.org/confluence/display/Hive/WebHCat)  
[GitHub: apache/hcatalog](https://github.com/apache/hcatalog)  
[GitHub: apache/hive/hcatalog](https://github.com/apache/hive/tree/master/hcatalog)  
[apache/hive/hcatalog/webhcat](https://github.com/apache/hive/tree/master/hcatalog/webhcat)  