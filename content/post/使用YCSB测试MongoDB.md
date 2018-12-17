---
title: '使用YCSB测试MongoDB'
date: 2014-03-31 20:29:01
categories: 
- DB/NoSQL
tags: 
- ycsb
- benchmark
- nosql
- mongodb
- 性能测试
---
### YCSB介绍

[YCSB（Yahoo! Cloud Serving Benchmark）](https://github.com/brianfrankcooper/YCSB)是雅虎开源的一款用于测试各类云服务/NoSQL/键值对存储的性能基准测试工具。覆盖的测试对象有：
- [PNUTS](http://www.brianfrankcooper.net/pubs/pnuts.pdf)
- [BigTable](http://labs.google.com/papers/bigtable.html)
- [HBase](http://hadoop.apache.org/hbase/)
- [Hypertable](http://hypertable.org/)
- [Azure](http://www.microsoft.com/windowsazure/)
- [Cassandra](http://incubator.apache.org/cassandra/)
- [CouchDB](http://couchdb.apache.org/)
- [Voldemort](http://project-voldemort.com/)
- [MongoDB](http://www.mongodb.org/)
- [OrientDB](http://www.orientdb.org/)
- [Infinispan](http://www.infinispan.org/)
- [Dynomite](http://wiki.github.com/cliffmoon/dynomite/dynomite-framework)
- [Redis](http://redis.io/)
- [ GemFire](http://www.vmware.com/products/application-platform/vfabric-gemfire/overview.html)
- [GigaSpaces XAP](http://www.gigaspaces.com/xap)
- [DynamoDB](http://aws.amazon.com/dynamodb/)

YCSB项目的目标是提供一个标准的工具用来衡量不同键值对存储或云服务存储的性能。YCSB做了很多优化来提高客户端性能，例如在数据类型上用了最原始的比特数组以减少数据对象本身创建转换所需的时间等。YCSB的几大特性：
- 支持常见的数据存储读写操作，如插入，修改，删除及读取
- 多线程支持。YCSB用Java实现，有很好的多线程支持。
- 灵活定义场景文件。可以通过参数灵活的指定测试场景，如100%插入， 50%读50%写等等
- 数据请求分布方式：支持随机，zipfian(只有小部分的数据得到大部分的访问请求）以及最新数据几种请求分布方式
- 可扩展性：可以通过扩展Workload的方式来修改或者扩展YCSB的功能

### 使用YCSB测试MongoDB

#### 初试YCSB
下载https://github.com/downloads/brianfrankcooper/YCSB/ycsb-0.1.4.tar.gz 并解压缩。执行如下命令查看帮助：![使用YCSB测试MongoDB](/images/2014/3/0026uWfMgy6QLIk50dx9f.png)接下来开始使用YCSB测试MongoDB2.6，不过这其中遇到一些问题。期望YCSB的下一版本能够解决这些问题。

#### 解决java.lang.ClassNotFoundException:com.yahoo.ycsb.Client问题
执行测试失败：
<pre>C:\ycsb-0.1.4\>python bin/ycsb load mongodb -s -P workloads/workloada
java -cp C:\ycsb-0.1.4\core\lib\core-0.1.4.jar:C:\ycsb-0.1.4\gemfire-binding\conf:C:\ycsb-0.1.4\hbase-binding\conf:C:\ycsb-0.1.4\infinispan-binding\conf:C:\ycsb-0.1.4\jdbc-binding\conf:C:\ycsb-0.1.4\mongodb-binding\lib\mongodb-binding-0.1.4.jar:C:\ycsb-0.1.4\nosqldb-binding\conf:C:\ycsb-0.1.4\voldemort-binding\conf com.yahoo.ycsb.Client -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -load
Exception in thread "main" java.lang.NoClassDefFoundError: com/yahoo/ycsb/Client
Caused by: java.lang.ClassNotFoundException: com.yahoo.ycsb.Client
       at java.net.URLClassLoader$1.run(URLClassLoader.java:202)
       at java.security.AccessController.doPrivileged(Native Method)
       at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
       at java.lang.ClassLoader.loadClass(ClassLoader.java:306)
       at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:301)
       at java.lang.ClassLoader.loadClass(ClassLoader.java:247)
Could not find the main class: com.yahoo.ycsb.Client.  Program will exit.</pre>

问题出在C:\ycsb-0.1.4\bin\ycsb，对于Windows操作系统将classpath参数连接符由":"改成";"即可
```
ycsb_command = ["java", "-cp", ":".join(find_jars(ycsb_home, database)), \
                COMMANDS[sys.argv[1]]["main"], "-db", db_classname] + options
```

#### 解决Could not initialize MongoDB connection pool for Loader:java.lang.NullPointerException问题
重新执行测试失败：
<pre>C:\ycsb-0.1.4\>python bin/ycsb load mongodb -s -P workloads/workloada
java -cp C:\ycsb-0.1.4\core\lib\core-0.1.4.jar;C:\ycsb-0.1.4\gemfire-binding\conf;C:\ycsb-0.1.4\hbase-binding\conf;C:\ycsb-0.1.4\infinispan-binding\conf;C:\ycsb-0.1.4\jdbc-binding\conf;C:\ycsb-0.1.4\mongodb-binding\lib\mongodb-binding-0.1.4.jar;C:\ycsb-0.1.4\nosqldb-binding\conf;C:\ycsb-0.1.4\voldemort-binding\conf com.yahoo.ycsb.Client -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -load
YCSB Client 0.1
Command line: -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -load
Loading workload...
Starting test.
Could not initialize MongoDB connection pool for Loader: java.lang.NullPointerException
java.lang.NullPointerException
        at com.yahoo.ycsb.db.MongoDbClient.init(MongoDbClient.java:78)
        at com.yahoo.ycsb.DBWrapper.init(DBWrapper.java:63)
        at com.yahoo.ycsb.ClientThread.run(Client.java:189)
java.lang.NullPointerException
 0 sec: 0 operations; [INSERT AverageLatency(us)=1320]
 0 sec: 0 operations;
[OVERALL], RunTime(ms), 7.0
[OVERALL], Throughput(ops/sec), 0.0</pre>

看源代码也没什么问题。网上有帖子说可以自己编译源代码，然后就会一切正常了。下载源代码并编译，还是有问题，不过遇山开山、遇水架桥，好歹Core YCSB和Mongo DBBinding都编译出来了。
<pre>C:\gitws\YCSB>set MAVEN_OPTS=-Xmx512m -Xms128m -Xss2m
C:\gitws\YCSB>mvn clean package -fae
..................
[INFO] Reactor Summary:
[INFO]
[INFO] YCSB Root .......................................... SUCCESS [  0.905 s]
[INFO] Core YCSB .......................................... SUCCESS [  8.986 s]
[INFO] Cassandra DB Binding ............................... SUCCESS [  8.315 s]
[INFO] HBase DB Binding ................................... SUCCESS [ 24.290 s]
[INFO] Hypertable DB Binding .............................. SUCCESS [  6.412 s]
[INFO] Accumulo DB Binding ................................ SUCCESS [ 27.691 s]
[INFO] DynamoDB DB Binding ................................ SUCCESS [  7.644 s]
[INFO] ElasticSearch Binding .............................. SUCCESS [ 14.290 s]
[INFO] Infinispan DB Binding .............................. SUCCESS [ 28.955 s]
[INFO] JDBC DB Binding .................................... SUCCESS [  5.538 s]
[INFO] Mapkeeper DB Binding ............................... FAILURE [  0.015 s]
[INFO] Mongo DB Binding ................................... SUCCESS [  3.588 s]
[INFO] OrientDB Binding ................................... SUCCESS [  4.384 s]
[INFO] Redis DB Binding ................................... SUCCESS [  3.604 s]
[INFO] Voldemort DB Binding ............................... SUCCESS [  4.493 s]
[INFO] YCSB Release Distribution Builder .................. SUCCESS [ 17.488 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 02:46 min
[INFO] Finished at: 2014-03-30T08:29:03-04:00
[INFO] Final Memory: 61M/182M
[INFO] ------------------------------------------------------------------------</pre>

#### 测试
<pre>C:\ycsb-0.1.4>python bin/ycsb load mongodb -s -P workloads/workloada
java -cp C:\ycsb-0.1.4\core\lib\core-0.1.4.jar;C:\ycsb-0.1.4\gemfire-binding\conf;C:\ycsb-0.1.4\hbase-binding\conf;C:\ycsb-0.1.4\infinispan-binding\conf;C:\ycsb
-0.1.4\jdbc-binding\conf;C:\ycsb-0.1.4\mongodb-binding\lib\mongodb-binding-0.1.4.jar;C:\ycsb-0.1.4\nosqldb-binding\conf;C:\ycsb-0.1.4\voldemort-binding\conf com.yahoo.ycsb.Clie
nt -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -load
YCSB Client 0.1
Command line: -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -load
Loading workload...
Starting test.
new database url = localhost:27017/ycsb
2014-03-31 15:37:36:410 0 sec: 0 operations;
mongo connection created with localhost:27017/ycsb
2014-03-31 15:37:37:147 0 sec: 1000 operations; 1356.85 current ops/sec; [INSERT AverageLatency(us)=666.46] [CLEANUP AverageLatency(us)=549]
[OVERALL], RunTime(ms), 769.0
[OVERALL], Throughput(ops/sec), 1300.3901170351105
[INSERT], Operations, 1000
[INSERT], AverageLatency(us), 666.457
[INSERT], MinLatency(us), 141
[INSERT], MaxLatency(us), 466548
[INSERT], 95thPercentileLatency(ms), 0
[INSERT], 99thPercentileLatency(ms), 0
[INSERT], Return=0, 1000
...............
[CLEANUP], Operations, 1
[CLEANUP], AverageLatency(us), 549.0
[CLEANUP], MinLatency(us), 549
[CLEANUP], MaxLatency(us), 549
[CLEANUP], 95thPercentileLatency(ms), 0
[CLEANUP], 99thPercentileLatency(ms), 0
...............
C:\ycsb-0.1.4>python bin/ycsb run mongodb -s -P workloads/workloada
java -cp C:\ycsb-0.1.4\core\lib\core-0.1.4.jar;C:\ycsb-0.1.4\gemfire-binding\conf;C:\ycsb-0.1.4\hbase-binding\conf;C:\ycsb-0.1.4\infinispan-binding\conf;C:\ycsb
-0.1.4\jdbc-binding\conf;C:\ycsb-0.1.4\mongodb-binding\lib\mongodb-binding-0.1.4.jar;C:\ycsb-0.1.4\nosqldb-binding\conf;C:\ycsb-0.1.4\voldemort-binding\conf com.yahoo.ycsb.Clie
nt -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -t
YCSB Client 0.1
Command line: -db com.yahoo.ycsb.db.MongoDbClient -s -P workloads/workloada -t
Loading workload...
Starting test.
new database url = localhost:27017/ycsb
2014-03-31 15:42:01:511 0 sec: 0 operations;
mongo connection created with localhost:27017/ycsb
2014-03-31 15:42:01:776 0 sec: 1000 operations; 3773.58 current ops/sec; [UPDATE AverageLatency(us)=216.92] [READ AverageLatency(us)=173.41] [CLEANUP AverageLatency(us)=547]
[OVERALL], RunTime(ms), 265.0
[OVERALL], Throughput(ops/sec), 3773.5849056603774
[UPDATE], Operations, 491
[UPDATE], AverageLatency(us), 216.9205702647658
[UPDATE], MinLatency(us), 138
[UPDATE], MaxLatency(us), 20078
[UPDATE], 95thPercentileLatency(ms), 0
[UPDATE], 99thPercentileLatency(ms), 0
[UPDATE], Return=0, 491
...............
[READ], Operations, 509
[READ], AverageLatency(us), 173.4106090373281
[READ], MinLatency(us), 100
[READ], MaxLatency(us), 19125
[READ], 95thPercentileLatency(ms), 0
[READ], 99thPercentileLatency(ms), 0
[READ], Return=0, 509
...............
[CLEANUP], Operations, 1
[CLEANUP], AverageLatency(us), 547.0
[CLEANUP], MinLatency(us), 547
[CLEANUP], MaxLatency(us), 547
[CLEANUP], 95thPercentileLatency(ms), 0
[CLEANUP], 99thPercentileLatency(ms), 0
...............
C:\ycsb-0.1.4></pre>

YCSB现在大概可用了，下一步就是编写所需的workload了。

### 参考

- [YCSB（GitHub）](https://github.com/brianfrankcooper/YCSB)  
- [YCSB Wiki](https://github.com/brianfrankcooper/YCSB/wiki)  