---
title: '[Hive] Hive Macro和UDF实践'
date: 2015-08-18 05:09:46
categories: 
- BigData
tags: 
- hive
- macro
- udf
- user-defined
- function
---
### 测试数据库
```
hive> describe empinfo;
OK
firstname               string
lastname                string
id                      int
age                     int
city                    string
state                   string
Time taken: 0.047 seconds, Fetched: 6 row(s)
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
Time taken: 0.033 seconds, Fetched: 12 row(s)
```

### Hive Macro
```
hive> CREATE TEMPORARY MACRO nominal_age(age int) age+1;
OK
Time taken: 0.006 seconds
hive> select firstname,lastname,age,nominal_age(age) from empinfo;
OK
John    Jones   45      46
Mary    Jones   25      26
Eric    Edwards 32      33
Mary Ann        Edwards 32      33
Ginger  Howell  42      43
Sebastian       Smith   23      24
Gus     Gray    35      36
Mary Ann        May     52      53
Erica   Williams        60      61
Leroy   Brown   22      23
Elroy   Cleaver 22      23
Time taken: 0.039 seconds, Fetched: 11 row(s)
hive> DROP TEMPORARY MACRO IF EXISTS nominal_age;
OK
Time taken: 0.005 seconds
```

### Hive UDF

#### 查看当前所安装的Hive支持的UDF
```
hive> show functions;
```

#### 查看UDF介绍

选个好理解的concat函数吧。
```
hive> describe function concat;
OK
concat(str1, str2, ... strN) - returns the concatenation of str1, str2, ... strN or concat(bin1, bin2, ... binN) - returns the concatenation of bytes in binary data  bin1, bin2, ... binN
Time taken: 0.004 seconds, Fetched: 1 row(s)
hive> describe function extended concat;
OK
concat(str1, str2, ... strN) - returns the concatenation of str1, str2, ... strN or concat(bin1, bin2, ... binN) - returns the concatenation of bytes in binary data  bin1, bin2, ... binN
Returns NULL if any argument is NULL.
Example:
  > SELECT concat('abc', 'def') FROM src LIMIT 1;
  'abcdef'
Time taken: 0.006 seconds, Fetched: 5 row(s)
```

#### 测试内建UDF

concat函数是软柿子么？为啥还拿它掐呢！！
```
hive> select concat(firstname,' ',lastname),age from empinfo;
OK
John Jones      45
Mary Jones      25
Eric Edwards    32
Mary Ann Edwards        32
Ginger Howell   42
Sebastian Smith 23
Gus Gray        35
Mary Ann May    52
Erica Williams  60
Leroy Brown     22
Elroy Cleaver   22
Time taken: 0.039 seconds, Fetched: 11 row(s)

```

#### 定制UDF

参考二中的代码挺好，改一改再添个自己的Hello类吧。我的代码、编译和jar命令都做在一个Shell脚本中，方便理解这个流程：
![[Hive] Hive Macro和UDF实践](/images/2015/8/0026uWfMzy78hy3lA3K00.png)
mryqu_udf.jar文件内容如下：
```
hadoop@node50064:~/hivetest$ jar -tf mryqu_udf.jar
META-INF/
META-INF/MANIFEST.MF
com/
com/mryqu/
com/mryqu/hive/
com/mryqu/hive/udf/
com/mryqu/hive/udf/Lower.class
com/mryqu/hive/udf/Hello.class
com/mryqu/hive/udf/Hello.java
com/mryqu/hive/udf/Lower.java
```

首先测试一下临时函数，临时函数仅能工作在Hive会话范围内，不会将其元数据写入Hive的元数据数据库，因此使用mryqu_udf.jar中类，必须在每个会话都创建临时函数。测试过程如下：
```
hive> add jar /home/hadoop/hivetest/mryqu_udf.jar;
Added [/home/hadoop/hivetest/mryqu_udf.jar] to class path
Added resources: [/home/hadoop/hivetest/mryqu_udf.jar]
hive> list jars;
/home/hadoop/hivetest/mryqu_udf.jar
hive> create temporary function my_hello as 'com.mryqu.hive.udf.Hello';
OK
Time taken: 0.01 seconds
hive> create temporary function my_lower as 'com.mryqu.hive.udf.Lower';
OK
Time taken: 0.004 seconds

hadoop@node50064:~/hivetest$ hive -e 'show functions' | grep my
OK
Time taken: 1.549 seconds, Fetched: 216 row(s)
hadoop@node50064:~/hivetest$

hive> select firstname, my_hello(firstname), my_lower(firstname) from empinfo;
OK
John    Hello John      john
Mary    Hello Mary      mary
Eric    Hello Eric      eric
Mary Ann        Hello Mary Ann  mary ann
Ginger  Hello Ginger    ginger
Sebastian       Hello Sebastian sebastian
Gus     Hello Gus       gus
Mary Ann        Hello Mary Ann  mary ann
Erica   Hello Erica     erica
Leroy   Hello Leroy     leroy
Elroy   Hello Elroy     elroy
Time taken: 0.037 seconds, Fetched: 11 row(s)
hive> drop temporary function if exists my_hello;
OK
Time taken: 0.005 seconds
hive> drop temporary function if exists my_lower;
OK
Time taken: 0.003 seconds
hive> delete jar /home/hadoop/hivetest/mryqu_udf.jar;
Deleted [/home/hadoop/hivetest/mryqu_udf.jar] from class path
hive> list jars;
hive>

```

接下来试试持久函数（permanentfunction）。参考三中特意提及Hive如果不是在本地模式下，JAR资源文件也不能是本地URI，可以使用HDFSURI等。
![[Hive] Hive Macro和UDF实践](/images/2015/8/0026uWfMzy78hAEqmg2aa.png)
看到区别没，showfunctions返回结果包含我所创建的my_hello和my_lower函数。Hive元数据FUNCS表确实包含my_hello和my_lower的信息：
![[Hive] Hive Macro和UDF实践](/images/2015/8/0026uWfMzy78hBhI22Gfe.png)
下面的命令同样可以创建上述创建持久函数：
```
hive> create function my_hello as 'com.mryqu.hive.udf.Hello' using jar 'hdfs://node50064.mryqu.com:9000/user/hive/mryqu_udf.jar';
hive> create function my_lower as 'com.mryqu.hive.udf.Lower' using jar 'hdfs://node50064.mryqu.com:9000/user/hive/mryqu_udf.jar';
```

最后删除这些持久函数：
```
hive> drop function if exists my_hello;
OK
Time taken: 0.013 seconds
hive> drop function if exists my_lower;
OK
Time taken: 0.011 seconds
```

这里仅对普通Hive UDF进行实践，后继学习将在博文[Hive 表UDTF和汇聚UDAF学习](/post/hive_hive_表udtf和汇聚udaf学习) 中记录。

### 参考

[Hive Operators and User-Defined Functions (UDFs)](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF)  
[Hive Plugins](https://cwiki.apache.org/confluence/display/Hive/HivePlugins)  
[Hive Data Definition Language - Create/Drop/Reload Function](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-CreateFunction)  
[Hive Data Definition Language - Create/DropMacro](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-Create/DropMacro)  
[Apache Hive Customization Tutorial Series](http://blog.matthewrathbone.com/2015/07/27/ultimate-guide-to-writing-custom-functions-for-hive.html)  