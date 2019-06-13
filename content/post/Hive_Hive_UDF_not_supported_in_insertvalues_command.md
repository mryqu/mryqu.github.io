---
title: '[Hive] Hive UDF not supported in insert/values command'
date: 2015-08-10 05:58:27
categories: 
- Hadoop+Spark
- Hive
tags: 
- hive
- insert
- udf
- tok_function
- timestamp
---
创建一个带有timestamp字段的表，想要在insert/values语句中使用UDF，结果报错。
```
hive> create table t2 (id int, time timestamp);
OK
Time taken: 0.045 seconds
hive> insert into t2 values(1,current_timestamp());
FAILED: SemanticException [Error 10293]: Unable to create temp file for insert values Expr*ession of type TOK_FUNCTION not supported in insert/values
```

参考一中提到：”Hive does not support literals for complex types (array,map, struct, union), so it is not possible to use them in INSERTINTO...VALUES clauses. This means that the user cannot insert datainto a complex datatype column using the INSERT INTO...VALUESclause.“，但是并没有提及不支持UDF？
网上找了找，可以转用INSERT...SELECT这种方式。
```
insert into t2 select 1, from_utc_timestamp('2015-08-09 20:12:02','GMT');
```

实践证明这种方式不可行，不过据说是我的Hive版本不够导致的。
![[Hive] Hive UDF not supported in insert/values command](/images/2015/8/0026uWfMzy78eqDYKF278.png)
最后先创建一个有数据的dummy表，然后再使用INSERT...SELECT这种方式。实践证明该方法可行。
```
create table dummy (story string);
insert into table dummy values ('kx');
insert into t2 select 1, from_utc_timestamp('2015-08-09 20:12:02','GMT') from dummy limit 1;
```
![[Hive] Hive UDF not supported in insert/values command](/images/2015/8/0026uWfMzy78er6pjyv5f.png)

### 参考

[Hive Data Manipulation Language - Inserting values into tables from SQL](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DML#LanguageManualDML-InsertingdataintoHiveTablesfromqueries)  
[Hive Operators and User-Defined Functions (UDFs)](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF)  