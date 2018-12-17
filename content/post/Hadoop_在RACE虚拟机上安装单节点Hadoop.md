---
title: '[Hadoop] 在RACE虚拟机上安装单节点Hadoop'
date: 2013-07-24 21:58:09
categories: 
- Hadoop/Spark
- Hadoop
tags: 
- hadoop
- linux
- race
- 安装
---
RACE（Remote Access ComputerEnvironment）是SAS公司内使用的虚拟机集成系统。通过RACE系统申请虚拟机，使用自己或别的项目组、同事创建的RACEimage安装操作系统和应用程序，省心省力。

# RACE安装及配置

申请一台RACE虚拟机，使用RACE Image（Id：579290，STG_LAX_RHEL6_SAS94_16G_Ora112 ）安装了RHEL linux操作系统。
启动后，使用下列脚本替换主机信息
```
/nfs/cardio/vol/vol1/sasinside/setup/changehost94.sh
```

# 安装Java JDK

如果RACE Image没有安装Java JDK的话，需要自己安装：
```
yum install java-1.6.0-openjdk java-1.6.0-openjdk-devel
```

幸好在/sasjdk/jdk发现很多版本的Java JDK，最后决定使用下列位置的openjdk:
```
/usr/lib/jvm/java-openjdk/
```

# 创建帐号

原系统中没有安装hadoop，但是有hadoop帐号。我没有找到密码，只好重做一把：
```
userdel hadoop
useradd hadoop
passwd hadoop
```

# 下载并解压缩Hadoop

![[Hadoop] 在RACE虚拟机上安装单节点Hadoop](/images/2013/7/0026uWfMty6E59zAeKSc2.jpg)
因为Hadoop 2.0采用YARN，hive、mahout等需要MapReduce V1的可能无法使用，这里安装的是Hadoop 1.2.1。
```
# mkdir /opt/hadoop
# cd /opt/hadoop/
# wget http://download.nextag.com/apache/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz
# tar -xzf hadoop-1.2.1.tar.gz
# chown -R hadoop /opt/hadoop
# cd /opt/hadoop/hadoop-1.2.1/
```

# 配置Hadoop

下列为Hadoop的单节点伪分布模式配置。
conf/core-site.xml:
```
fs.default.name
hdfs://localhost:9000/
```

conf/hdfs-site.xml:
```
dfs.replication
1
```

conf/mapred-site.xml:
```
mapred.job.tracker
localhost:9001
```

conf/hadoop-env.sh:
```
export JAVA_HOME=/usr/lib/jvm/java-openjdk/
export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true
```

# 设置无密码登录（passphraseless）ssh

Hadoop集群中节点都是通过ssh相互联系，进行数据传输，我们不可能为每次连接输入访问密码（常规ssh需要访问密码），所以我们需要进行相应配置，使节点之间的ssh连接不需要密码。 我们可以通过设置密钥来实现。
由于部署单节点的时候，当前节点既是namenode又是datanode，所以此时需要生成无密码登录的ssh。
首先检查是否可以无密码登录本机ssh
```
$ ssh localhost
```

如果不能无密码登录本机ssh，执行下列命令
```
$ ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa 
$ cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
```

# 配置环境变量

查看当前Shell，发现是Korn shell。
```
$ echo $0
-ksh
```

将JAVA_HOME和Hadoop信息加入环境变量：
```
echo 'export JAVA_HOME=/usr/lib/jvm/java-openjdk/' >> ~/.profile
echo 'export PATH=$JAVA_HOME/bin:/opt/hadoop/hadoop-1.2.1/bin:/opt/hadoop/hadoop-1.2.1/sbin:$PATH' >> ~/.profile
```

无须重启，使环境变量生效：
```
source ~/.profile
```

# 格式化NameNode
```
# su - hadoop
$ cd /opt/hadoop/hadoop-1.2.1
$ bin/hadoop namenode -format
```

此时会初始化好hadoop的文件系统，在/tmp/hadoop-hadoop/dfs发现data、name和namesecondary三个目录。

# 启动Hadoop服务

```
$ start-all.sh
```

# 测试和访问Hadoop服务

使用jps命令检查是否所有服务正常启动。
```
$ jps
29784 SecondaryNameNode
29878 JobTracker
29993 TaskTracker
23699 Jps
29658 DataNode
29549 NameNode
```

服务的Web访问链接
```
http://localhost:50030/   用于Jobtracker
http://localhost:50070/   用于Namenode
http://localhost:50060/   用于Tasktracker
```
