---
title: '[Spark]Spark2集群安装实践'
date: 2016-07-28 05:47:45
categories: 
- BigData
tags: 
- spark
- ubuntu
- cluster
- yarn
- install
---
从Spark2.0.0开始，Spark使用Scala2.11构建，不再对Java7和Python2.6进行支持。当然不编译Spark源码的话，无需安装Scala。

### Spark集群模型

Spark应用作为集群上一组独立进程运行，由你的主程序（即驱动程序）的SparkContext对象管理。为了在集群上运行，SparkContext可以与若干类型集群管理器（Spark自带的独立集群管理器、Mesos、YARN）连接，集群管理器为应用分配资源。Spark需要集群节点上的执行者（executor）为应用执行计算或存储数据。接下来，它将应用代码发送给执行者，最后SparkContext将人物发往执行者进行运行。![[Spark]Spark2集群安装实践](/images/2016/7/0026uWfMzy77TIkyyOda1.png)

### 准备工作

#### 安装Scala
```
# Scala Installation
wget www.scala-lang.org/files/archive/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb

# sbt Installation
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt
```
#### 安装Java8
```
sudo apt-add-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y
sudo apt-get install oracle-java8-set-default
```
#### 环境变量设置
在~/.bashrc中添加：
```
# Set SPARK_HOME
export SPARK_HOME=/usr/local/spark

export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
```
最后通过source~/.bashrc刷新配置文件。

### 安装Spark

#### （在node50064上）下载并配置Spark
```
wget http://d3kbcqa49mib13.spark-2.X.Y-bin-hadoop2.7.tgz
tar -xzf spark-2.X.Y-bin-hadoop2.7.tgz
sudo mv spark-2.X.Y-bin-hadoop2.7 /usr/local/spark
sudo chown -R "hadoop:hadoop" /usr/local/spark
hadoop fs -mkdir /user/hadoop/sparkHistory
cd /usr/local/spark/conf
```
#### conf/spark-env.sh
通过cpspark-env.sh.template spark-env.sh创建spark-env.sh，并作如下修改：
```
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export SCALA_HOME=${SCALA_HOME:-/usr/share/scala}
# export HADOOP_HOME=/usr/local/hadoop
# export SPARK_HOME=/usr/local/spark

export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$HADOOP_HOME/etc/hadoop/conf}
export YARN_CONF_DIR=${HADOOP_CONF_DIR:-$HADOOP_HOME/etc/hadoop}
export HIVE_CONF_DIR=${HIVE_CONF_DIR:-$HIVE_HOME/etc/hive/conf}

# Options for the daemons used in the standalone deploy mode
export SPARK_MASTER_PORT=7077
export SPARK_MASTER_WEBUI_PORT=18080
export SPARK_WORKER_PORT=7078
export SPARK_WORKER_WEBUI_PORT=18081
```
#### conf/slaves
通过cpslaves.template slaves创建slaves，并作如下修改：
```
node50069.mryqu.com
node51054.mryqu.com
```
#### conf/spark-defaults.conf
通过cpspark-defaults.conf.templatespark-defaults.conf创建spark-defaults.conf，并作如下修改：
```
spark.history.ui.port=18088
spark.eventLog.enabled=true
spark.eventLog.dir=hdfs://node50064.mryqu.com:9000/user/hadoop/sparkHistory
spark.history.fs.logDirectory=hdfs://node50064.mryqu.com:9000/user/hadoop/sparkHistory
```
多说一句，[Spark Monitoring and Instrumentation](http://spark.apache.org/docs/latest/monitoring.html)里面提到了spark.eventLog.dir和spark.history.fs.logDirectory，但是没说二者的关系；[Cloudera - Managing the Spark History Server](https://www.cloudera.com/documentation/enterprise/latest/topics/admin_spark_history_server.html)里面就没提spark.history.fs.logDirectory；而[IBM - Enabling the Spark History service](https://www.ibm.com/support/knowledgecenter/SS3MQL_1.1.1/management_sym/spark_configuring_history_service.html)里面提到spark.history.fs.logDirectory的值要跟spark.eventLog.dir一样。
#### 从node50064复制Spark到其他机器
```
scp -r /usr/local/spark node50069:~/
scp -r /usr/local/spark node51054:~/
```
#### 在node50069和上node51054配置Spark
```
sudo mv spark /usr/local/spark
sudo chown -R "hadoop:hadoop" /usr/local/spark
```

### （在node50064上）启动Spark

#### （在node50064上）启动Spark Standalone custer
```
# 启动Spark 自带的独立（Standalone）集群管理器
# 如仅使用YARN或Mesos集群管理器，无需启动
$SPARK_HOME/sbin/start-all.sh

# 启动Spark History Server
start-history-server.sh
```

### 检验安装结果

#### 查看JVM进程状态
如果启动了Spark 自带的独立（Standalone）集群管理器的话，通过jps-l查看，则在node50064上有org.apache.spark.deploy.master.Master和org.apache.spark.deploy.history.HistoryServer，在node50069和node51054上有org.apache.spark.deploy.worker.Worker进程存在。
#### 提交Spark示例作业
```
# 使用Spark自带的独立集群管理器
spark-submit --class org.apache.spark.examples.SparkPi \
    --master spark://10.120.12.135:6066 \
    --deploy-mode cluster \
    --driver-memory 4g \
    --executor-memory 2g \
    --executor-cores 1 \
    examples/jars/spark-examples*.jar \
    10

# 使用YARN集群管理器
spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --deploy-mode cluster \
    --driver-memory 4g \
    --executor-memory 2g \
    --executor-cores 1 \
    examples/jars/spark-examples*.jar \
    10
```

#### Spark独立集群管理器的Master Web界面
![[Spark]Spark2集群安装实践](/images/2016/7/0026uWfMzy77VIfStguf2.jpg)
#### Spark独立集群管理器的Worker Web界面
![[Spark]Spark2集群安装实践](/images/2016/7/0026uWfMzy77VWTuDqM18.jpg)![[Spark]Spark2集群安装实践](/images/2016/7/0026uWfMzy77VX4YcXm50.jpg)
#### Spark 历史服务器Web界面
![[Spark]Spark2集群安装实践](/images/2016/7/0026uWfMzy77VIuEDRk66.png)
### （在node50064上）关闭Spark
```
# 关闭Spark History Server
stop-history-server.sh

# 关闭Spark 自带的独立（Standalone）集群管理器
$SPARK_HOME/sbin/stop-all.sh
```

### 参考

[Spark官网](http://spark.apache.org/)    
[Scala官网](https://www.scala-lang.org/)    
[Spark Cluster Mode Overview](http://spark.apache.org/docs/latest/cluster-overview.html)    
[Spark Standalone Mode](http://spark.apache.org/docs/latest/spark-standalone.html)    
[Running Spark on YARN](http://spark.apache.org/docs/latest/running-on-yarn.html)    
[Spark Monitoring and Instrumentation](http://spark.apache.org/docs/latest/monitoring.html)    
[Cloudera CDH - Managing Spark](https://www.cloudera.com/documentation/enterprise/latest/topics/admin_spark.html)    