---
title: '[Spark] 使用Spark2.30读写MySQL'
date: 2018-07-04 06:36:25
categories: 
- Hadoop+Spark
- Spark
tags: 
- spark
- sql
- mysql
- hive
- Java
---

本博文是[[Spark] 使用Spark2.30读写Hive2.3.3](/post/spark_使用spark2.30读写hive2.3.3)的姊妹篇，环境及Java项目也是使用上一博文中的。

### Spark项目

#### 目录结构
```
vagrant@node1:~/HelloSparkHive$ ls
build  build.gradle  src
vagrant@node1:~/HelloSparkHive$ rm -rf build
vagrant@node1:~/HelloSparkHive$ tree
.
├── build.gradle
└── src
    └── main
        └── java
            └── com
                └── yqu
                    └── sparkhive
                        ├── HelloSparkHiveDriver.java
                        └── HelloSparkMysqlDriver.java

6 directories, 3 files
```
#### src/main/java/com/yqu/sparkhive/HelloSparkMysqlDriver.java
该范例加载Hive中的emp表，存储到MySQL的test数据库中，然后读取MySQL数据库加载emp表，由此完成MySQL读写示例。
```
package com.yqu.sparkhive;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import java.io.File;
import java.sql.*;

public class HelloSparkMysqlDriver {

  private static boolean setup() {
    Connection conn = null;
    Statement stmt = null;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(
                              "jdbc:mysql://10.211.55.101:3306",
                              "root","root");
      stmt = conn.createStatement();
      stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS test");
      stmt.executeUpdate("DROP TABLE IF EXISTS test.emp");
      ResultSet rs = stmt.executeQuery("SHOW DATABASES");
      while(rs.next()){
        System.out.println(rs.getString("Database"));
      }
      rs.close();
      stmt.close();
      conn.close();

      return true;
    } catch (ClassNotFoundException e) {
      System.out.println("Can not find com.mysql.jdbc.Driver!");
    } catch(SQLException se){
      //Handle errors for JDBC
      se.printStackTrace();
    } finally {
      try{
        if(stmt!=null)
          stmt.close();
      } catch(SQLException se){
        se.printStackTrace();
      }
      try{
        if(conn!=null)
          conn.close();
      } catch(SQLException se){
        se.printStackTrace();
      }
    }
    return false;
  }

  public static void main(String args[]) {

    if(setup()) {
      // warehouseLocation points to the default location 
      // for managed databases and tables
      String warehouseLocation = new File("spark-warehouse").
                                         getAbsolutePath();

      SparkSession spark = SparkSession
          .builder()
          .appName("
          .config("spark.sql.warehouse.dir", warehouseLocation)
          .enableHiveSupport()
          .getOrCreate();

      Dataset<Row> hiveDF = spark.sql("SELECT * FROM emp");
      // Saving data to a JDBC source
      hiveDF.write()
          .format("jdbc")
          .option("url", "jdbc:mysql://10.211.55.101:3306/test")
          .option("driver", "com.mysql.jdbc.Driver")
          .option("dbtable", "emp")
          .option("user", "root")
          .option("password", "root")
          .save();

      Dataset<Row> jdbcDF = spark.read()
          .format("jdbc")
          .option("url", "jdbc:mysql://10.211.55.101:3306/test")
          .option("driver", "com.mysql.jdbc.Driver")
          .option("dbtable", "emp")
          .option("user", "root")
          .option("password", "root")
          .load();

      jdbcDF.show();
      spark.close();
    } else {
      System.out.println("MySQL database is not ready!");
    }
  }
}
```

### 构建及测试

```
vagrant@node1:~/HelloSparkHive$ gradle build jar
BUILD SUCCESSFUL in 0s
2 actionable tasks: 2 executed
vagrant@node1:~/HelloSparkHive$ spark-submit --class com.yqu.sparkhive.HelloSparkMysqlDriver --deploy-mode client --master local[2] --jars /usr/local/java/lib/ext/mysql-connector-java-5.1.40.jar /home/vagrant/HelloSparkHive/build/libs/hello-spark-hive-0.1.0.jar
......
Databases:
information_schema
hive_metastore
mysql
performance_schema
sys
test
......
2018-07-03 10:27:49 INFO  DAGScheduler:54 - Job 1 finished: show at HelloSparkMysqlDriver.java:87, took 0.078809 s
+-----+------+---------+----+----------+------+------+------+
|empno| ename|      job| mgr|  hiredate|salary|  comm|deptno|
+-----+------+---------+----+----------+------+------+------+
| 7369| SMITH|    CLERK|7902|1980-12-17|  null| 800.0|  null|
| 7499| ALLEN| SALESMAN|7698|1981-02-20|  null|1600.0|   300|
| 7521|  WARD| SALESMAN|7698|1981-02-22|  null|1250.0|   500|
| 7566| JONES|  MANAGER|7839|1981-04-02|  null|2975.0|  null|
| 7654|MARTIN| SALESMAN|7698|1981-09-28|  null|1250.0|  1400|
| 7698| BLAKE|  MANAGER|7839|1981-05-01|  null|2850.0|  null|
| 7782| CLARK|  MANAGER|7839|1981-06-09|  null|2450.0|  null|
| 7788| SCOTT|  ANALYST|7566|1982-12-09|  null|3000.0|  null|
| 7839|  KING|PRESIDENT|null|1981-11-17|  null|5000.0|  null|
| 7844|TURNER| SALESMAN|7698|1981-09-08|  null|1500.0|     0|
| 7876| ADAMS|    CLERK|7788|1983-01-12|  null|1100.0|  null|
| 7900| JAMES|    CLERK|7698|1981-12-03|  null| 950.0|  null|
| 7902|  FORD|  ANALYST|7566|1981-12-03|  null|3000.0|  null|
| 7934|MILLER|    CLERK|7782|1982-01-23|  null|1300.0|  null|
| 7988|  KATY|  ANALYST|7566|      NULL|  null|1500.0|  null|
| 7987| JULIA|  ANALYST|7566|      NULL|  null|1500.0|  null|
+-----+------+---------+----+----------+------+------+------+
......

vagrant@node1:~/HelloSparkHive$ spark-shell --jars /usr/local/java/lib/ext/mysql-connector-java-5.1.40.jar
......
scala> spark.
     | read.
     | format("jdbc").
     | option("url", "jdbc:mysql://10.211.55.101:3306/test").
     | option("driver", "com.mysql.jdbc.Driver").
     | option("dbtable", "emp").
     | option("user", "root").
     | option("password", "root").
     | load().show()
......
+-----+------+---------+----+----------+------+------+------+
|empno| ename|      job| mgr|  hiredate|salary|  comm|deptno|
+-----+------+---------+----+----------+------+------+------+
| 7369| SMITH|    CLERK|7902|1980-12-17|  null| 800.0|  null|
| 7499| ALLEN| SALESMAN|7698|1981-02-20|  null|1600.0|   300|
| 7521|  WARD| SALESMAN|7698|1981-02-22|  null|1250.0|   500|
| 7566| JONES|  MANAGER|7839|1981-04-02|  null|2975.0|  null|
| 7654|MARTIN| SALESMAN|7698|1981-09-28|  null|1250.0|  1400|
| 7698| BLAKE|  MANAGER|7839|1981-05-01|  null|2850.0|  null|
| 7782| CLARK|  MANAGER|7839|1981-06-09|  null|2450.0|  null|
| 7788| SCOTT|  ANALYST|7566|1982-12-09|  null|3000.0|  null|
| 7839|  KING|PRESIDENT|null|1981-11-17|  null|5000.0|  null|
| 7844|TURNER| SALESMAN|7698|1981-09-08|  null|1500.0|     0|
| 7876| ADAMS|    CLERK|7788|1983-01-12|  null|1100.0|  null|
| 7900| JAMES|    CLERK|7698|1981-12-03|  null| 950.0|  null|
| 7902|  FORD|  ANALYST|7566|1981-12-03|  null|3000.0|  null|
| 7934|MILLER|    CLERK|7782|1982-01-23|  null|1300.0|  null|
| 7988|  KATY|  ANALYST|7566|      NULL|  null|1500.0|  null|
| 7987| JULIA|  ANALYST|7566|      NULL|  null|1500.0|  null|
+-----+------+---------+----+----------+------+------+------+
scala> :quit
vagrant@node1:~/HelloSparkHive$
```

### 参考
*****
[Spark SQL, DataFrames and Datasets Guide](https://spark.apache.org/docs/2.3.0/sql-programming-guide.html)  
[[Spark] 使用Spark2.30读写Hive2.3.3](/post/spark_使用spark2.30读写hive2.3.3)  