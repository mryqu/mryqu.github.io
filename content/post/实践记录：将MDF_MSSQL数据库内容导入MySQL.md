---
title: '实践记录：将MDF MSSQL数据库内容导入MySQL'
date: 2009-09-24 10:37:58
categories: 
- DB/NoSQL
tags: 
- 数据库
- mysql
- 导入
- mdf
- sqlserver
---
玩一个例程源码，它使用的是SQL server数据库，虽然我机子装了VS2005带的SQL server2005，我还是想用MySQL。
把自己的转换过程草草记录下来，也不算太无聊吧。

【环境】VS2005附带的SQL server 2005 & MySQL 5.1

1、下载并安装Microsoft SQL Server Management StudioExpress（SSMSE）[ http://www.microsoft.com/downloadS/details.aspx?familyid=C243A5AE-4BD1-4E3D-94B8-5A0F62BF7796&displaylang=en](http://www.microsoft.com/downloadS/details.aspx?familyid=C243A5AE-4BD1-4E3D-94B8-5A0F62BF7796&displaylang=en)

2、 配置SQL2005

==SQL server configuration manager==
SQL server service -> 选择SQL serverbrower属性，修改模式为手动，然后启动SQL server brower

==SQL Server Surface Area Configuration ->Surface Area Configuration for Services and Connections==
SQLEXPRESS -> Database Engine ->Remote connection -> Local and remote connection& using both tcp/ip and named pipes

==SQL server configuration manager==
SQL server 2005 network configuration -> protocolsfor SQLEXPRESS -> 选择TCP/TP属性中IPAddresses，删掉动态端口，设定端口为1433

==Microsoft SQL Server Management Studio Express==
选择SQLEXPRESS属性 -> security -> SQLserver and Windows authentication modeSQLEXPRESS -> security -> logins-> 选择sa属性，修改密码

重启SQL server服务

==Microsoft SQL Server Management Studio Express==
SQLEXPRESS -> Databases邮件菜单Attach命令，导入MDF数据库文件

4、Mysql migration toolkit
==源数据库连接==
MS SQL Server
127.0.0.1：1433
username=sa password=？Database=？

==目的数据库连接==
MySQL Server
127.0.0.1：3306
username=root password=？

