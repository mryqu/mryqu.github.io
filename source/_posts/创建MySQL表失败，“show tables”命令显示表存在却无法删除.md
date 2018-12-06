---
title: '创建MySQL表失败，“show tables”命令显示表存在却无法删除'
date: 2014-10-19 07:41:26
categories: 
- DB/NoSQL
tags: 
- mysql
- error1146
- 42s02
- 创建
- issue
---
在MySQL表中创建一个表table_c失败了，返回错误ERROR 1146(42S02)；结果发现MySQL显示有这个表，却无法查询和删除。```

mysql> create table table_c (.........);
ERROR 1146 (42S02): Table 'yqutesting.table_c' doesn't exist
mysql> show tables;
+-----------------------+
| Tables_in_yqutesting  |
+-----------------------+
| table_a               |
| table_b               |
| table_c               |
+-----------------------+
3 rows in set (0.00 sec)

mysql> select * from table_c;
ERROR 1146 (42S02): Table 'yqutesting.table_c' doesn't exist
mysql> drop table table_c;
ERROR 1051 (42S02): Unknown table 'table_c'

```
结果还是drop掉yqutesting数据库，修正了table_c的定义重新创建数据库和所有表完事。
参考：[ MySQL Create Table Error - Table Doesn't Exist](http://stackoverflow.com/questions/18034485/mysql-create-table-error-table-doesnt-exist)[ MySQL > Table doesn't exist. But it does (or it should)](http://stackoverflow.com/questions/7759170/mysql-table-doesnt-exist-but-it-does-or-it-should/11696069#11696069)[ Can't create table, but table doesn't exist](http://dba.stackexchange.com/questions/69656/cant-create-table-but-table-doesnt-exist)[ Howto: Clean a mysql InnoDB storage engine?](http://stackoverflow.com/questions/3927690/howto-clean-a-mysql-innodb-storage-engine/4056261)
