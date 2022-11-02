---
title: '[Pig] 安装Pig 0.15.0'
date: 2015-07-20 06:35:42
categories: 
- BigData
tags: 
- pig
- mapreduce
- install
- apache
- hadoop
---
### 安装Pig

我的Hadoop集群为node50064、node50069和node51054。本文的Pig软件仅在node50064上安装。

#### 下载并解压缩Pig

```
wget http://apache.cs.utah.edu/pig/pig-0.15.0/pig-0.15.0.tar.gz
tar -xzf pig-0.15.0.tar.gz
sudo mv pig-0.15.0 /usr/local/pig
sudo chown -R "hadoop:hadoop" /usr/local/pig
```

#### 环境变量设置

```
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_PREFIX=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_PREFIX/lib/native
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_PREFIX/lib/native"

export PIG_HOME=/usr/local/pig
export PIG_CLASSPATH=$HADOOP_HOME/conf

export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$PIG_HOME/bin
```

最后通过source~/.bashrc刷新配置文件。

#### conf/pig.properties

pig.properties用于配置Pig各种参数。参数说明如下：
![[Pig] 安装Pig 0.15.0](/images/2015/7/0026uWfMzy77xHAFECF55.jpg)

#### 运行Pig控制台

![[Pig] 安装Pig 0.15.0](/images/2015/7/0026uWfMzy77xH1uyWq2e.jpg)

### 参考

[你用pig分析access_log日志中ip访问次数](http://shineforever.blog.51cto.com/1429204/1563850)  