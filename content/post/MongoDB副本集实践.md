---
title: 'MongoDB副本集实践'
date: 2014-04-05 08:18:56
categories: 
- db+nosql
tags: 
- mongodb
- nosql
- replica_set
- high_availablity
- 副本集
---
副本集（ReplicaSet）就是有自动故障恢复功能的主从集群。副本集和主从集群最为明显的区别就是副本集没有固定的“主节点”：整个集群会选取出一个“主节点”，当其不能工作时则变更到其他节点。然而，两者看上去非常相似：副本集总会有一个活跃节点（primary）和一个或多个备份节点（secondary）。![MongoDB副本集实践](/images/2014/4/0026uWfMgy6Rb7v5majff.jpg)
副本集中可以有以下类型的节点：
- 常规节点（standard）：存储一份完整的数据副本，参与选举投票，有可能成为活跃节点。
- 被动节点（passive）：存储完整的数据副本，参与投票，不能成为活跃节点。
- 仲裁节点（arbiter）：仅参与投票，不接受复制的数据，也不能成为活跃节点。

副本集对数据库管理员和开发者都是非常友好的。副本集的管理是自动化的，无需数据库管理员频繁监控和干预，可以自动提升备份节点成为活跃节点，以确保运转正常。对于开发者而言，仅需为副本集指定一下服务器，驱动程序就会自动找到副本集的节点集群。
每个参与节点（非仲裁节点）都有一个权重，权重值取值范围0-1000，默认值为1。权重为0的节点不能成为活跃节点。活跃节点选举根据高优先级优先、优先级相同时数据较新优先的原则进行比较。应用仅能向活跃节点进行写操作。默认情况下，应用会向活跃节点进行读操作也获取最新数据。如果无需获得最新数据时，可以为了提高读操作吞吐量或减少应用延迟而向备份节点进行读操作。读操作偏好模式如下：
- primary
- primaryPreferred
- secondary
- secondaryPreferred
- nearestMongoDB命令行提供了下列关于副本集的指令：

```
> rs.help()
  rs.status()                     { replSetGetStatus : 1 } checks repl set status
  rs.initiate()                   { replSetInitiate : null } initiates set with default settings
  rs.initiate(cfg)                { replSetInitiate : cfg } initiates set with configuration cfg
  rs.conf()                       get the current configuration object from local.system.replset
  rs.reconfig(cfg)                updates the configuration of a running replica set with cfg (disconnects)
  rs.add(hostportstr)             add a new member to the set with default attributes (disconnects)
  rs.add(membercfgobj)            add a new member to the set with extra attributes (disconnects)
  rs.addArb(hostportstr)          add a new member which is arbiterOnly:true (disconnects)
  rs.stepDown([secs])             step down as primary (momentarily) (disconnects)
  rs.syncFrom(hostportstr)        make a secondary to sync from the given member
  rs.freeze(secs)                 make a node ineligible to become primary for the time specified
  rs.remove(hostportstr)          remove a host from the replica set (disconnects)
  rs.slaveOk()                    shorthand for db.getMongo().setSlaveOk()

  rs.printReplicationInfo()       check oplog size and time range
  rs.printSlaveReplicationInfo()  check replica set members and replication lag
  db.isMaster()                   check who is primary

  reconfiguration helpers disconnect from the database so the shell will display an error, even if the command succeeds.
  see also http://[mongod_host]:28017/_replSet for additional diagnostic info
```

### 实验环境

机器：
- 10.120.8.231
- 10.120.5.131
- 10.120.8.165

三个节点中，MongoDB都安装在c:\mongodb目录下且MongoDB配置文件（c:\mongodb\etc\mongo.conf）均为：
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

分别在上面三个节点启动如下命令：
```
c:\mongodb\bin\mongod.exe --config c:\mongodb\etc\mongo.conf  --replSet rs0
```

在任一节点进去MongoDB命令行初始化副本集：
```
rs.initiate({
"_id" : "rs0",
"members" : [
{"_id" : 1, "host" : "10.120.8.231:27017", "priority": 8},
{"_id" : 2, "host" : "10.120.5.131:27017", "priority": 6},
{"_id" : 3, "host" : "10.120.8.165:27017", "arbiterOnly": true},
]
});
```

下列结果显示副本集部署成功：![MongoDB副本集实践](/images/2014/4/0026uWfMgy6RbcEHyng12.png)

### 故障切换测试

客户端使用Python MongoDB驱动pymongo，下载链接为[https://pypi.python.org/pypi/pymongo/2.7](https://pypi.python.org/pypi/pymongo/2.7)。测试代码如下：
```
>>> import pymongo
>>> client = pymongo.MongoClient('mongodb://10.120.8.231,10.120.5.131,10.120.8.165/?replicaSet=rs0')
>>> print client
MongoClient([u'10.120.8.231:27017', u'10.120.5.131:27017'])
>>> db = client.test
>>> db.name
u'test'
>>> db.mycoll.save({"Name":"Thanks", "Count":123})
ObjectId('533f7ae2f6adc81bb87f418a')
>>> db.mycoll.find_one()
{u'Count': 123, u'_id': ObjectId('533f7ae2f6adc81bb87f418a'), u'Name': u'Thanks'}
>>> db.connection.host
'10.120.8.231'
>>> db.connection.port
27017
>>> print 'shutdown 10.120.8.231 now'
shutdown 10.120.8.231 now
>>> 
>>> db.mycoll.find_one()

Traceback (most recent call last):
  File "", line 1, in 
    db.mycoll.find_one()
  File "C:\Python27\lib\site-packages\pymongo\collection.py", line 713, in find_one
    for result in cursor.limit(-1):
  File "C:\Python27\lib\site-packages\pymongo\cursor.py", line 1038, in next
    if len(self.__data) or self._refresh():
  File "C:\Python27\lib\site-packages\pymongo\cursor.py", line 982, in _refresh
    self.__uuid_subtype))
  File "C:\Python27\lib\site-packages\pymongo\cursor.py", line 906, in __send_message
    res = client._send_message_with_response(message, **kwargs)
  File "C:\Python27\lib\site-packages\pymongo\mongo_client.py", line 1186, in _send_message_with_response
    sock_info = self.__socket(member)
  File "C:\Python27\lib\site-packages\pymongo\mongo_client.py", line 913, in __socket
    "%s %s" % (host_details, str(why)))
AutoReconnect: could not connect to 10.120.8.231:27017: [Errno 10061] No connection could be made because the target machine actively refused it
>>> db.mycoll.find_one()
{u'Count': 123, u'_id': ObjectId('533f7ae2f6adc81bb87f418a'), u'Name': u'Thanks'}
>>> db.connection.host
u'10.120.5.131'
>>> db.connection.port
27017
```

### 参考

[MongoDB Manual: Replication](http://docs.mongodb.org/manual/replication/)  
[ MongoDB Doc: High Availability and PyMongo](http://api.mongodb.org/python/current/examples/high_availability.html)  