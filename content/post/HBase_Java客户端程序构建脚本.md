---
title: '[HBase] Java客户端程序构建脚本'
date: 2014-01-03 00:05:34
categories: 
- BigData
tags: 
- hbase
- java
- client
- build
- script
---
上一博文[[HBase] 原始数据类型存储](/post/hbase_原始数据类型存储)中所用到的构建脚本build.sh如下：
```
#!/bin/bash

HADOOP_HOME=/usr/local/hadoop
HBASE_HOME=/usr/local/hbase

CLASSPATH=.:$HBASE_HOME/conf:$(hbase classpath)

javac -cp $CLASSPATH HBasePrimitiveDataTypeTest.java
java -cp $CLASSPATH HBasePrimitiveDataTypeTest
```
