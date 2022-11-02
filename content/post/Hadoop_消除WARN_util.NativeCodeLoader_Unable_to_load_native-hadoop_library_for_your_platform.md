---
title: '[Hadoop] 消除WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform.'
date: 2015-04-19 06:40:44
categories: 
- BigData
tags: 
- hadoop
- nativecodeloader
- unable
- native
- library
---
启动DFS或者执行hadoop fs命令总是得到告警<font color="#FF0000">util.NativeCodeLoader: Unable to load native-hadooplibrary for your platform... using builtin-java classes whereapplicable</font>：
```
hadoop@node50064:~$ start-dfs.sh
15/04/18 01:55:33 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Starting namenodes on [node50064.mryqu.com]
node50064.mryqu.com: starting namenode, logging to /usr/local/hadoop/logs/hadoop-hadoop-namenode-node50064.out
node50069.mryqu.com: starting datanode, logging to /usr/local/hadoop/logs/hadoop-hadoop-datanode-node50069.out
node51054.mryqu.com: starting datanode, logging to /usr/local/hadoop/logs/hadoop-hadoop-datanode-node51054.out
Starting secondary namenodes [node50069.mryqu.com]
node50069.mryqu.com: starting secondarynamenode, logging to /usr/local/hadoop/logs/hadoop-hadoop-secondarynamenode-node50069.out
15/04/18 01:55:51 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
```

解决方案为修改~/.bashrc：
```
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_PREFIX=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_PREFIX/lib/native
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_PREFIX/lib/native"
```

最后通过source~/.bashrc刷新配置文件。
