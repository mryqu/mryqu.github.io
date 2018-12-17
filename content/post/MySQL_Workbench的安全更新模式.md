---
title: 'MySQL Workbench的安全更新模式'
date: 2014-07-16 21:08:37
categories: 
- DB/NoSQL
tags: 
- mysql
- safe-update
- error.code.1175
- workbench
- 安全更新模式
---
最近在MySQLWorkbench上使用"DELETE FROM TABLE_E;"清空一个表时返回错误：
Error Code: 1175. You are using safe update mode and you triedto update a table without a WHERE that uses a KEY column To disablesafe mode, toggle the option in Preferences -> SQL Queries andreconnect.

结果在MySQL命令行上却一切正常。

这是由于MySQL Workbench打开了安全更新模式，其有助于初学者使用`DELETE FROM tbl_name` 语句但是忘记了`WHERE`子句造成不必要的麻烦。解决方法就是关闭安全更新模式。

解决方法1：
```
SET SQL_SAFE_UPDATES = 0;
DELETE FROM TABLE_E; 
SET SQL_SAFE_UPDATES = 1;
```

解决方法2：

![MySQL Workbench的安全更新模式](/images/2014/7/0026uWfMgy6N2OjQ2Vf35.jpg)![MySQL Workbench的安全更新模式](/images/2014/7/0026uWfMgy6N2Ok5fCJ75.jpg)

参考：
[mysql delete under safe mode](http://stackoverflow.com/questions/21841353/mysql-delete-under-safe-mode)  
[mysql Tips](http://dev.mysql.com/doc/refman/5.5/en/mysql-tips.html)  