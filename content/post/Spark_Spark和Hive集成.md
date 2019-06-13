---
title: '[Spark]Spark和Hive集成'
date: 2016-08-03 06:10:01
categories: 
- Hadoop+Spark
- Spark
tags: 
- spark
- hive
- integration
- spark-sql
---
在前一博文[[Spark] Spark2集群安装实践](/post/spark_spark2集群安装实践)中安装了Spark后，发现和Hive还没有集成在一起，此外Hive自己也不好使了。
```
hadoop@node50064:~$hive
ls: cannot access /usr/local/spark/lib/spark-assembly-*.jar: No such file or directory
.................
```
原来Spark assemblyjar在Spark2中已经不存在了，而Hive脚本判断系统存在Spark后仍要使用，需要将$HIVE_HOME/bin/hive中的这部分代码注释掉：
```
# add Spark assembly jar to the classpath
#if [[ -n "$SPARK_HOME" ]]
#then
#  sparkAssemblyPath=`ls ${SPARK_HOME}/lib/spark-assembly-*.jar`
#  CLASSPATH="${CLASSPATH}:${sparkAssemblyPath}"
#fi
```

至此，Hive本身工作正常。下面开始Spark和Hive集成配置工作。
- Spark SQL CLI需要使用到Hive Metastore，因此需要在[[Hive] 安装Hive 1.2.x](/post/hive_安装hive_1.2.x)的基础上继续修改$HIVE_HOME/conf/hive-site.xml：![[Spark]Spark和Hive集成](/images/2016/8/0026uWfMzy7lNfbiHfn65.jpg)
- 将$HIVE_HOME/conf/hive-site.xml软连接到$SPARK_HOME/conf目录中:
  ```
  cd $SPARK_HOME/conf
  ln -s $HIVE_HOME/conf/hive-site.xml
  ```
- 启动Hive Metastore和HiveServer2：
  ```
  hive --service metastore &
  hive --service hiveserver2 &
  ```

下面进行验证工作：
```
hadoop@node50064:~$ hive

hive> use default;
OK
Time taken: 0.942 seconds
hive> show tables;
OK
apachelog
b
complex_datatypes_example
dummy
empinfo
irisdata
primitive_dataytpes_example
testhivedrivertable
Time taken: 0.288 seconds, Fetched: 8 row(s)
hive> select * from empinfo;
OK
John    Jones   99980   45      Payson  Arizona
Mary    Jones   99982   25      Payson  Arizona
Eric    Edwards 88232   32      San Diego       California
Mary Ann        Edwards 88233   32      Phoenix Arizona
Ginger  Howell  98002   42      Cottonwood      Arizona
Sebastian       Smith   92001   23      Gila Bend       Arizona
Gus     Gray    22322   35      Bagdad  Arizona
Mary Ann        May     32326   52      Tucson  Arizona
Erica   Williams        32327   60      Show Low        Arizona
Leroy   Brown   32380   22      Pinetop Arizona
Elroy   Cleaver 32382   22      Globe   Arizona
Time taken: 0.573 seconds, Fetched: 11 row(s)
hive> quit;


hadoop@node50064:~$ spark-sql

spark-sql>use default;

> show tables;

default apachelog       false
default b       false
default complex_datatypes_example       false
default dummy   false
default empinfo false
default irisdata        false
default primitive_dataytpes_example     false
default testhivedrivertable     false
Time taken: 0.083 seconds, Fetched 8 row(s)
16/08/02 02:47:05 INFO CliDriver: Time taken: 0.083 seconds, Fetched 8 row(s)

spark-sql> select * from empinfo;

John    Jones   99980   45      Payson  Arizona
Mary    Jones   99982   25      Payson  Arizona
Eric    Edwards 88232   32      San Diego       California
Mary Ann        Edwards 88233   32      Phoenix Arizona
Ginger  Howell  98002   42      Cottonwood      Arizona
Sebastian       Smith   92001   23      Gila Bend       Arizona
Gus     Gray    22322   35      Bagdad  Arizona
Mary Ann        May     32326   52      Tucson  Arizona
Erica   Williams        32327   60      Show Low        Arizona
Leroy   Brown   32380   22      Pinetop Arizona
Elroy   Cleaver 32382   22      Globe   Arizona
Time taken: 0.478 seconds, Fetched 11 row(s)
16/08/02 02:48:14 INFO CliDriver: Time taken: 0.478 seconds, Fetched 11 row(s)
```
