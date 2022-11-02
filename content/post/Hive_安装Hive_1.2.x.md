---
title: '[Hive] 安装Hive 1.2.x'
date: 2015-07-24 05:37:23
categories: 
- BigData
tags: 
- hive
- metastore
- embedded
- local
- remote
---
我的Hadoop集群为node50064、node50069和node51054。本文的Hive和MySQL软件仅在node50064上安装。

### 安装Hive-内嵌元数据存储模式

Hive驱动、元数据存储接口和数据库(derby)使用相同的JVM。元数据保持在内嵌的derby数据库，只允许一个会话连接到数据库。
![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xBGAswwf0.png)

#### 下载并解压缩Hive

```
wget http://apache.cs.utah.edu/hive/hive-1.2.x/apache-hive-1.2.x-bin.tar.gz
tar -xzf apache-hive-1.2.x-bin.tar.gz
sudo mv apache-hive-1.2.x-bin /usr/local/hive
sudo chown -R "hadoop:hadoop" /usr/local/hive
```

#### 环境变量设置

```
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_PREFIX=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_PREFIX/lib/native
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_PREFIX/lib/native"

export HIVE_HOME=/usr/local/hive

export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$HIVE_HOME/bin
```
最后通过`source~/.bashrc`刷新配置文件。

#### conf/hive-env.sh

首先通过`cd $HIVE_HOME/conf;cp hive-env.sh.template hive-env.sh;chmod 774hive-env.sh`创建并设置hive-env.sh执行权限。
修改后的主要部分内容如下：
```
# Set HADOOP_HOME to point to a specific hadoop install directory
export HADOOP_HOME=${HADOOP_HOME:-/usr/local/hadoop}

# Hive Configuration Directory can be controlled by:
export HIVE_CONF_DIR=/usr/local/hive/conf

# Folder containing extra ibraries required for hive compilation/execution can be controlled by:
export HIVE_AUX_JARS_PATH=/usr/local/hive/lib
```

#### conf/hive-site.xml

首先通过`cd $HIVE_HOME/conf;cp hive-default.xml.templatehive-site.xml`创建hive-site.xml，并作如下改动：
![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xiSRLDK94.jpg)
参数解释如下：
- Hive表对应的真正HDFS文件存放位置由hive.metastore.warehouse.dir指定。
- Hive在客户端和HDFS实例机器上使用临时目录。这些目录用于存储每个查询的临时/中间数据集，当查询结束后由Hive客户端清除。然而如果hive客户端非正常终止，一些数据将被遗留。HDFS集群上临时目录由hive.exec.scratchdir指定，Hive客户端机器上临时目录由hive.exec.local.scratchdir指定。
  注意，当向表/分区写数据时，Hive首先向目标表文件系统（由hive.exec.scratchdir指定）的临时位置写数据，然后再移往目标表。这种机制对HDFS、S3甚至NFS等文件系统都适用。

#### 创建HDFS目录

在Hive中创建表之前使用HDFS命令创建/tmp和/user/hive/warehouse(即hive.metastore.warehouse.dir所指)并设置模式为g+w。
```
hadoop@node50064:~$hadoop fs -mkdir       /tmp
hadoop@node50064:~$hadoop fs -mkdir       /user/hive/warehouse
hadoop@node50064:~$hadoop fs -chmod g+w   /tmp
hadoop@node50064:~$hadoop fs -chmod g+w   /user/hive/warehouse
```

#### 初始化Derby数据库

```
schematool -dbType derby -initSchema
```
![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xz0lUtwbe.png)

#### 运行Hive控制台

![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy76VPBJNOtc5.jpg)

### 安装Hive-本地元数据存储模式

在Hive所在机器上安装MySQL，把元数据放到MySQL数据库内。
![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xBQ5AnF83.png)

#### 安装MySQL

```
sudo apt-get update
sudo  apt-get install mysql-server
sudo apt-get install libmysql-java
```

#### 配置MySQL

```
create user 'hive' identified by 'hive';
grant all privileges on *.* to 'hive'@'%' with grant option;
flush privileges;
```

#### conf/hive-site.xml

在内嵌模式所用的conf/hive-site.xml做若下修改：

|属性|改动
|-----
|javax.jdo.option.ConnectionDriverName|org.apache.derby.jdbc.EmbeddedDriver=>com.mysql.jdbc.Driver
|javax.jdo.option.ConnectionURL|jdbc:derby:;databaseName=metastore_db;create=true=>jdbc:mysql://node50064.mryqu.com:3306/hive?createDatabaseIfNotExist=true
|javax.jdo.option.ConnectionUserName|APP=>hive
|javax.jdo.option.ConnectionPassword|mine=>hive

#### 向Hive库添加MySQL JDBC驱动

```
cd $HIVE_HOME/lib
ln -s /usr/share/java/mysql-connector-java.jar
```

#### 运行Hive控制台

![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xA1bBUu3a.jpg)

### 安装Hive-远程元数据存储模式

Hive驱动和元数据存储接口运行在不同JVM上（甚至不同机器上）。这样数据库与Hive用户完全隔离，且数据库密码也不会为Hive用户所知。
![[Hive] 安装Hive 1.2.x](/images/2015/7/0026uWfMzy77xBTQpkg3c.png)

#### conf/hive-site.xml

设置hive.metastore.uris值为thrift://hive-metastore-machine:9083 。

#### 启动Hive元数据存储接口

```
hive --service metastore &
```

确认启动：
```
netstat -an | grep 9083
```

### 参考

[Hive AdminManual & MetastoreAdmin](https://cwiki.apache.org/confluence/display/Hive/AdminManual+MetastoreAdmin)  
[Hive Metastore Configuration](http://hadooptutorial.info/hive-metastore-configuration/)  
[Different ways of configuring Hive metastore](http://www.thecloudavenue.com/2013/11/differentWaysOfConfiguringHiveMetastore.html)  
[HIVE完全分布式集群安装过程（元数据库: MySQL）](http://www.aboutyun.com/thread-6902-1-1.html)  