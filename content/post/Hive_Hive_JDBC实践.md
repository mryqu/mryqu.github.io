---
title: '[Hive] Hive JDBC实践'
date: 2015-07-30 05:35:26
categories: 
- BigData
tags: 
- hive
- jdbc
- compile
- practice
---
### HiveJdbcClient.java

使用参考一中的示例代码:
```
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
 
public class HiveJdbcClient {
  private static String driverName = "org.apache.hive.jdbc.HiveDriver";
 
  
  public static void main(String[] args) throws SQLException {
      try {
      Class.forName(driverName);
    } catch (ClassNotFoundException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      System.exit(1);
    }
    //"hadoop" is the name of the user the queries should run as in my cluster.
    Connection con = DriverManager.getConnection(
                    "jdbc:hive2://localhost:10000/default", 
                    "hadoop", "{PASSWORD_OF_USER_HADOOP}");
    Statement stmt = con.createStatement();
    String tableName = "testHiveDriverTable";
    stmt.execute("drop table if exists " + tableName);
    stmt.execute("create table " + tableName + " (key int, value string)");
    // show tables
    String sql = "show tables '" + tableName + "'";
    System.out.println("Running: " + sql);
    ResultSet res = stmt.executeQuery(sql);
    if (res.next()) {
      System.out.println(res.getString(1));
    }
       // describe table
    sql = "describe " + tableName;
    System.out.println("Running: " + sql);
    res = stmt.executeQuery(sql);
    while (res.next()) {
      System.out.println(res.getString(1) + "\t" + res.getString(2));
    }
 
    // load data into table
    // NOTE: filepath has to be local to the hive server
    // NOTE: /tmp/a.txt is a ctrl-A separated file with two fields per line
    String filepath = "/tmp/a.txt";
    sql = "load data local inpath '" + filepath + "' into table " + tableName;
    System.out.println("Running: " + sql);
    stmt.execute(sql);
 
    // select * query
    sql = "select * from " + tableName;
    System.out.println("Running: " + sql);
    res = stmt.executeQuery(sql);
    while (res.next()) {
      System.out.println(String.valueOf(res.getInt(1)) + "\t" + res.getString(2));
    }
 
    // regular hive query
    sql = "select count(1) from " + tableName;
    System.out.println("Running: " + sql);
    res = stmt.executeQuery(sql);
    while (res.next()) {
      System.out.println(res.getString(1));
    }
  }
}
```

### hive_jdbc.sh

```
#!/bin/bash
javac HiveJdbcClient.java

HADOOP_HOME=/usr/local/hadoop
HIVE_HOME=/usr/local/hive

# default hive record format is one record per line,
# delimited by ctrlA character
# The commands below create 2 records
# (1,foo) and (2,bar)

echo -e '1\x01foo' > /tmp/a.txt
echo -e '2\x01bar' >> /tmp/a.txt

CLASSPATH=.:$HIVE_HOME/conf:$(hadoop classpath)

for i in ${HIVE_HOME}/lib/*.jar ; do
    CLASSPATH=$CLASSPATH:$i
done

java -cp $CLASSPATH HiveJdbcClient
```

注1：hadoopclasspath用于输出hadoop所用的CLASSPATH，但是它对同一目录下的jar文件使用*.jar，根据帮助还可以使用hadoopclasspath --glob将其展开，就可以看到每一个jar文件了。
![[Hive] Hive JDBC实践](/images/2015/7/0026uWfMzy786SHFaDGec.jpg)
注2：cat/tmp/a.txt显示结果是过滤掉非显示字符ctrlA的，可以使用less/tmp/a.txt显示带有控制符ctrlA的内容。
![[Hive] Hive JDBC实践](/images/2015/7/0026uWfMzy787JxXHEdc1.png)

### 运行

![[Hive] Hive JDBC实践](/images/2015/7/0026uWfMzy786S87e8Q64.jpg)

### 参考

[HiveServer2 Clients - JDBC Client Sample Code](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Clients#HiveServer2Clients-JDBCClientSampleCode)  
[HiveClient](https://cwiki.apache.org/confluence/display/Hive/HiveClient)  