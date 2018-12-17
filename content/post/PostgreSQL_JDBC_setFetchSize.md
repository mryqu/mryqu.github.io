---
title: 'PostgreSQL JDBC setFetchSize'
date: 2013-06-14 17:56:08
categories: 
- DB/NoSQL
tags: 
- postgresql
- hibernate
- fetch_size
- jdbc
---
今天看到我们的Hiberante配置没有设hibernate.jdbc.fetch_size。
Fetch Size是设定JDBC的Statement读取数据的时候每次从数据库中取出的记录条数。例如一次查询1万条记录，对于Oracle的JDBC驱动来说，是不会1次性把1万条取出来的，而只会取出FetchSize条数，当纪录集遍历完了这些记录以后，再去数据库取Fetch Size条数据。因此大大节省了无谓的内存消耗。当然FetchSize设的越大，读数据库的次数越少，速度越快；FetchSize越小，读数据库的次数越多，速度越慢。这有点像平时我们写程序写硬盘文件一样，设立一个缓冲，每次写入缓冲，等缓冲满了以后，一次写入硬盘，道理相同。 

看了一下Postgres，它的JDBC驱动却是一次将查询的所有结果都返回。相反使用游标、设置fetchsize倒是麻烦不少。
[http://jdbc.postgresql.org/documentation/head/query.html](http://jdbc.postgresql.org/documentation/head/query.html)