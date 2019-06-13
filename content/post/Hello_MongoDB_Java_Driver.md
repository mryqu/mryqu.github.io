---
title: 'Hello MongoDB Java Driver'
date: 2014-03-30 13:50:33
categories: 
- db+nosql
tags: 
- mongodb
- java
- driver
- nosql
---
首先需要下载MongoDB JavaDriver，我一开始以为mongo-java-driver-2.9.3.jar是最新版，后来才发现MongoDB JavaDriver下载页面版本排序是按照文件名而不是按照日期排序，其实mongo-java-driver-2.12.0.jar是最新版。因为从版本2.10.0开始提供新的类MongoClient而不是Mongo来连接数据库，所以需要注意所使用的MongoDB Java Driver版本。
**Java代码如下：**
```
package com.yqu.mongodb;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Set;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.MongoException;

public class HelloMongoDB {

  public static void main(String[] args) {
    MongoClient mongoClient = null;
    try {
      
      // Since 2.10.0, uses MongoClient
      // mongoClient = new MongoClient("localhost", 27017);
      String host = "mongodb://localhost:27017";
      mongoClient = new MongoClient(new MongoClientURI(host));

      showdbs(mongoClient);

      
      // MongoDB will create it if database doesn't exists
      DB db = mongoClient.getDB("hellodb");

      System.out.println("\nget database 'hellodb'.");
      showdbs(mongoClient);

      showcollections(db);

      
      DBCollection coll = null;
      // MongoDB will create it if collection doesn't exists
      // There is a difference:
      // showcollections display the new collection name when
      // createCollection is used,
      // but not before any document is inserted when 
      // getCollection is used.
      //
      // coll = db.createCollection("helloCollection",
      //       new BasicDBObject("capped", false));
      coll = db.getCollection("helloCollection");
      System.out.println("\nget collection 'helloCollection'.");
      showcollections(db);

      BasicDBObject doc, query;
      
      doc = new BasicDBObject("name", "MongoDB")
          .append("type", "database")
          .append("count", 1)
          .append("info", new BasicDBObject("x", 123)
                    .append("y", 321));
      coll.insert(doc);

      doc = new BasicDBObject("name", "Java")
          .append("type", "language")
          .append("count", 3)
          .append("info", new BasicDBObject("x", 76)
                    .append("y", 265));
      coll.insert(doc);

      doc = new BasicDBObject("name", "Python")
          .append("type", "language")
          .append("count", 5)
          .append("info", new BasicDBObject("x", 2)
                    .append("y", 2014));
      coll.insert(doc);

      coll.createIndex(new BasicDBObject("name", "text"));
      coll.createIndex(new BasicDBObject("count", 1));

      System.out.println("\nSome document are inserted.");
      showdocuments(coll);

      
      searchdocuments(coll, new BasicDBObject("name", "MongoDB"));

      searchdocuments(coll, new BasicDBObject("count", 
          new BasicDBObject("$lt", 4)));

      // The embedded document query example
      searchdocuments(coll, new BasicDBObject("info.x",
          new BasicDBObject("$lt", 100)));

      
      // update document which name is 'Java'
      query = new BasicDBObject("name", "Java");
      BasicDBObject newDoc = new BasicDBObject("name", "R");
      BasicDBObject updateObj = new BasicDBObject("$set", newDoc);
      coll.update(query, updateObj);

      System.out.println("\nUpdate document which name is 'Java'");
      showdocuments(coll);
      showindexs(coll);

      showcollections(db);

      
      mongoClient.dropDatabase("hellodb");
      System.out.println("drop database 'hellodb'.");
      showdbs(mongoClient);

    } catch (UnknownHostException e) {
      e.printStackTrace();
    } catch (MongoException e) {
      e.printStackTrace();
    } finally {
      if (mongoClient != null) {
        mongoClient.close();
      }
    }
  }

  private static void showdbs(MongoClient mongoClient) {
    System.out.println("\nCurrent databases:");
    List dbs = mongoClient.getDatabaseNames();
    if (dbs.isEmpty())
      System.out.println();
    else {
      for (String s : dbs) {
        System.out.println("  " + s);
      }
    }
  }

  private static void showcollections(DB db) {
    System.out.println("\nCurrent collections under " + 
        db.getName() + ":");
    Set collections = db.getCollectionNames();
    if (collections.isEmpty())
      System.out.println();
    else {
      for (String s : collections) {
        System.out.println("  " + s);
      }
    }
  }

  private static void showdocuments(DBCollection coll) {
    System.out.println("\nCurrent documents under " + 
        coll.getName() + ":");
    DBCursor cur = coll.find();

    while (cur.hasNext()) {
      System.out.println("  " + cur.next());
    }
  }

  private static void showindexs(DBCollection coll) {
    System.out.println("\nCurrent index info under " + 
        coll.getName() + ":");
    List list = coll.getIndexInfo();

    for (DBObject o : list) {
      System.out.println(o.get("key"));
    }
  }

  private static void searchdocuments(
      DBCollection coll, BasicDBObject query) {
    System.out.println("\nQuery " + query +
        " for " + coll.getName() + ":");
    DBCursor cur = coll.find(query);

    while (cur.hasNext()) {
      System.out.println("  " + cur.next());
    }
  }
}
```


**输出：**
<pre>
Current databases:
  local
  admin
  test

get database 'hellodb'.

Current databases:
  local
  admin
  test

Current collections under hellodb:


get collection 'helloCollection'.

Current collections under hellodb:


Some document are inserted.

Current documents under helloCollection:
  { "_id" : { "$oid" : "5336644eb767266396077ff8"} , "name" : "MongoDB" , "type" : "database" , "count" : 1 , "info" : { "x" : 123 , "y" : 321}}
  { "_id" : { "$oid" : "5336644eb767266396077ff9"} , "name" : "Java" , "type" : "language" , "count" : 3 , "info" : { "x" : 76 , "y" : 265}}
  { "_id" : { "$oid" : "5336644eb767266396077ffa"} , "name" : "Python" , "type" : "language" , "count" : 5 , "info" : { "x" : 2 , "y" : 2014}}

Query { "name" : "MongoDB"} for helloCollection:
  { "_id" : { "$oid" : "5336644eb767266396077ff8"} , "name" : "MongoDB" , "type" : "database" , "count" : 1 , "info" : { "x" : 123 , "y" : 321}}

Query { "count" : { "$lt" : 4}} for helloCollection:
  { "_id" : { "$oid" : "5336644eb767266396077ff8"} , "name" : "MongoDB" , "type" : "database" , "count" : 1 , "info" : { "x" : 123 , "y" : 321}}
  { "_id" : { "$oid" : "5336644eb767266396077ff9"} , "name" : "Java" , "type" : "language" , "count" : 3 , "info" : { "x" : 76 , "y" : 265}}

Query { "info.x" : { "$lt" : 100}} for helloCollection:
  { "_id" : { "$oid" : "5336644eb767266396077ff9"} , "name" : "Java" , "type" : "language" , "count" : 3 , "info" : { "x" : 76 , "y" : 265}}
  { "_id" : { "$oid" : "5336644eb767266396077ffa"} , "name" : "Python" , "type" : "language" , "count" : 5 , "info" : { "x" : 2 , "y" : 2014}}

update document which name is 'Java'

Current documents under helloCollection:
  { "_id" : { "$oid" : "5336644eb767266396077ff8"} , "name" : "MongoDB" , "type" : "database" , "count" : 1 , "info" : { "x" : 123 , "y" : 321}}
  { "_id" : { "$oid" : "5336644eb767266396077ff9"} , "name" : "R" , "type" : "language" , "count" : 3 , "info" : { "x" : 76 , "y" : 265}}
  { "_id" : { "$oid" : "5336644eb767266396077ffa"} , "name" : "Python" , "type" : "language" , "count" : 5 , "info" : { "x" : 2 , "y" : 2014}}

Current index info under helloCollection:
{ "_id" : 1}
{ "_fts" : "text" , "_ftsx" : 1}
{ "count" : 1}

Current collections under hellodb:
  helloCollection
  system.indexes
drop database 'hellodb'.

Current databases:
  local
  admin
  test</pre>



### 参考

[ Getting Started with Java Driver](http://docs.mongodb.org/ecosystem/tutorial/getting-started-with-java-driver/)    
[MongoDB Drivers](http://docs.mongodb.org/ecosystem/drivers/)    
[MongoDB Driver Syntax Table](http://docs.mongodb.org/ecosystem/drivers/syntax-table/)    
[MongoDB Java Driver API Document](http://api.mongodb.org/java/index.html)    