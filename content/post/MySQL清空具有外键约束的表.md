---
title: 'MySQL:清空具有外键约束的表'
date: 2013-11-20 20:30:18
categories: 
- db+nosql
tags: 
- mysql
- 清空
- truncate
- 外键约束
- Error Code: 1701
---
最近在MySQL Workbench上使用"TRUNCATE TABLE TABLE_E;"清空一个表时返回错误：Error Code: 1701. Cannot truncate a table referenced in a foreignkey constraint (`yqutesting`.`table_f`, CONSTRAINT `table_f_ibfk_4`FOREIGN KEY (`old_id`) REFERENCES `yqutesting`.`table_e`(`ID`))解决方法1:
- 删除约束
- 清空表
- 手工删除引用该表的记录
- 创建约束解决方法2:
   ```
   SET FOREIGN_KEY_CHECKS = 0; 
   TRUNCATE TABLE TABLE_E;
   
   SET FOREIGN_KEY_CHECKS = 1;
   ```

参考:[ truncate foreign key constrained table](http://stackoverflow.com/questions/5452760/truncate-foreign-key-constrained-table)