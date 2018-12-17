---
title: '[Hive] Hive数据类型'
date: 2015-08-13 06:14:56
categories: 
- Hadoop/Spark
- Hive
tags: 
- hive
- binary
- timestamp
- union
- datatype
---

### Hive支持的数据类型

#### 原始数据类型

- TINYINT
- SMALLINT
- INT
- BIGINT
- BOOLEAN
- FLOAT
- DOUBLE
- STRING
- BINARY
- TIMESTAMP
- DECIMAL
- DECIMAL(precision, scale)
- DATE
- VARCHAR
- CHAR
  
#### 复杂数据类型

- array_type
- map_type
- struct_type
- union_type


### 原始数据类型

在理解原始数据类型时，耗时最多的是TIMESTAMP和BINARY，下文会着重介绍我对这两种类型的理解。
首先创建表primitive_dataytpes_example，字段之间的分隔符没有采用默认的ctrlA，而是使用逗号分隔：
```
create table primitive_dataytpes_example
( a TINYINT,
  b SMALLINT,
  c INT,
  d BIGINT,
  e BOOLEAN,
  f FLOAT,
  g DOUBLE,
  h STRING,
  i BINARY,
  j TIMESTAMP,  
  k DECIMAL,
  l DECIMAL (10,2),
  m DATE,
  n VARCHAR(20),
  o CHAR(20)
)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY  ','
  LINES  TERMINATED BY '\n';
```
![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78eDRctpk26.png)
接下来插入一条记录（dummy表的使用见参考三）：
```
insert into primitive_dataytpes_example select 123,130,32769,2147483649,true,7.0E-4,7.0E-4,'kkxx','ABCD',current_timestamp(),7.0E-4,7.0E+4,'2011-10-08','kkk','xxx' from dummy limit 1;
```
![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78eExH4Ne34.png)
```
hadoop@node50064:~/hivetest$ hadoop fs -ls /user/hive/warehouse/primitive_dataytpes_example
Found 1 items
-rwxrwxr-x   2 hadoop supergroup        126 2015-08-12 17:12 /user/hive/warehouse/primitive_dataytpes_example/000000_0
hadoop@node50064:~/hivetest$ hadoop fs -cat /user/hive/warehouse/primitive_dataytpes_example/000000_0
123,130,32769,2147483649,true,7.0E-4,7.0E-4,kkxx,QUJDRA==,2015-08-12 17:12:30.123,0,70000,2011-10-08,kkk,xxx
hadoop@node50064:~/hivetest$ echo `echo QUJDRA== | base64 --decode`
ABCD
hadoop@node50064:~/hivetest$
```

上述Hive存储表文件说明以下几件事情：
- 对于7.0E-4，FLOAT类型字段f和DOUBLE类型字段g按输入保存，而DECIMAL字段k则按0保存；对于7.0E+4，DECIMAL(10,2)类型字段l按70000保存。这说明Hive会按字段设置的精度存储数据；
- 对于current_timestamp()，TIMESTAMP类型字段j保存的字符格式为 "YYYY-MM-DDHH:MM:SS.fff"，精度为3而不是9；
- 对于"ABCD"，BINARY类型字段i存放了其BASE64编码结果。

下面我们直接在Hive表放置文件数据。
![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78eHEoFCWf2.png)

上述实验说明以下几件事情：
- 即使文件中数据为77777E-4，DECIMAL字段k显示为8；对于存储数据7.0E+4，DECIMAL(10,2)类型字段l显示70000；对于字符串"abcdefghijklmnopqrstuvwxyz"，VARCHAR(20)类型字段n和CHAR(20)类型字段o都显示前20个字符。这说明Hive会按字段设置的精度显示数据；
- 对于存储数据2012-10-0810:51:00.123456789，TIMESTAMP类型字段j确实可以按精度9显示；
- 对于存储数据BASE64编码RGF0YQo=和a3gxMjMK，BINARY类型字段i能够显示原始字符串。

### 复杂数据类型

在理解复杂数据类型时，耗时最多的是UNION，下文会着重介绍我对这种类型的理解。
首先创建表complex_dataytpes_example：
![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78eNqN7Jc86.png)
然后插入两条记录（dummy表的使用见参考三）：
```
hive> insert into complex_datatypes_example select array('hello','1','2','3'), map(1,'k',2,'x',3,'g'), named_struct('name','kx','age',123),create_union(0, 123,false, "0.2012") from dummy limit 1;
hive> insert into complex_datatypes_example select array('kx','xk'), map(123,'hello',321,'world'), named_struct('name','xk','age',321),create_union(1, 123,false, "0.2012") from dummy limit 1;
hive> insert into complex_datatypes_example select array('bye'), map(666,'mryqu'), named_struct('name','kxxk','age',444),create_union(2, 123,false, "0.2012") from dummy limit 1;
```

结果如下：
![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78eOHfGSJ61.png)

以下是我的体会：
- 在对struct插值时，仅在列名为col1、col2...时可以使用struct UDF，否则必须使用named_structUDF。![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78ePhOxQQf0.png)
- 在对union插值时，必须用tag选择用那个类型，在我的示例里：0-INT，1-BOOLEAN，2-STRING，这个tag下标不能越界。三个类型的值也必须存在，否则插入失败。![[Hive] Hive数据类型](/images/2015/8/0026uWfMzy78ePV8pn86e.png)
- 对于我的示例，使用了FIELDS、COLLECTION ITEMS、MAPKEYS、LINES四种分隔标识符。对于union类型字段，存储的数据中tag和值也用COLLECTIONITEMS进行分隔，而且只存储所选类型的值。为什么create_unionUDF必须要提供其他类型的值的？有点脱裤子放屁——多此一举了！

对于array的查询，可以选择下标；对于map的查询，可以选择键；对于struct的查询，可以选择其子字段。
```
hive> select a[0],a[1],b[666],c.age from complex_datatypes_example;
OK
hello   1       NULL    123
kx      xk      NULL    321
bye     NULL    mryqu   444
Time taken: 0.042 seconds, Fetched: 3 row(s)
hive> select size(a), map_keys(b) from complex_datatypes_example;
OK
4       [1,2,3]
2       [123,321]
1       [666]
Time taken: 0.035 seconds, Fetched: 3 row(s)
```

### 参考

[Hive Data Types](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+Types)  
[Hive Data Definition Language](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL)  
[Hive UDF not supported in insert/values command](/post/hive_hive_udf_not_supported_in_insertvalues_command)  
[Hive Operators and User-Defined Functions (UDFs)](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF)  
[Hive Data Types with Examples](http://hadooptutorial.info/hive-data-types-examples/)  
[Hive 中的复合数据结构简介以及一些函数的用法说明](https://my.oschina.net/leejun2005/blog/120463)  
[](http://www.hadooptpoint.com/hadoop-hive-data-types-with-examples/)  
[](http://querydb.blogspot.fr/2015/11/hive-complex-data-types.html)  