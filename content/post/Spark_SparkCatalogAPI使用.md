---
title: '[Spark] SparkCatalogAPI使用'
date: 2018-07-16 06:12:39
categories: 
- BigData
tags: 
- spark
- catalog
- hive
- table
- column
---

### Catalog API简介

Spark中的DataSet和Dataframe API支持结构化分析。结构化分析的一个重要的方面是管理元数据。这些元数据可能是一些临时元数据（比如临时表）、SQLContext上注册的UDF以及持久化的元数据（比如Hivemeta store或者HCatalog）。
Spark2中添加了标准的API（称为catalog）来访问Spark SQL中的元数据。这个API既可以操作Spark SQL，也可以操作Hive元数据。

### Catalog API使用

#### 查询数据库
```
scala> spark.catalog.listDatabases.show(false)
+-------+---------------------+----------------------------------------+
|name   |description          |locationUri                             |
+-------+---------------------+----------------------------------------+
|default|Default Hive database|hdfs://10.211.55.101/user/hive/warehouse|
+-------+---------------------+----------------------------------------+

scala> spark.catalog.currentDatabase
res4: String = default
```
#### 查询表
```
scala> spark.catalog.listTables.show(false)
+----+--------+----------------------------------------+---------+-----------+
|name|database|description                             |tableType|isTemporary|
+----+--------+----------------------------------------+---------+-----------+
|emp |default |null                                    |MANAGED  |false      |
|emp2|default |Imported by sqoop on 2018/07/10 04:23:26|MANAGED  |false      |
|emp3|default |Imported by sqoop on 2018/07/10 06:13:17|MANAGED  |false      |
|yqu1|default |null                                    |MANAGED  |false      |
|yqu2|default |null                                    |MANAGED  |false      |
+----+--------+----------------------------------------+---------+-----------+
```
下面的示例用于创建不同TableType的表：
- MANAGED: 当表被删除时，内容与元数据一同删除
- EXTERNAL: 当表被删除时，仅元数据会被删除
- VIEW: 持久视图
- TEMPORARY: 临时视图

```
scala> val df = Seq(1,2).toDF()
df: org.apache.spark.sql.DataFrame = [value: int]

scala> df.write.saveAsTable("t1")
scala> df.write.option("path", "/tmp/tables/t2").saveAsTable("t2")
scala> df.createOrReplaceTempView("t3")
scala> spark.sql("CREATE VIEW tv AS SELECT * FROM t1")
res13: org.apache.spark.sql.DataFrame = []

scala> spark.catalog.listTables.filter($"name".startsWith("t")).show(false)
+----+--------+-----------+---------+-----------+
|name|database|description|tableType|isTemporary|
+----+--------+-----------+---------+-----------+
|t1  |default |null       |MANAGED  |false      |
|t2  |default |null       |EXTERNAL |false      |
|tv  |default |null       |VIEW     |false      |
|t3  |null    |null       |TEMPORARY|true       |
+----+--------+-----------+---------+-----------+
```
#### 查询列
```
scala> spark.catalog.listColumns("emp").show(false)
+--------+-----------+--------+--------+-----------+--------+
|name    |description|dataType|nullable|isPartition|isBucket|
+--------+-----------+--------+--------+-----------+--------+
|empno   |null       |int     |true    |false      |false   |
|ename   |null       |string  |true    |false      |false   |
|job     |null       |string  |true    |false      |false   |
|mgr     |null       |int     |true    |false      |false   |
|hiredate|null       |string  |true    |false      |false   |
|salary  |null       |double  |true    |false      |false   |
|comm    |null       |double  |true    |false      |false   |
|deptno  |null       |int     |true    |false      |false   |
+--------+-----------+--------+--------+-----------+--------+
```
#### 查询函数

![Spark Catalog ListFunctions](/images/2018/07/spark_catalog_listfunctions.png)按照以前的博文[[Hive] Hive Macro和UDF实践](/post/hive_hive_macro和udf实践)创建持久性函数my_hello和my_lower后，使用Catalog API查询：
```
scala> spark.catalog.listFunctions.filter($"name".contains("my")).show(false)
+--------+--------+-----------+------------------------+-----------+
|name    |database|description|className               |isTemporary|
+--------+--------+-----------+------------------------+-----------+
|my_hello|default |null       |com.mryqu.hive.udf.Hello|false      |
|my_lower|default |null       |com.mryqu.hive.udf.Lower|false      |
+--------+--------+-----------+------------------------+-----------+
```
#### 查询表是否缓存
```
scala> val sqlDF = spark.sql("SELECT * FROM emp")
sqlDF: org.apache.spark.sql.DataFrame = [empno: int, ename: string ... 6 more fields]

scala> sqlDF.createOrReplaceTempView("yquTempTable")

scala> spark.catalog.listTables.show(false)
+------------+--------+----------------------------------------+---------+-----------+
|name        |database|description                             |tableType|isTemporary|
+------------+--------+----------------------------------------+---------+-----------+
|emp         |default |null                                    |MANAGED  |false      |
|emp2        |default |Imported by sqoop on 2018/07/10 04:23:26|MANAGED  |false      |
|emp3        |default |Imported by sqoop on 2018/07/10 06:13:17|MANAGED  |false      |
|yqu1        |default |null                                    |MANAGED  |false      |
|yqu2        |default |null                                    |MANAGED  |false      |
|yqutemptable|null    |null                                    |TEMPORARY|true       |
+------------+--------+----------------------------------------+---------+-----------+

scala> spark.catalog.isCached("yquTempTable")
res12: Boolean = false

scala> sqlDF.cache()
res14: sqlDF.type = [empno: int, ename: string ... 6 more fields]

scala> spark.catalog.isCached("yquTempTable")
res12: Boolean = true

scala> spark.catalog.isCached("emp")
res13: Boolean = false

scala> spark.catalog.uncacheTable("yqutemptable")

scala> spark.catalog.isCached("yquTempTable")
res19: Boolean = false
```
#### 创建表
```
scala> val df2=spark.catalog.createTable("t4","/tmp/tables/t2")
df2: org.apache.spark.sql.DataFrame = [value: int]

scala> spark.catalog.listTables.filter($"name".startsWith("t")).show(false)
+----+--------+-----------+---------+-----------+
|name|database|description|tableType|isTemporary|
+----+--------+-----------+---------+-----------+
|t1  |default |null       |MANAGED  |false      |
|t2  |default |null       |EXTERNAL |false      |
|t4  |default |null       |EXTERNAL |false      |
|tv  |default |null       |VIEW     |false      |
|t3  |null    |null       |TEMPORARY|true       |
+----+--------+-----------+---------+-----------+

scala> spark.sql("select * from t4").show()
+-----+
|value|
+-----+
|    1|
|    2|
+-----+
```
#### 删除临时视图
```
scala> spark.catalog.dropTempView("t3")
res18: Boolean = true

scala> spark.catalog.listTables.filter($"name".startsWith("t")).show(false)
+----+--------+-----------+---------+-----------+
|name|database|description|tableType|isTemporary|
+----+--------+-----------+---------+-----------+
|t1  |default |null       |MANAGED  |false      |
|t2  |default |null       |EXTERNAL |false      |
|t4  |default |null       |EXTERNAL |false      |
|tv  |default |null       |VIEW     |false      |
+----+--------+-----------+---------+-----------+
```
dropGlobalTempView删除全局临时表跟dropTempView的操作差不多，这里就不演示了。

### 参考
*****
[org.apache.spark.sql.catalog](https://spark.apache.org/docs/2.3.0/api/java/org/apache/spark/sql/catalog/Catalog.html)  
[Introduction to Spark 2.0 - Part 4 : Introduction to Catalog API](http://blog.madhukaraphatak.com/introduction-to-spark-two-part-4/)  
[Migrating to Spark 2.0 - Part 8 : Catalog API](http://blog.madhukaraphatak.com/migrating-to-spark-two-part-8/)  


