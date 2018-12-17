---
title: '[Sqoop]尝试Sqoop'
date: 2018-07-11 05:44:19
categories: 
- Hadoop/Spark
- Sqoop
tags: 
- sqoop
- hadoop
- DB
- import
- export
---

### Sqoop简介

![sqoop-logo](http://sqoop.apache.org/images/sqoop-logo.png)
[Apache Sqoop](http://sqoop.apache.org)(发音：skup)是一款开源的工具，主要用于在Hadoop(HDFS、Hive、HBase、Accumulo)与关系型数据库(MySQL、PostgreSQL、Oracle、Microsoft SQL、Netezza)间进行数据传输，例如可以将一个关系型数据库中的数据导进到Hadoop的HDFS中，也可以将HDFS的数据导进到关系型数据库中。

### 测试环境

在我使用[GitHub: martinprobson/vagrant-hadoop-hive-spark](https://github.com/martinprobson/vagrant-hadoop-hive-spark/releases)通过Vagrant搭建的Hadoop 2.7.6 + Hive 2.3.3 + Spark 2.3.0虚拟机环境中已经安装了Sqoop，正好可以尝试一下。

### 使用

#### help命令
```
vagrant@node1:~$ sqoop help
Warning: /usr/local/sqoop/../hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/local/sqoop/../accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
Warning: /usr/local/sqoop/../zookeeper does not exist! Accumulo imports will fail.
Please set $ZOOKEEPER_HOME to the root of your Zookeeper installation.
18/07/10 02:17:36 INFO sqoop.Sqoop: Running Sqoop version: 1.4.7
usage: sqoop COMMAND [ARGS]

Available commands:
  codegen            Generate code to interact with database records
  create-hive-table  Import a table definition into Hive
  eval               Evaluate a SQL statement and display the results
  export             Export an HDFS directory to a database table
  help               List available commands
  import             Import a table from a database to HDFS
  import-all-tables  Import tables from a database to HDFS
  import-mainframe   Import datasets from a mainframe server to HDFS
  job                Work with saved jobs
  list-databases     List available databases on a server
  list-tables        List available tables in a database
  merge              Merge results of incremental imports
  metastore          Run a standalone Sqoop metastore
  version            Display version information

See 'sqoop help COMMAND' for information on a specific command.
```
#### list-databases命令
```
vagrant@node1:~$ sqoop list-databases \
> --connect jdbc:mysql://10.211.55.101:3306/ \
> --username root --password root
Warning: /usr/local/sqoop/../hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/local/sqoop/../accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
Warning: /usr/local/sqoop/../zookeeper does not exist! Accumulo imports will fail.
Please set $ZOOKEEPER_HOME to the root of your Zookeeper installation.
18/07/10 02:21:50 INFO sqoop.Sqoop: Running Sqoop version: 1.4.7
18/07/10 02:21:50 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
18/07/10 02:21:50 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.3.3-bin/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Thu Jul 12 02:21:50 UTC 2018 WARN: Establishing SSL connection without server's identity verification is not recommended. According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. You need either to explicitly disable SSL by setting useSSL=false, or set useSSL=true and provide truststore for server certificate verification.
information_schema
hive_metastore
mysql
performance_schema
sys
test
```
#### list-tables命令
```
vagrant@node1:~$ sqoop list-tables \
> --connect jdbc:mysql://10.211.55.101:3306/test \
> --username root --password root
Warning: /usr/local/sqoop/../hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/local/sqoop/../accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
Warning: /usr/local/sqoop/../zookeeper does not exist! Accumulo imports will fail.
Please set $ZOOKEEPER_HOME to the root of your Zookeeper installation.
18/07/10 02:26:13 INFO sqoop.Sqoop: Running Sqoop version: 1.4.7
18/07/10 02:26:13 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
18/07/10 02:26:14 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.3.3-bin/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Thu Jul 12 02:26:14 UTC 2018 WARN: Establishing SSL connection without server's identity verification is not recommended. According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. You need either to explicitly disable SSL by setting useSSL=false, or set useSSL=true and provide truststore for server certificate verification.
emp
```
#### import命令(MySQL->HDFS)

下列导入使用--table选项，仅选择emp表中的所有记录：
```
vagrant@node1:~$ sqoop import --connect jdbc:mysql://10.211.55.101:3306/test --username root --password root --table emp --target-dir /user/ubuntu/emp -m 1
......
vagrant@node1:~$ hadoop fs -ls /user/ubuntu/emp
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Found 2 items
-rw-r--r--   1 vagrant supergroup          0 2018-07-10 02:59 /user/ubuntu/emp/_SUCCESS
-rw-r--r--   1 vagrant supergroup        810 2018-07-10 02:59 /user/ubuntu/emp/part-m-00000
vagrant@node1:~$
vagrant@node1:~$ hadoop fs -cat /user/ubuntu/emp/part-m-00000
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
7369,SMITH,CLERK,7902,1980-12-17,null,800.0,null
7499,ALLEN,SALESMAN,7698,1981-02-20,null,1600.0,300
7521,WARD,SALESMAN,7698,1981-02-22,null,1250.0,500
7566,JONES,MANAGER,7839,1981-04-02,null,2975.0,null
7654,MARTIN,SALESMAN,7698,1981-09-28,null,1250.0,1400
7698,BLAKE,MANAGER,7839,1981-05-01,null,2850.0,null
7782,CLARK,MANAGER,7839,1981-06-09,null,2450.0,null
7788,SCOTT,ANALYST,7566,1982-12-09,null,3000.0,null
7839,KING,PRESIDENT,null,1981-11-17,null,5000.0,null
7844,TURNER,SALESMAN,7698,1981-09-08,null,1500.0,0
7876,ADAMS,CLERK,7788,1983-01-12,null,1100.0,null
```
注：  
* --target-dir指定的HDFS目标目录必须不存在，否则导入失败，也可以使用--delete-target-dir选项删除可能存在的目标目录；
* 如果MySQL中待导出的表没有设定主键，提示我们使用把--split-by或者把参数-m设置为1，即只有一个map运行，缺点是不能并行map录入数据。

下列导入使用--query选项，仅选择job为CLERK的记录:
```
vagrant@node1:~$ sqoop import  \
> --connect jdbc:mysql://10.211.55.101:3306/test  \
> --username root  \
> --password root  \
> --query "select * from emp where job='CLERK' and \$CONDITIONS"  \
> --fields-terminated-by ","  \
> --lines-terminated-by "\n"  \
> --delete-target-dir \
> --target-dir /user/ubuntu/emp1 \
> -m 1

vagrant@node1:~$ hadoop fs -ls /user/ubuntu/emp1
......
Found 2 items
-rw-r--r--   1 vagrant supergroup          0 2018-07-10 06:17 /user/ubuntu/emp1/_SUCCESS
-rw-r--r--   1 vagrant supergroup        199 2018-07-10 06:17 /user/ubuntu/emp1/part-m-00000
vagrant@node1:~$ hadoop fs -cat /user/ubuntu/emp1/part-m-00000
......
7369,SMITH,CLERK,7902,1980-12-17,null,800.0,null
7876,ADAMS,CLERK,7788,1983-01-12,null,1100.0,null
7900,JAMES,CLERK,7698,1981-12-03,null,950.0,null
7934,MILLER,CLERK,7782,1982-01-23,null,1300.0,null
```
注：  
* 使用--query这种任意格式查询必须指定--target-dir参数；
* 使用--query这种任意格式查询仅用于简单查询，WHERE子句中不能有OR操作符，必须有$CONDITIONS以用于给多个map任务划分任务范围。

#### import命令(MySQL->Hive)

第一次运行import，发现ERROR exec.DDLTask: java.lang.NoSuchMethodError: com.fasterxml.jackson.databind.ObjectMapper.readerFor(LLcom/fasterxml/jackson/databind/ObjectReader;错误，根据参看三进行修复：
```
vagrant@node1:/usr/local/sqoop/lib$ ls jackson*
jackson-annotations-2.3.1.jar  jackson-core-2.3.1.jar  jackson-core-asl-1.9.13.jar  jackson-databind-2.3.1.jar  jackson-mapper-asl-1.9.13.jar
vagrant@node1:/usr/local/sqoop/lib$ rename -e 's/jar/jar\.bak/' jackson*.jar
vagrant@node1:/usr/local/sqoop/lib$ ls -1 jackson*
jackson-annotations-2.3.1.jar.bak
jackson-core-2.3.1.jar.bak
jackson-core-asl-1.9.13.jar.bak
jackson-databind-2.3.1.jar.bak
jackson-mapper-asl-1.9.13.jar.bak
vagrant@node1:/usr/local/sqoop/lib$ cp /usr/local/hive/lib/jackson*.jar .
vagrant@node1:/usr/local/sqoop/lib$ ls -1 jackson*
jackson-annotations-2.3.1.jar.bak
jackson-annotations-2.6.0.jar
jackson-core-2.3.1.jar.bak
jackson-core-2.6.5.jar
jackson-core-asl-1.9.13.jar.bak
jackson-databind-2.3.1.jar.bak
jackson-databind-2.6.5.jar
jackson-dataformat-smile-2.4.6.jar
jackson-datatype-guava-2.4.6.jar
jackson-datatype-joda-2.4.6.jar
jackson-jaxrs-1.9.13.jar
jackson-jaxrs-base-2.4.6.jar
jackson-jaxrs-json-provider-2.4.6.jar
jackson-jaxrs-smile-provider-2.4.6.jar
jackson-mapper-asl-1.9.13.jar.bak
jackson-module-jaxb-annotations-2.4.6.jar
jackson-xc-1.9.13.jar
```
下列导入使用--columns、--where和--table选项，仅选择job为MANAGER的记录的empno、ename和hiredate列。
```
vagrant@node1:~$ sqoop import  \
> --connect jdbc:mysql://10.211.55.101:3306/test  \
> --username root  \
> --password root  \
> --table emp  \
> --columns "empno,ename,hiredate" \
> --where "job='MANAGER'" \
> --fields-terminated-by "\t"  \
> --lines-terminated-by "\n"  \
> --hive-import  \
> --hive-overwrite  \
> --create-hive-table  \
> --delete-target-dir \
> --hive-database  default \
> --hive-table emp2 \
> -m 1

vagrant@node1:~$ hadoop fs -ls /user/hive/warehouse/emp2
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Found 2 items
-rwxr-xr-x   1 vagrant supergroup          0 2018-07-10 04:23 /user/hive/warehouse/emp2/_SUCCESS
-rwxr-xr-x   1 vagrant supergroup         66 2018-07-10 04:23 /user/hive/warehouse/emp2/part-m-00000
vagrant@node1:~$ hadoop fs -cat /user/hive/warehouse/emp2/part-m-00000
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
7566    JONES   1981-04-02
7698    BLAKE   1981-05-01
7782    CLARK   1981-06-09

vagrant@node1:~$ hive
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/apache-hive-2.3.3-bin/lib/log4j-slf4j-impl-2.6.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/apache-tez-0.9.1-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop-2.7.6/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Connecting to jdbc:hive2://
18/07/10 04:25:48 [main]: WARN session.SessionState: METASTORE_FILTER_HOOK will be ignored, since hive.security.authorization.manager is set to instance of HiveAuthorizerFactory.
Connected to: Apache Hive (version 2.3.3)
Driver: Hive JDBC (version 2.3.3)
Transaction isolation: TRANSACTION_REPEATABLE_READ
Beeline version 2.3.3 by Apache Hive
hive> select * from default.emp2;
OK
7566 JONES 1981-04-02
7698 BLAKE 1981-05-01
7782 CLARK 1981-06-09
3 rows selected (2.578 seconds)
```
注：Sqoop导入会创建不存在的表，但是不会创建不存在数据库。

#### eval命令
```
vagrant@node1:~$ sqoop eval  --connect jdbc:mysql://10.211.55.101:3306/test  --username root  --password root  --query "select empno, ename, job, deptno from emp"
......
---------------------------------------------------------------------------
| empno       | ename                | job                  | deptno      |
---------------------------------------------------------------------------
| 7369        | SMITH                | CLERK                | (null)      |
| 7499        | ALLEN                | SALESMAN             | 300         |
| 7521        | WARD                 | SALESMAN             | 500         |
| 7566        | JONES                | MANAGER              | (null)      |
| 7654        | MARTIN               | SALESMAN             | 1400        |
| 7698        | BLAKE                | MANAGER              | (null)      |
| 7782        | CLARK                | MANAGER              | (null)      |
| 7788        | SCOTT                | ANALYST              | (null)      |
| 7839        | KING                 | PRESIDENT            | (null)      |
| 7844        | TURNER               | SALESMAN             | 0           |
| 7876        | ADAMS                | CLERK                | (null)      |
| 7900        | JAMES                | CLERK                | (null)      |
| 7902        | FORD                 | ANALYST              | (null)      |
| 7934        | MILLER               | CLERK                | (null)      |
| 7988        | KATY                 | ANALYST              | (null)      |
| 7987        | JULIA                | ANALYST              | (null)      |
---------------------------------------------------------------------------
vagrant@node1:~$ sqoop eval  --connect jdbc:mysql://10.211.55.101:3306/test  --username root  --password root  --query "select empno, ename, job, deptno from emp where deptno IS NOT NULL"
......
---------------------------------------------------------------------------
| empno       | ename                | job                  | deptno      |
---------------------------------------------------------------------------
| 7499        | ALLEN                | SALESMAN             | 300         |
| 7521        | WARD                 | SALESMAN             | 500         |
| 7654        | MARTIN               | SALESMAN             | 1400        |
| 7844        | TURNER               | SALESMAN             | 0           |
---------------------------------------------------------------------------
```
#### export命令(HDFS->MySQL)

export执行之前必须现在MySQL中创建目标表，否则报ERROR manager.SqlManager: Error executing statement: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'test.emp_hdfs' doesn't exist错误。
```
vagrant@node1:~$ apt-get install mysql-client
vagrant@node1:~$ mysql -u root -p test
mysql> create table emp_hdfs like emp;
Query OK, 0 rows affected (0.00 sec)

vagrant@node1:~$ sqoop export \
> --connect jdbc:mysql://10.211.55.101:3306/test \
> --username root \
> --password root \
> --table emp_hdfs \
> --input-fields-terminated-by ',' \
> --export-dir /user/ubuntu/emp/

mysql> select * from emp_hdfs;
+-------+--------+-----------+------+------------+--------+------+--------+
| empno | ename  | job       | mgr  | hiredate   | salary | comm | deptno |
+-------+--------+-----------+------+------------+--------+------+--------+
|  7902 | FORD   | ANALYST   | 7566 | 1981-12-03 |   NULL | 3000 |   NULL |
|  7934 | MILLER | CLERK     | 7782 | 1982-01-23 |   NULL | 1300 |   NULL |
|  7988 | KATY   | ANALYST   | 7566 | NULL       |   NULL | 1500 |   NULL |
|  7987 | JULIA  | ANALYST   | 7566 | NULL       |   NULL | 1500 |   NULL |
|  7369 | SMITH  | CLERK     | 7902 | 1980-12-17 |   NULL |  800 |   NULL |
|  7499 | ALLEN  | SALESMAN  | 7698 | 1981-02-20 |   NULL | 1600 |    300 |
|  7521 | WARD   | SALESMAN  | 7698 | 1981-02-22 |   NULL | 1250 |    500 |
|  7566 | JONES  | MANAGER   | 7839 | 1981-04-02 |   NULL | 2975 |   NULL |
|  7654 | MARTIN | SALESMAN  | 7698 | 1981-09-28 |   NULL | 1250 |   1400 |
|  7698 | BLAKE  | MANAGER   | 7839 | 1981-05-01 |   NULL | 2850 |   NULL |
|  7782 | CLARK  | MANAGER   | 7839 | 1981-06-09 |   NULL | 2450 |   NULL |
|  7788 | SCOTT  | ANALYST   | 7566 | 1982-12-09 |   NULL | 3000 |   NULL |
|  7839 | KING   | PRESIDENT | NULL | 1981-11-17 |   NULL | 5000 |   NULL |
|  7844 | TURNER | SALESMAN  | 7698 | 1981-09-08 |   NULL | 1500 |      0 |
|  7876 | ADAMS  | CLERK     | 7788 | 1983-01-12 |   NULL | 1100 |   NULL |
|  7900 | JAMES  | CLERK     | 7698 | 1981-12-03 |   NULL |  950 |   NULL |
+-------+--------+-----------+------+------------+--------+------+--------+
16 rows in set (0.00 sec)
```
Hive导出到MySQL也是指定HDFS地址的方式完成的：
```
mysql> CREATE TABLE emp_hive AS (SELECT empno,ename,hiredate FROM emp);
mysql> truncate table emp_hive;
vagrant@node1:~$ sqoop-export \
> --connect jdbc:mysql://10.211.55.101:3306/test \
> --username root \
> --password root \
> --table emp_hive \
> --input-fields-terminated-by '\t' \
> --lines-terminated-by "\n"  \
> --export-dir /user/hive/warehouse/emp2
......
mysql> select * from emp_hive;
+-------+-------+------------+
| empno | ename | hiredate   |
+-------+-------+------------+
|  7698 | BLAKE | 1981-05-01 |
|  7566 | JONES | 1981-04-02 |
|  7782 | CLARK | 1981-06-09 |
+-------+-------+------------+
3 rows in set (0.00 sec)
```
#### codegen命令

生成用于封装和解析导入记录的Java代码。

#### 增量导入/导出

使用--check-column (col)、--incremental (mode)和--last-value (value)参数完成。

### 参考
****
[Sqoop User Guide](http://sqoop.apache.org/docs/1.4.7/SqoopUserGuide.html)  
[Sqoop、SQOOP-3274 hive import job throws AccessControlException for hive 2](https://issues.apache.org/jira/browse/SQOOP-3274?attachmentOrder=desc)  
[hive+sqoop jackson因版本不一致导致java.lang.NoSuchMethodError: com.fasterxml.jackson.databind.ObjectMapper.](https://blog.csdn.net/qq_34117327/article/details/80395704)  