---
title: 'MongoDB主从复制实践'
date: 2014-04-03 21:53:44
categories: 
- DB/NoSQL
tags: 
- mongodb
- nosql
- master
- slave
- 主从复制
---
MongoDB主从复制（Master-slave replication）跟副本集（ReplicaSet）相比可以对主MongoDB节点设置多个从节点，并且可以将复制操作限制到特定数据库。但是MongoDB主从复制提供的冗余度更低而且无法自动故障切换，因此一般新的部署都倾向使用副本集而不是主从复制。

### 实验环境

![MongoDB主从复制实践](/images/2014/4/0026uWfMgy6R6jRuMgaaa.png)
两个节点中，MongoDB都安装在c:\mongodb目录下且MongoDB配置文件（c:\mongodb\etc\mongo.conf）均为：
```
systemLog:
   destination: file
   path: C:/mongodb/log/mongo.log
   logAppend: true
storage:
   dbPath: C:/mongodb/data/db
   journal:
      enabled: false
net:
   http:
      enabled: true
      RESTInterfaceEnabled: true
```

### 启动MongoDB

主节点启动命令：
```
c:\mongodb\bin\mongod.exe --config c:\mongodb\etc\mongo.conf --master --oplogSize=2048
```

从节点启动命令：
```
c:\mongodb\bin\mongod.exe --config c:\mongodb\etc\mongo.conf --slave --source 10.120.8.231 --slavedelay 10 --autoresync
```

### 主从复制测试

#### 检查主节点

```
> show dbs;
admin  (empty)
local  8.074GB
test   0.078GB
> db.isMaster()
{
        "ismaster" : true,
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 1000,
        "localTime" : ISODate("2014-04-03T01:47:49.780Z"),
        "maxWireVersion" : 2,
        "minWireVersion" : 0,
        "ok" : 1
}
```

#### 检查从节点

```
> show dbs;
admin  (empty)
local  0.078GB
test   0.078GB
> db.isMaster();
{
        "ismaster" : false,
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 1000,
        "localTime" : ISODate("2014-04-03T01:48:26.416Z"),
        "maxWireVersion" : 2,
        "minWireVersion" : 0,
        "ok" : 1
}
```

#### 主节点插入数据并检查

```
> use hellomsrep;
switched to db hellomsrep
> db.msr.insert({"name":"MongoDB","type":"Master-slave replication"})
WriteResult({ "nInserted" : 1 })
> db.msr.find()
{ "_id" : ObjectId("533cfbce455c73a31f941981"), "name" : "MongoDB", "type" : "Master-slave replication" }
```

#### 检查从节点数据

```
> show dbs;
admin       (empty)
hellomsrep  0.078GB
local       0.078GB
test        0.078GB
> use hellomsrep;
switched to db hellomsrep
> db.msr.find();
{ "_id" : ObjectId("533cfbce455c73a31f941981"), "name" : "MongoDB", "type" : "Master-slave replication" }
> db.printReplicationInfo()
this is a slave, printing slave replication info.
source: 10.120.8.231
        syncedTo: Thu Apr 03 2014 02:16:46 GMT-0400 (Eastern Daylight Time)
        15 secs (0 hrs) behind the primary
```

以上操作证明了主节点插入的数据已被复制到从节点。

### 参考

[MongoDB Manual: Master Slave Replication](http://docs.mongodb.org/manual/core/master-slave/)  
[MongoDB Manual: Configuration File Options](http://docs.mongodb.org/manual/reference/configuration-options/)  