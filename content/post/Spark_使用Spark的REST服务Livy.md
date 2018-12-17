---
title: '[Spark] 使用Spark的REST服务Livy'
date: 2018-07-17 06:09:41
categories: 
- Hadoop/Spark
- Spark
tags: 
- spark
- livy
- rest
- session
- batch
---

### Apache Livy简介

![Livy Logo](https://livy.incubator.apache.org/assets/themes/apache/img/logo.png)
[Apache Livy](https://github.com/apache/incubator-livy)是由Cloudera Labs贡献的基于Apache Spark的开源REST服务，它不仅以REST的方式代替了Spark传统的处理交互方式，同时也提供企业应用中不可忽视的多用户，安全，以及容错的支持。其功能如下：- 拥有可用于多Spark作业或多客户端长时间运行的SparkContext；
- 同时管理多个SparkContext，并在集群（YARN / Mesos）而不是Livy服务器上运行它们，以实现良好的容错性和并发性；
- 可以通过预先编译好的JAR、代码片段或是java/scala客户端API将Spark作业提交到远端的Spark集群上执行。

![Livy Arch](/images/2018/07/LivyArch.jpg)

### 建立测试环境

今天在[GitHub: mryqu/vagrant-hadoop-hive-spark](https://github.com/mryqu/vagrant-hadoop-hive-spark)提交了[add livy support](https://github.com/mryqu/vagrant-hadoop-hive-spark/commit/f97943a453edfc902304ba6bded50b5c9b5d9f23)，因此可以在Vagrant搭建的Hadoop 2.7.6 + Hive 2.3.3 + Spark 2.3.0虚拟机环境中使用Livy 0.5.0服务。
![Livy UI](/images/2018/07/LivyUI.png)

### 使用Livy的REST API

#### 创建交互式会话
```
curl -X POST -d '{"kind": "spark"}' -H "Content-Type: application/json" http://10.211.55.101:8998/sessions
{
    "id":0,
    "appId":null,
    "owner":null,
    "proxyUser":null,
    "state":"starting",
    "kind":"spark",
    "appInfo":{
        "driverLogUrl":null,
        "sparkUiUrl":null
    },
    "log":[
        "stdout: ",
        "
stderr: "
    ]
}
```
成功创建会话0，kind指定为spark，如果之后提交的代码中没有指定kind，则使用此处的会话默认kind。

#### 查询交互式会话列表
```
curl http://10.211.55.101:8998/sessions
{
    "from":0,
    "total":1,
    "sessions":[
        {
            "id":0,
            "appId":null,
            "owner":null,
            "proxyUser":null,
            "state":"idle",
            "kind":"spark",
            "appInfo":{
                "driverLogUrl":null,
                "sparkUiUrl":null
            },
            "log":[
                "2018-07-18 03:19:16 INFO BlockManager:54 - Using org.apache.spark.storage.RandomBlockReplicationPolicy for block replication policy",
                "2018-07-18 03:19:16 INFO BlockManagerMaster:54 - Registering BlockManager BlockManagerId(driver, node1, 37891, None)",
                "2018-07-18 03:19:16 INFO BlockManagerMasterEndpoint:54 - Registering block manager node1:37891 with 366.3 MB RAM, BlockManagerId(driver, node1, 37891, None)",
                "2018-07-18 03:19:16 INFO BlockManagerMaster:54 - Registered BlockManager BlockManagerId(driver, node1, 37891, None)",
                "2018-07-18 03:19:16 INFO BlockManager:54 - Initialized BlockManager: BlockManagerId(driver, node1, 37891, None)",
                "2018-07-18 03:19:16 INFO ContextHandler:781 - Started o.s.j.s.ServletContextHandler@6bc3c1d4{/metrics/json,null,AVAILABLE,@Spark}",
                "2018-07-18 03:19:17 INFO EventLoggingListener:54 - Logging events to hdfs://node1/user/spark/applicationHistory/local-1531883956147",
                "2018-07-18 03:19:17 INFO SparkEntries:53 - Spark context finished initialization in 1925ms",
                "2018-07-18 03:19:17 INFO SparkEntries:87 - Created Spark session (with Hive support).",
                "
stderr: "
            ]
        }
    ]
}
```
#### 提交scala代码片段
```
curl -X POST -H 'Content-Type: application/json' -d '{"code":"123+321"}' http://10.211.55.101:8998/sessions/0/statements
{
    "id":0,
    "code":"123+321",
    "state":"waiting",
    "output":null,
    "progress":0
}
```
#### 查询结果
```
curl http://10.211.55.101:8998/sessions/0/statements/0
{
    "id":0,
    "code":"123+321",
    "state":"available",
    "output":{
        "status":"ok",
        "execution_count":0,
        "data":{
            "text/plain":"res0: Int = 444"
        }
    },
    "progress":1
}
```
#### 提交sql代码片段
```
curl http://10.211.55.101:8998/sessions/0/statements -X POST -H 'Content-Type: application/json' -d '{"code":"show tables","kind":"sql"}'
{
    "id":1,
    "code":"show tables",
    "state":"waiting",
    "output":null,
    "progress":0
}
```
#### 查询结果
```
curl http://10.211.55.101:8998/sessions/0/statements/1
{
    "id":1,
    "code":"show tables",
    "state":"available",
    "output":{
        "status":"ok",
        "execution_count":1,
        "data":{
            "application/json":{
                "schema":{
                    "type":"struct",
                    "fields":[
                        {
                            "name":"database",
                            "type":"string",
                            "nullable":false,
                            "metadata":{

                            }
                        },
                        {
                            "name":"tableName",
                            "type":"string",
                            "nullable":false,
                            "metadata":{

                            }
                        },
                        {
                            "name":"isTemporary",
                            "type":"boolean",
                            "nullable":false,
                            "metadata":{

                            }
                        }
                    ]
                },
                "data":[
                    [
                        "default",
                        "emp",
                        false
                    ],
                    [
                        "default",
                        "emp2",
                        false
                    ],
                    [
                        "default",
                        "emp3",
                        false
                    ],
                    [
                        "default",
                        "t1",
                        false
                    ],
                    [
                        "default",
                        "t2",
                        false
                    ],
                    [
                        "default",
                        "t4",
                        false
                    ],
                    [
                        "default",
                        "tv",
                        false
                    ],
                    [
                        "default",
                        "yqu1",
                        false
                    ],
                    [
                        "default",
                        "yqu2",
                        false
                    ]
                ]
            }
        }
    },
    "progress":1
}
```
#### 提交批处理请求
```
hadoop fs -put /home/vagrant/HelloSparkHive/build/libs/hello-spark-hive-0.1.0.jar /tmp/
curl -H "Content-Type: application/json" -X POST -d '{ "conf": {"spark.master":"local [2]"}, "file":"/tmp/hello-spark-hive-0.1.0.jar", "className":"com.yqu.sparkhive.HelloSparkHiveDriver", "args":["yqu9"] }' http://10.211.55.101:8998/batches

{
    "id":3,
    "state":"running",
    "appId":null,
    "appInfo":{
        "driverLogUrl":null,
        "sparkUiUrl":null
    },
    "log":[
        "stdout: ",
        "
stderr: "
    ]
}
```
#### 查询批处理会话列表
```
curl http://10.211.55.101:8998/batches
{
    "from":0,
    "total":2,
    "sessions":[
        {
            "id":1,
            "state":"dead",
            "appId":null,
            "appInfo":{
                "driverLogUrl":null,
                "sparkUiUrl":null
            },
            "log":[
                "       at org.apache.spark.util.Utils$.doFetchFile(Utils.scala:692)",
                "       at org.apache.spark.deploy.DependencyUtils$.downloadFile(DependencyUtils.scala:131)",
                "       at org.apache.spark.deploy.SparkSubmit$$anonfun$prepareSubmitEnvironment$7.apply(SparkSubmit.scala:401)",
                "       at org.apache.spark.deploy.SparkSubmit$$anonfun$prepareSubmitEnvironment$7.apply(SparkSubmit.scala:401)",
                "       at scala.Option.map(Option.scala:146)",
                "       at org.apache.spark.deploy.SparkSubmit$.prepareSubmitEnvironment(SparkSubmit.scala:400)",
                "       at org.apache.spark.deploy.SparkSubmit$.submit(SparkSubmit.scala:170)",
                "       at org.apache.spark.deploy.SparkSubmit$.main(SparkSubmit.scala:136)",
                "       at org.apache.spark.deploy.SparkSubmit.main(SparkSubmit.scala)",
                "
stderr: "
            ]
        },
        {
            "id":3,
            "state":"running",
            "appId":null,
            "appInfo":{
                "driverLogUrl":null,
                "sparkUiUrl":null
            },
            "log":[
                "2018-07-18 03:48:45 INFO MapOutputTrackerMasterEndpoint:54 - MapOutputTrackerMasterEndpoint stopped!",
                "2018-07-18 03:48:45 INFO MemoryStore:54 - MemoryStore cleared",
                "2018-07-18 03:48:45 INFO BlockManager:54 - BlockManager stopped",
                "2018-07-18 03:48:45 INFO BlockManagerMaster:54 - BlockManagerMaster stopped",
                "2018-07-18 03:48:45 INFO OutputCommitCoordinator$OutputCommitCoordinatorEndpoint:54 - OutputCommitCoordinator stopped!",
                "2018-07-18 03:48:45 INFO SparkContext:54 - Successfully stopped SparkContext",
                "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Shutdown hook called",
                "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Deleting directory /tmp/spark-ffa75451-735a-4edc-9572-32d1a07ba748",
                "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Deleting directory /tmp/spark-7567b293-c81e-4516-a644-531e9fc584d1",
                "
stderr: "
            ]
        }
    ]
}
```
曾经尝试过使用file:///home/vagrant/HelloSparkHive/build/libs/hello-spark-hive-0.1.0.jar，但是报错："requirement failed: Local path /home/vagrant/HelloSparkHive/build/libs/hello-spark-hive-0.1.0.jar cannot be added to user sessions."，有可能不支持本地jar文件。

#### 查询特定批处理会话信息
```
curl http://10.211.55.101:8998/batches/3
{
    "id":3,
    "state":"success",
    "appId":null,
    "appInfo":{
        "driverLogUrl":null,
        "sparkUiUrl":null
    },
    "log":[
        "2018-07-18 03:48:45 INFO MapOutputTrackerMasterEndpoint:54 - MapOutputTrackerMasterEndpoint stopped!",
        "2018-07-18 03:48:45 INFO MemoryStore:54 - MemoryStore cleared",
        "2018-07-18 03:48:45 INFO BlockManager:54 - BlockManager stopped",
        "2018-07-18 03:48:45 INFO BlockManagerMaster:54 - BlockManagerMaster stopped",
        "2018-07-18 03:48:45 INFO OutputCommitCoordinator$OutputCommitCoordinatorEndpoint:54 - OutputCommitCoordinator stopped!",
        "2018-07-18 03:48:45 INFO SparkContext:54 - Successfully stopped SparkContext",
        "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Shutdown hook called",
        "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Deleting directory /tmp/spark-ffa75451-735a-4edc-9572-32d1a07ba748",
        "2018-07-18 03:48:45 INFO ShutdownHookManager:54 - Deleting directory /tmp/spark-7567b293-c81e-4516-a644-531e9fc584d1",
        "
stderr: "
    ]
}
```
#### 查询特定批处理会话状态
```
curl http://10.211.55.101:8998/batches/3/state
{
    "id":3,
    "state":"success"
}
```
#### 查看WEB UI

![Livy UI](/images/2018/07/LivyWebUI.jpg)

#### 删除回话
```
curl -X DELETE http://10.211.55.101:8998/sessions/0
{
    "msg":"deleted"
}
curl -X DELETE http://10.211.55.101:8998/batches/3
{
    "msg":"deleted"
}
```

### 参考
******
[Apache Livy](https://livy.incubator.apache.org/)  
[Livy REST API](https://livy.incubator.apache.org/docs/latest/rest-api.html)  
[GitHub: apache/incubator-livy](https://github.com/apache/incubator-livy)  
[GitHub: mryqu/vagrant-hadoop-hive-spark](https://github.com/mryqu/vagrant-hadoop-hive-spark)  
[Livy：基于Apache Spark的REST服务](https://blog.csdn.net/imgxr/article/details/80130340)  
[Apache Livy 实现思路及模块概述](https://segmentfault.com/p/1210000012783645)  
[Livy原理详解](https://www.cnblogs.com/shenh062326/p/6391057.html)  