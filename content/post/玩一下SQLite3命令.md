---
title: '玩一下SQLite3命令'
date: 2014-07-10 20:29:31
categories: 
- DB/NoSQL
tags: 
- database
- sqlite
- 命令
---
# SQLite介绍

SQLite是实现自包含、无需服务器、零配置和事务SQL数据库引擎的软件库。它占用资源非常低，既可以用于Windows/Linux/Unix等主流的操作系统，也广泛用于嵌入式产品中。它能够跟很多程序语言相结合，比如Tcl、C#、PHP、Java等，还有ODBC接口。
不像常见的客户-服务器范例，SQLite引擎不是个程序与之通信的独立进程，而是连接到程序中成为它的一个主要部分。所以主要的通信协议是在编程语言内的直接API调用。这在消耗总量、延迟时间和整体简单性上有积极的作用。整个数据库(定义、表、索引和数据本身)都在宿主主机上存储在一个单一的文件中。它的简单的设计是通过在开始一个事务的时候锁定整个数据文件而完成的。

# SQLITE常用命令使用

SQLite命令行解释器除了支持SQL语句（大小写不敏感），还支持以.开头、大小写敏感的专有命令。SQLite网站有个帖子[Command Line Shell For SQLite](http://www.sqlite.org/cli.html)介绍了支持的所有命令，这里挑一些常用的玩一下。
- .help命令：给出所有命令的帮助介绍
   ```
   sqlite> .help
   ```
- .prompt：更换提示符
   ```
   sqlite> .prompt >>
   >>
   >>.prompt sqlite>
   sqlite>
   ```
- .show：显示当前设置
   ```
   sqlite>.show
        echo: off
         eqp: off
     explain: off
     headers: off
        mode: list
   nullvalue: ""
      output: stdout
   separator: "|"
       stats: off
       width:
   ```
- .database：显示数据库信息
   ```
   sqlite>.database
   seq  name             file
   ---  ---------------  ----------------------------------------------------------
   0    main             E:\gitws\datasci_course_materials\assignment2\reuters.db
   1    temp
   ```
- .tables：显示表信息
   ```
   sqlite>.tables
   Frequency
   ```
- .schema：显示表的创建语句
   ```
   sqlite>.schema
   CREATE TABLE Frequency (
   docid VARCHAR(255),
   term VARCHAR(255),
   count int,
   PRIMARY KEY(docid, term));
   ```
- .mode：设置SQL结果输出格式
   ```
   sqlite>.mode csv
   sqlite>select * from Frequency limit 3;
   10000_txt_earn,net,1
   10000_txt_earn,rogers,4
   10000_txt_earn,earnings,2

   sqlite>.mode column
   sqlite>select * from Frequency limit 3;
   10000_txt_earn  net         1
   10000_txt_earn  rogers      4
   10000_txt_earn  earnings    2

   sqlite> .mode html
   sqlite> select * from Frequency limit 3;
   <TR><TD>10000_txt_earn</TD>
   <TD>net</TD>
   <TD>1</TD>
   </TR>
   <TR><TD>10000_txt_earn</TD>
   <TD>rogers</TD>
   <TD>4</TD>
   </TR>
   <TR><TD>10000_txt_earn</TD>
   <TD>earnings</TD>
   <TD>2</TD>
   </TR>

   sqlite>.mode insert
   sqlite>select * from Frequency limit 3;
   INSERT INTO table VALUES('10000_txt_earn','net',1);
   INSERT INTO table VALUES('10000_txt_earn','rogers',4);
   INSERT INTO table VALUES('10000_txt_earn','earnings',2);

   sqlite>.mode line
   sqlite>select * from Frequency limit 3;
   docid = 10000_txt_earn
    term = net
   count = 1
   
   docid = 10000_txt_earn
    term = rogers
   count = 4
   
   docid = 10000_txt_earn
    term = earnings
   count = 2

   sqlite>.mode list
   sqlite>select * from Frequency limit 3;
   10000_txt_earn,net,1
   10000_txt_earn,rogers,4
   10000_txt_earn,earnings,2

   sqlite>.mode tabs
   sqlite>select * from Frequency limit 3;
   10000_txt_earn  net     1
   10000_txt_earn  rogers  4
   10000_txt_earn  earnings        2

   sqlite>.mode tcl
   sqlite>select * from Frequency limit 3;
   "10000_txt_earn" "net" "1"
   "10000_txt_earn" "rogers" "4"
   "10000_txt_earn" "earnings" "2"
   sqlite>
   ```
- .open：关闭当前数据库并打开新数据库
   ```
   sqlite>.open reuters.db
   ```
- .backup：备份数据库（默认 main）到文件
   ```
   sqlite>.backup test.db
   ```
- .dump：以SQL文本格式转储数据库
   ```
   sqlite>.dump Frequency
   ```
- .read：执行SQL文件
   ```
   sqlite>.read test.sql
   ```
- .exit或.quit：退出
   ```
   sqlite>.quit
   E:\gitws\datasci_course_materials\assignment2>
   ```

# 参考

[Command Line Shell For SQLite](http://www.sqlite.org/cli.html)[SQLite Core Functions](http://www.sqlite.org/lang_corefunc.html)  