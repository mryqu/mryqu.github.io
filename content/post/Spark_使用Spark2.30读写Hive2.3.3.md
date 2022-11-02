---
title: '[Spark] 使用Spark2.30读写Hive2.3.3'
date: 2018-07-03 06:04:31
categories: 
- BigData
tags: 
- hadoop
- hive
- spark
- sql
- Java
---

### 试验环境搭建

#### 安装Spark环境
犯懒，直接使用[GitHub: martinprobson/vagrant-hadoop-hive-spark](https://github.com/martinprobson/vagrant-hadoop-hive-spark/releases)通过Vagrant搭建了一个Hadoop 2.7.6 + Hive 2.3.3 + Spark 2.3.0的虚拟机环境。
#### 在Hive上加载emp表
```
hive> create table emp (empno int, ename string, job string, mgr int, hiredate string, salary double, comm double, deptno int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' ;
hive> LOAD DATA LOCAL INPATH '/usr/local/hive/examples/files/emp2.txt' OVERWRITE INTO TABLE emp;
```
#### 安装Gradle
按照[Gradle用户手册](https://docs.gradle.org/current/userguide/installation.html)中的方式手工安装Gradle：
```
vagrant@node1:~$ export GRADLE_HOME=/opt/gradle/gradle-4.8.1
vagrant@node1:~$ export PATH=$PATH:$GRADLE_HOME/bin
vagrant@node1:~$ gradle -v

Welcome to Gradle 4.8.1!

Here are the highlights of this release:
 - Dependency locking
 - Maven Publish and Ivy Publish plugins improved and marked stable
 - Incremental annotation processing enhancements
 - APIs to configure tasks at creation time

For more details see https://docs.gradle.org/4.8.1/release-notes.html

------------------------------------------------------------
Gradle 4.8.1
------------------------------------------------------------

Build time:   2018-06-21 07:53:06 UTC
Revision:     0abdea078047b12df42e7750ccba34d69b516a22

Groovy:       2.4.12
Ant:          Apache Ant(TM) version 1.9.11 compiled on March 23 2018
JVM:          1.8.0_171 (Oracle Corporation 25.171-b11)
OS:           Linux 4.4.0-128-generic amd64
```

### Spark项目

#### 目录结构
```
vagrant@node1:~/HelloSparkHive$ tree
.
├── build.gradle
└── src
    └── main
        └── java
            └── com
                └── yqu
                    └── sparkhive
                        └── HelloSparkHiveDriver.java

6 directories, 2 files
```
#### build.gradle
```
apply plugin: 'java-library'
apply plugin: 'eclipse'
apply plugin: 'idea'

repositories {
    jcenter()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compileOnly 'org.apache.spark:spark-core_2.11:2.3.0'
    compileOnly 'org.apache.spark:spark-sql_2.11:2.3.0'
    testImplementation 'org.apache.spark:spark-core_2.11:2.3.0','junit:junit:4.12'
}

jar {
    baseName = 'hello-spark-hive'
    version =  '0.1.0'
}
```
#### src/main/java/com/yqu/sparkhive/HelloSparkHiveDriver.java
该范例仅将emp表加载成DataSet，然后由DataSet创建临时视图，由临时视图创建新表，由此完成Hive读写示例。
```
package com.yqu.sparkhive;

import java.io.File;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

public class HelloSparkHiveDriver {
  public static void main(String args[]) {

    if(args.length==0) {
      System.out.println("Please provide target hive table name!");
    }

    // warehouseLocation points to the default location 
    // for managed databases and tables
    String warehouseLocation = new File("spark-warehouse").getAbsolutePath();

    SparkSession spark = SparkSession
       .builder()
       .appName("
       .config("spark.sql.warehouse.dir", warehouseLocation)
       .enableHiveSupport()
       .getOrCreate();

    // Queries are expressed in HiveQL
    Dataset sqlDF = spark.sql("SELECT * FROM emp");
    System.out.println("emp content:");
    sqlDF.show();

    sqlDF.createOrReplaceTempView("yquTempTable");
    spark.sql("create table "+args[0]+" as select * from yquTempTable");
    System.out.println(args[0]+" content:");
    spark.sql("SELECT * FROM "+args[0]).show();

    spark.close();
  }
}
```

### 构建及测试

```
vagrant@node1:~/HelloSparkHive$ gradle build jar
BUILD SUCCESSFUL in 0s
2 actionable tasks: 2 executed
vagrant@node1:~/HelloSparkHive$ spark-submit --class com.yqu.sparkhive.HelloSparkHiveDriver --deploy-mode client --master local[2] /home/vagrant/HelloSparkHive/build/libs/hello-spark-hive-0.1.0.jar yqu1

vagrant@node1:~/HelloSparkHive$ hive
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.3.3-bin/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Connecting to jdbc:hive2://
18/07/10 07:55:18 [main]: WARN session.SessionState: METASTORE_FILTER_HOOK will be ignored, since hive.security.authorization.manager is set to instance of HiveAuthorizerFactory.
Connected to: Apache Hive (version 2.3.3)
Driver: Hive JDBC (version 2.3.3)
Transaction isolation: TRANSACTION_REPEATABLE_READ
Beeline version 2.3.3 by Apache Hive
hive> use default;
OK
No rows affected (0.931 seconds)
hive> show tables;
OK
emp
yqu1
2 rows selected (0.229 seconds)
hive> select * from yqu1;
18/07/02 07:55:37 [XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX main]: ERROR hdfs.KeyProviderCache: Could not find uri with key [dfs.encryption.key.provider.uri] to create a keyProvider !!
OK
7369 SMITH CLERK 7902 1980-12-17  800.0
7499 ALLEN SALESMAN 7698 1981-02-20  1600.0 300
7521 WARD SALESMAN 7698 1981-02-22  1250.0 500
7566 JONES MANAGER 7839 1981-04-02  2975.0
7654 MARTIN SALESMAN 7698 1981-09-28  1250.0 1400
7698 BLAKE MANAGER 7839 1981-05-01  2850.0
7782 CLARK MANAGER 7839 1981-06-09  2450.0
7788 SCOTT ANALYST 7566 1982-12-09  3000.0
7839 KING PRESIDENT  1981-11-17  5000.0
7844 TURNER SALESMAN 7698 1981-09-08  1500.0 0
7876 ADAMS CLERK 7788 1983-01-12  1100.0
7900 JAMES CLERK 7698 1981-12-03  950.0
7902 FORD ANALYST 7566 1981-12-03  3000.0
7934 MILLER CLERK 7782 1982-01-23  1300.0
7988 KATY ANALYST 7566 NULL  1500.0
7987 JULIA ANALYST 7566 NULL  1500.0
16 rows selected (1.546 seconds)
hive>
```

### 参考
******
[Getting started Apache Spark with Java](https://www.geekmj.org/apache-spark/java-getting-started-725/)  
[The Java Library Plugin](https://docs.gradle.org/current/userguide/java_library_plugin.html)  
[geekmj/apache-spark-examples](https://github.com/geekmj/apache-spark-examples)  
[saagie/example-spark-scala-read-and-write-from-hive](https://github.com/saagie/example-spark-scala-read-and-write-from-hive)  