---
title: '[Hadoop] 安装Hadoop 2.7.x 集群'
date: 2015-04-28 23:37:27
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- cluster
- install
- yarn
---
### 集群规划

|节点|角色
|-----
|node50064|NameNode RessourceManager
|node50069|Datanode SecondNameNode
|node51054|Datanade


### 准备工作

#### （在全部机器上）创建hadoop用户
```
$ sudo useradd -m hadoop -s /bin/bash
$ sudo passwd hadoop
$ sudo adduser hadoop sudo
```

#### （在全部机器上）配置/etc/hosts
```
10.120.12.135 node50064.mryqu.com node50064
10.120.11.201 node50069.mryqu.com node50069
10.120.14.226 node51054.mryqu.com node51054
```

#### （在全部机器上）禁止掉IPv6

参见之前的博文[在Ubuntu中禁掉IPv6](/post/在ubuntu中禁掉ipv6)。

#### （在全部机器上）关闭防火墙
```
ufw disable   //关闭
sudo apt-get remove  ufw   //卸载
sudo ufw status   //查看
```

#### （在全部机器上）安装并配置Java JDK

安装Java JDK：
```
$ sudo apt-get update
$ sudo apt-get install openjdk-7-jre openjdk-7-jdk
```

通过下列命令确定JDK安装路径为/usr/lib/jvm/java-7-openjdk-amd64：
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76BZ6yRcSe2.png)
通过sudovi /etc/profile添加如下内容：
```
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH
```

最后通过source/etc/profile刷新配置文件。

Java环境变量既可以在/etc/profile下配置，也可以在~/.profile或~/.bashrc中配置。区别在于/etc/profile对所有登陆用户都生效，在~/.profile或~./bashrc中配置仅对当前用户有效。~/.profile与~./bashrc二者的区别为，~/.profile可以设定本用户专有的路径、环境变量等，它只能登入的时候执行一次；~/.bashrc也是某用户专有设定文档，可以设定路径、命令别名，每次shellscript的执行都会对其使用一次。

#### 设置无密码SSH登录

在node50064上生成公钥和私钥，公钥即为认证密钥：
```
 $ ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
$ cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
$ chmod 0600 ~/.ssh/authorized_keys
```

将认证密钥通过ssh-copy-id命令复制给node50069和node51054：
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76B85fvBa94.png)
至此，可从node50064无密码SSH登录上node50069或node51054。

### （在node50064上）安装Hadoop

#### 下载并解压缩Hadoop
```
wget http://apache.osuosl.org/hadoop/common/hadoop-2.7.x/hadoop-2.7.x.tar.gz
tar -xzf hadoop-2.7.x.tar.gz 
sudo mv hadoop-2.7.x /usr/local/hadoop
sudo chown -R hadoop /usr/local/hadoop
cd /usr/local/hadoop
mkdir tmp
mkdir tmp/dfs
mkdir tmp/dfs/name
mkdir tmp/dfs/data
```

#### 配置环境变量

通过vi~/.bashrc添加如下内容：
```
# Set HADOOP_HOME (deprecated)
export HADOOP_HOME=/usr/local/hadoop

# Set HADOOP_PREFIX
export HADOOP_PREFIX=$HADOOP_HOME

# Set HADOOP_CONF_DIR
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_PREFIX/lib/native
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_PREFIX/lib/native"
export JAVA_LIBRARY_PATH=$HADOOP_PREFIX/lib/native:$JAVA_LIBRARY_PATH
export LD_LIBRARY_PATH=$HADOOP_PREFIX/lib/native

# Add Hadoop bin and sbin directory to PATH
export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin
```

最后通过source~/.bashrc刷新配置文件。

### 配置Hadoop

这些配置文件路径为/usr/local/hadoop的相对路径。

#### etc/hadoop/hadoop-env.sh
```
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
```

#### etc/hadoop/[core-site.xml](https://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-common/core-default.xml)
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76DUDTmf577.png)
#### etc/hadoop/[hdfs-site.xml](http://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76DVmBX81b5.png)
#### etc/hadoop/[yarn-site.xml](https://hadoop.apache.org/docs/r2.7.0/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F4xpqR147.png)
#### etc/hadoop/[mapred-site.xml](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F4P3xeLef.png)
#### etc/hadoop/masters
```
node50064
```

#### etc/hadoop/slaves
```
node50069
node51054
```

### 复制Hadoop及配置到其他主机

在node50064上执行：
```
scp ~/.bashrc node50069:~/
scp ~/.bashrc node51054:~/
scp -r /usr/local/hadoop node50069:~/
scp -r /usr/local/hadoop node51054:~/
```

之后，在node50069和node51054上执行：
```
sudo mv ~/hadoop /usr/local/
sudo chown -R hadoop /usr/local/hadoop
source ~/.bashrc
```

### （在node50064上）启动Hadoop

首次使用需要格式化NameNode
```
hdfs namenode -format

```

启动dfs和yarn
```
start-dfs.sh
start-yarn.sh
```

启动MapReduce JobHistory服务器
```
mr-jobhistory-daemon.sh start historyserver
```

### 检验安装结果

#### 查看JVM进程状态
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F5JEmY313.png)
#### 运行Hadoop范例
```
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/hadoop
hdfs dfs -put etc/hadoop input
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.x.jar grep input output 'dfs[a-z.]+'
hdfs dfs -cat output/*
```

#### 查看HDFS Web UI
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F8fa5t5ff.jpg)
#### 查看YARN资管管理器Web UI
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F8CYxRA3e.jpg)
#### 查看MapReduce作业历史
![[Hadoop] 安装Hadoop 2.7.x 集群](/images/2015/4/0026uWfMzy76F8NtoZ694.jpg)
### （在node50064上）关闭Hadoop
```
mr-jobhistory-daemon.sh stop historyserver
stop-dfs.sh
stop-yarn.sh
```

### 附注

SecondNameNode可以在NameNode故障时快一点进行恢复，但它不是对NameNode的插入时更换，也没有提供自动故障切换的手段。更多HadoopHA配置可参考[HDFS High Availability Using the Quorum Journal Manager](https://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html)。

### 参考

[Hadoop: Setting up a Single Node Cluster.](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)    
[Hadoop Cluster Setup](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html)    
[Hadoop Default Ports Quick Reference](http://blog.cloudera.com/blog/2009/08/hadoop-default-ports-quick-reference/)    