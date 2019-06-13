---
title: '[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群'
date: 2016-02-29 06:23:10
categories: 
- Hadoop+Spark
- HBase
tags: 
- hadoop
- hbase
- zookeeper
- install
---
安装HBase，首先需要参考一下[The versions of Hadoop supported with each version of HBase](http://hbase.apache.org/book.html#hadoop)，以便确定Hadoop和HBase各自的版本。

### 集群规划

|节点|角色
|-----
|node50064|NameNode RessourceManager QuorumPeerMain HMaster
|node50069|Datanode SecondNameNode QuorumPeerMain HMasterHRegionServer
|node51054|Datanade QuorumPeerMain HRegionServer

### ZooKeeper在HBase集群中的作用

- HBase regionserver向ZooKeeper注册，提供HBase regionserver状态信息（是否在线）
- HMaster启动时候会将HBase 系统表-ROOT-加载到ZooKeeper集群，通过zookeeper集群可以获取当前系统表.META.的存储所对应的regionserver信息。

HMaster主要作用在于，通过HMaster维护系统表-ROOT-,.META.，记录regionserver所对应region变化信息。此外还负责监控处理当前HBase集群中regionserver状态变化信息。

### Zookeeper安装

#### （在node50064上）下载并配置ZooKeeper
```
wget http://apache.mirrors.tds.net/zookeeper/zookeeper-3.4.x/zookeeper-3.4.x.tar.gz
tar -xzf zookeeper-3.4.x.tar.gz
sudo mv zookeeper-3.4.x /usr/local/zookeeper
sudo chown -R "hadoop:hadoop" /usr/local/zookeeper
sudo mkdir /var/log/zookeeper
sudo chown -R "hadoop:hadoop" /var/log/zookeeper
sudo mkdir /var/lib/zookeeper
sudo chown -R "hadoop:hadoop" /var/lib/zookeeper
cd /var/lib/zookeeper
touch myid
echo 1 > myid
cd /usr/local/zookeeper/conf
```
通过cpzoo_sample.cfg zoo.cfg，生成ZooKeeper配置文件：
```
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.
**dataDir=/var/lib/zookeeper**
# the port at which the clients will connect
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1

server.1=10.120.12.135:2888:3888
server.2=10.120.11.201:2888:3888
server.3=10.120.14.226:2888:3888
```
参数说明：
- tickTime: 单个滴答的以毫秒为单位的时间长度，zookeeper中使用的基本时间单位。
- dataDir: 数据目录。
- dataLogDir: 日志目录。 如果没有设置该参数, 将使用和dataDir相同的设置。
- clientPort: 监听客户端连接的端口号。
- initLimit:zookeeper集群中的包含多台服务器，其中一台为leader，集群中其余的服务器为follower。initLimit参数配置初始化连接时，follower和leader连接并同步的最大时间量。该参数此处设置为10，说明时间限制为10倍tickTime，即20s。
- syncLimit:该参数配置follower与leader同步所允许的最大时间间隔。如果follower太落后leader，将可能被剔除。该参数此处设置为5，说明时间限制为5倍tickTime， 即10s。
- server.x=[hostname]:mmmmm[:nnnnn] 其中x是一个数字，表示这是第几号服务器；hostname是该服务器地址；mmmmm配置该服务器和集群中的leader交换消息所使用的端口；nnnnnn配置选举leader时所使用的端口.如果配置的是同一机器上的伪集群模式，hostname相同，mmmmm和nnnnn必须不同。

修改bin/zkEnv.sh:
```
if [ "x${ZOO_LOG_DIR}" = "x" ]
then
    ZOO_LOG_DIR="/var/log/zookeeper"
fi
```
#### 从node50064复制ZooKeeper到其他机器
```
scp -r /usr/local/zookeeper node50069:~/
scp -r /usr/local/zookeeper node51054:~/
```
#### 在node50069和上node51054配置ZooKeeper
```
sudo mv zookeeper /usr/local/zookeeper
sudo chown -R "hadoop:hadoop" /usr/local/zookeeper
sudo mkdir /var/log/zookeeper
sudo chown -R "hadoop:hadoop" /var/log/zookeeper
sudo mkdir /var/lib/zookeeper
sudo chown -R "hadoop:hadoop" /var/lib/zookeeper
cd /var/lib/zookeeper
touch myid
```
新建的myid文件所要设的数字表示这是第几号服务器，该数字必须和zoo.cfg文件中的server.x中的x一一对应。这里node50069上myid内容设为2，node51054myid内容设为3。

### HBase安装

#### （在node50064上）下载并解压缩HBase
```
wget http://apache.mirrors.tds.net/hbase/1.2.x/hbase-1.2.x-bin.tar.gz
wget http://apache.mirrors.tds.net/hbase/1.2.x/hbase-1.2.x-bin.tar.gz.mds
md5sum hbase-1.2.x-bin.tar.gz
sha1sum hbase-1.2.x-bin.tar.gz
tar -xzf hbase-1.2.x-bin.tar.gz
sudo mv hbase-1.2.x /usr/local/hbase
sudo chown -R "hadoop:hadoop" /usr/local/hbase
cd /usr/local/hbase
```
#### conf/hbase-env.sh
```
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export HBASE_CLASSPATH=${HBASE_CLASSPATH}:${HBASE_CONF_DIR:-"/usr/local/hbase/conf"}:${HADOOP_CONF_DIR:-"/usr/local/hadoop/etc/hadoop"}
export HBASE_MANAGES_ZK=false
```
根据[Hbase/FAQ_Operations](https://wiki.apache.org/hadoop/Hbase/FAQ_Operations)，如果要让HBase知道dfs.replication等HDFS客户端配置，需要下列途径之一：
- 在hbase-env.sh中将HADOOP_CONF_DIR指給CLASSPATH，或者在HBase配置目录增加hadoop-site.xml符号链接
- 将hadoop-site.xml复制到{HBASE_HOME}/conf
- 将少量HDFS客户端配置加入hbase-site.xml内

本文采用第一种方式。
#### conf/hbase-site.xml
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76JbHNJI76b.jpg)
#### conf/regionservers
```
node50069.mryqu.com
node51054.mryqu.com
```
#### 从node50064复制HBase到其他机器
```
scp -r /usr/local/hbase node50069:~/
scp -r /usr/local/hbase node51054:~/
```
#### 在node50069和上node51054配置HBase
```
sudo mv hbase /usr/local/hbase
sudo chown -R "hadoop:hadoop" /usr/local/hbase
```

### （在全部机器上）环境变量设置

修改~/.bashrc：
```
# Set HADOOP_HOME (deprecated)
export HADOOP_HOME=/usr/local/hadoop

# Set HADOOP_PREFIX
export HADOOP_PREFIX=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_PREFIX/lib/native
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_PREFIX/lib/native"

**# Set ZOOKEEPER_HOME
export ZOOKEEPER_HOME=/usr/local/zookeeper

# Set HBASE_HOME
export HBASE_HOME=/usr/local/hbase**

export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$ZOOKEEPER_HOME/bin:$HBASE_HOME/bin
```

最后通过source~/.bashrc刷新配置文件。

### Hadoop安装

步骤详见之前的博文[[Hadoop] 安装Hadoop 2.7.x 集群](/post/hadoop_安装hadoop_2.7.x_集群)。

### 启动

在运行HBase之前需要保证HDFS和ZooKeeper已经成功启动。

#### （在所有机器上）启动ZooKeeper
```
zkServer.sh start
```
#### （在node50064上）启动Hadoop
```
start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver
```
#### （在node50064和node50069上）启动HBase
```
start-hbase.sh
```

### 检验安装结果

#### 查看JVM进程状态
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NwM8Ft1ab.png)
#### 测试HBase Shell
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NQCsehYd2.jpg)
#### 查看HBase Master web UI
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NR8vyaU54.jpg)![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NRwkBHl13.jpg)
#### 查看HBase RegionServer web UI
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NRODvCT6f.jpg)![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NRYCjOIc4.jpg)
#### 使用命令查看ZooKeeper信息
![[HBase] 安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/images/2016/2/0026uWfMzy76NWIq5m860.png)

### 关闭

#### （在node50064上）关闭HBase、Hadoopr
```
stop-hbase.sh
mr-jobhistory-daemon.sh stop historyserver
stop-dfs.sh
stop-yarn.sh
```
#### （在所有机器上）关闭ZooKeeper
```
zkServer.sh stop
```

### 参考

[ZooKeeper Administrator's Guide](http://zookeeper.apache.org/doc/current/zookeeperAdmin.html)    
[Apache HBase ™ Reference Guide: Advanced - Fully Distributed](http://hbase.apache.org/book.html#quickstart_fully_distributed)    
[ZooKeeper Getting Started Guide](https://zookeeper.apache.org/doc/r3.4.8/zookeeperStarted.html)    
[ZooKeeper Administrator's Guide](https://zookeeper.apache.org/doc/r3.4.8/zookeeperAdmin.html)    
[zookeeper运维](http://blog.csdn.net/hengyunabc/article/details/19006911)    