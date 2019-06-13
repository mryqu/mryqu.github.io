---
title: '了解Apache Accumulo'
date: 2015-03-10 20:12:08
categories: 
- db+nosql
tags: 
- apache
- accumulo
- nosql
- gemfire
- mongodb
---
[Apache Accumulo](https://accumulo.apache.org/)是一个可靠的、可伸缩的、高性能的排序分布式的Key-Value存储解决方案，提供了基于单元的访问控制以及可在数据处理过程中多个控制点修改键值对的服务器端编程机制。使用Google[BigTable](http://research.google.com/archive/bigtable.html)设计思路，基于Apache[Hadoop](http://hadoop.apache.org/)、[Zookeeper](http://zookeeper.apache.org/)和[Thrift](http://thrift.apache.org/)构建。
Accumulo由美国国家安全局（NSA）于2008年开始研发，2011年捐赠给Apache基金会。Accumulo现已成为Apache基金会的顶级项目，并被评过第三大最受欢迎的NoSQL数据库引擎。
目前，Accumulo技术已经得到美国政府层面的全面认可，NSA已将该技术作为内部组织架构运行的核心部分，在对来源于各方面的庞大海量数据进行分析处理时，所应用的运算程序基本都运行在Accumulo技术上，即NSA“大多数监控和分析应用程序的后台都是Accumulo技术”。基于Hadoop的Accumulo技术已在实质上被视为美国国家安全战略的关键。
据2014年9月份的文章介绍，已经有几十家不同类型的美国企业安装了Accumulo技术系统，其中，美国20强企业中已有3家安装，50强企业中有5家安装，还有不少企业已表示对此有兴趣。
我一碰到KV存储方案，总想跟我用过的GemFire和MongoDB做个比较。[vsChart.com - The Comparision Wiki](http://vschart.com/)上已经有现成的比较(见参考3和4)，值得学习。

### 参考

- [Apache Accumulo官网](https://accumulo.apache.org/)  
- [Accumulo: Why The World Needs Another NoSQL Database](http://wikibon.org/blog/breaking-analysis-accumulo-why-the-world-needs-another-nosql-database/)  
- [Apache Accumulo vs. GemFire](http://vschart.com/compare/apache-accumulo/vs/gemfire)  
- [Apache Accumulo vs. MongoDB](http://vschart.com/compare/apache-accumulo/vs/mongodb)  
- [NOSQL中文网：Apache Accumulo用户手册](http://www.nosqldb.cn/1373093083484.html)  