---
title: '[Zookeeper] 运行Zookeeper REST服务实践'
date: 2016-03-02 05:57:16
categories: 
- BigData
tags: 
- zookeeper
- rest
- service
- curl
- zk_dump_tree.py
---
### Zookeeper REST服务介绍

通常我们应该使用Java/C客户端绑定访问ZooKeeper服务器。不过由于大多数语言内建支持基于HTTP的协议，RESTZooKeeper网关还是很有用的。ZooKeeper REST实现使用Jersey JAX-RS，其REST绑定参考[SPEC.txt](https://github.com/apache/zookeeper/blob/master/src/contrib/rest/SPEC.txt)。其中org.apache.zookeeper.server.jersey.resources.ZNodeResource是项目的核心类，提供Http请求方式对ZooKeeper节点的添加、修改、查询和删除功能，以xml方式返回数据；org.apache.zookeeper.server.jersey.RestMain提供主函数入口。

### 以Ant脚本方式启动

这是[GitHub：apache/zookeeper - REST implementation](https://github.com/apache/zookeeper/tree/trunk/src/contrib/rest)中介绍的方式。
```
cd $ZOOPEEPER_HOME
ant
cd src/contrib/rest
nohup ant run&
```

如果仅是临时运行一下REST服务，ant run即可。
通过nohug提交作业可以确保在退出控制台后ZookeeperREST服务仍在后台运行。当需要关闭时，通过jobs命令查找当前所有运行的作业，通过fg [job_spec]命令关闭作业。
![[Zookeeper] 运行Zookeeper REST服务实践](/images/2016/3/0026uWfMzy77QwKcTCX4b.jpg)
### 以rest.sh方式启动
```
cd $ZOOKEEPER_HOME
mkdir src/contrib/rest/lib
cp build/contrib/rest/zookeeper-dev-rest.jar src/contrib/rest/lib/
cp build/contrib/rest/lib/*.jar src/contrib/rest/lib/
cp zookeeper-3.4.X.jar src/contrib/rest/lib/
cp src/java/lib/*.jar src/contrib/rest/lib/
```

启动
```
cd $ZOOKEEPER_HOME/src/contrib/rest
./rest.sh start
```

停止
```
cd $ZOOKEEPER_HOME/src/contrib/rest
./rest.sh stop
```

查看日志
```
cd $ZOOKEEPER_HOME/src/contrib/rest
tail -f zkrest.log
```

### 测试

将我的Zookeeper从node50064复制到node50069和node51054上，分别在三台机器上启动Zookeeper和ZookeeperREST服务。

#### 访问application.wadl
![[Zookeeper] 运行Zookeeper REST服务实践](/images/2016/3/0026uWfMzy77QDLY7omb2.jpg)
#### 获取根节点数据
![[Zookeeper] 运行Zookeeper REST服务实践](/images/2016/3/0026uWfMzy77QDXoOUhf9.png)
#### 获取根节点的子节点
![[Zookeeper] 运行Zookeeper REST服务实践](/images/2016/3/0026uWfMzy77QEfgxIH47.png)
#### 导出节点及znode层次数据
![[Zookeeper] 运行Zookeeper REST服务实践](/images/2016/3/0026uWfMzy77QFqAvMX37.jpg)

### 参考

[GitHub：apache/zookeeper - REST implementation](https://github.com/apache/zookeeper/tree/trunk/src/contrib/rest)    
[Zookeeper开启Rest服务(3.4.6)](http://blog.cheyo.net/120.html)    
[Hue（五）集成Zookeeper](http://blog.csdn.net/maomaosi2009/article/details/46292607)    
[New ZooKeeper Browser app!](http://gethue.com/new-zookeeper-browser-app/)    
[zookeeper运维](http://blog.csdn.net/hengyunabc/article/details/19006911)    
[GitHub：phunt/zookeeper_dashboard](https://github.com/phunt/zookeeper_dashboard)    
[安装HBase 1.2.x + ZooKeeper 3.4.x 集群](/post/hbase_安装hbase_1.2.x_+_zookeeper_3.4.x_集群)    