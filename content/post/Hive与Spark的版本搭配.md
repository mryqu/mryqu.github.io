---
title: 'Hive与Spark的版本搭配'
date: 2016-08-02 05:46:59
categories: 
- Hadoop+Spark
- Spark
tags: 
- hive
- spark
- version
- compatibility
---
[ Hive on Spark: Getting Started](https://cwiki.apache.org/confluence/display/Hive/Hive+on+Spark:+Getting+Started)里面介绍了如果Hive的查询引擎选择Spark的话，Hive所需相关配置。如果用一个不兼容的Hive和Spark版本，有潜在风险，例如Spark2就没有spark-assembly-\*.jar可供低版本Hive使用。
问题来了，么查找已测试的Hive和Spark版本对呢？
网上有人说看Hive代码根路径下的pom.xml。例如[Hive branch-1.2中pom.xml](https://github.com/apache/hive/blob/branch-1.2/pom.xml)包含spark.version为1.3.1，这说明官方在进行Hive1.2.0测试时用的Spark 1.3.1。
此外，也可借鉴C家、H家和MapR技术栈的版本搭配：
- [ CDH 5 Packaging and Tarball Information](http://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball.html)中列出了CHD5中技术栈的版本情况。
- 在[Hortonworks Data Platform](http://hortonworks.com/products/data-center/hdp/)列出了HDP所用的技术栈的版本情况。![Hive与Spark的版本搭配](/images/2016/8/0026uWfMzy788n0FB0K9a.jpg)
- [MapR Ecosystem Support Matrix](http://maprdocs.mapr.com/home/InteropMatrix/r_eco_matrix.html)中列出了MapR中技术栈的版本情况。