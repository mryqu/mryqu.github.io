---
title: '[MapR培训笔记] Hadoop生态系统'
date: 2015-12-05 00:00:41
categories: 
- Hadoop+Spark
- Hadoop
tags: 
- hadoop
- ecosystem
- mapr
---
![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y7Tkt7mnbf.jpg)
- **SQL**: Language designed for querying &amp; transformingdata held in a relational database management system.
- **NoSQL**: Database model that's not necessaryly held intabular format. Often, NoSQL refers to data that is flat or nestedin format.
- **Log Data**: Information captured about organization'sinternal system, external customer interactions &amp; how they'reused
- **Streaming Data**: Twitter, Facebook, Web click data, Webform data.
- **Flume**: Reliable, scalable service used to collectstreaming data in Hadoop cluster.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9hCEhQQ50.png)
- **Sqoop**: Transfers data between external data store &amp;Hadoop cluster. Command line tool used with both RDBMS &amp; NoSQLdata.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9hTkSk4a4.png)
- **NFS**: Distributed file system protocal allowing computerto access files over network as through they were locally mountedstorage.
- **Kafka**: Fast, scalable open source messaging servicedistributing log data over a cluster.
- **Map Reduce**: Multi step process splitting large data setinto parts, &amp; performing functions to produce finalresult.
- **Spark**: General data analytucs on distributed computingcluster. Provides in-memory computation, enhances speed of dataprocessing over MapReduce.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9jQQIj6d0.png)
- **Drill**: Query engine for Big Data exploration. Performsdynamic queries on self-describing data in files (JSON, parquest,text, MapR-DB and HBase tables).![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9jyWV6Rbd.png)
- **Mahout**: Scable machine learning libraries. Corealgorithm supporting data clustering, classfication,categorization, collaborative filter (recommendation engine).![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9jfpK2p55.png)
- **Oozie**: Scalable &amp; extensible scheduling systemcreating complex Hadoop workflows. Manages multiple job types inworkflow (MapReduce, Pig, Hive, Sqoop, distcp, script &amp; Javaprogram).![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9iLuMbv89.png)
- **Hive**: Data warehouse instructure. SQL-like syntax forqueries using MapReduce. HiveQL provides operations similar to SQL,transformed into MapREduce program for query results.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9iw8hgnfb.png)
- **Pig**: Platform for analyzing data. Consists of data flowscripting language called 'Pig Latin' &amp; Instructure forconverting scripts into sequence of MapReduce program.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9j53P8Y10.png)
- **HBase**: Hadoop database, provided random, realtime,read/write access to very large data.![[MapR培训笔记] Hadoop生态系统](/images/2015/12/0026uWfMgy6Y9ikyXBV4b.png)
- **Elatic search**: Scalable search server build on top ofLucene that support real-time or near real time search.
- **Solr**: Open source search platform, part of the ApacheLucene project.
- **SiLK**: Interface for Lucene based Solr search platform.Provides tool to perform searches &amp; visualize results in adashboard with reports.
- **Web Tier**: Web site delivery of big data processingresults directly to consumer (new song recommendation base on whatthe consumer hsa listened to previsouly).
- **Banana**: Based on Kibana. Used to create dashboards forvisualizing data stored in Solr.
- **Kibana**: Browser based dashboard for search &amp; dataanalytics. But with HTM: &amp; JavaScript. Easy to set up &amp;used with just a web server.
- **Data Warehouse**: Centralized repository for storing datafrom multiple sources (marketing, finance, human resources, websites, external data stores).