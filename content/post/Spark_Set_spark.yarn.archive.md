---
title: '[Spark] Set spark.yarn.archive'
date: 2016-08-01 05:30:15
categories: 
- Hadoop/Spark
- Spark
tags: 
- spark
- spark.yarn.jars
- spark.yarn.archive
- yarn
---
提交Spark作业时，遇到没有设置spark.yarn.jars和spark.yarn.archive的告警：
```
16/08/01 05:01:19 INFO yarn.Client: Preparing resources for our AM container
16/08/01 05:01:20 WARN yarn.Client: Neither spark.yarn.jars nor spark.yarn.archive is set, falling back to uploading libraries under SPARK_HOME.
16/08/01 05:01:23 INFO yarn.Client: Uploading resource file:/tmp/spark-AA-BB-CC-DD-EE/__spark_libs__XXX.zip -> hdfs://node50064.mryqu.com:9000/user/hadoop/.sparkStaging/application_1469998883123_0001/__spark_libs__XXX.zip
```

解决方案：
```
cd $SPARK_HOME
zip spark-archive.zip jars/*
hadoop fs -copyFromLocal spark-archive.zip 
echo "spark.yarn.archive=hdfs:///node50064.mryqu.com:9000/user/hadoop/spark-archive.zip" >> conf/spark-defaults.conf
```
如系统没有安装zip，可执行sudoapt-get install zip进行安装。
这样就不用每次上传Spark的jar文件到HDFS，YARN会找到Spark的库以用于运行作业。