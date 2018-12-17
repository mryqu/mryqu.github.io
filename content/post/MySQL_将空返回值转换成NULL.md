---
title: '[MySQL] 将空返回值转换成NULL'
date: 2017-04-01 06:17:43
categories: 
- DB/NoSQL
tags: 
- mysql
- sql
- ifnull
- coalesce
- empty
- null
- DB
---
当MySQL没有搜索到任何匹配行时，会返回空返回值，如何转换成NULL呢？

#### 方法一
```
select (original_select_statement) as Alias
```
这种方法仅对一个单值有效，即：
*   原语句返回单值，该值将被返回
*   原语句返回单列零行，将返回NULL
*   原语句返回多列或多行，查询失败

#### 方法二

使用IFNULL或COALESCE函数。