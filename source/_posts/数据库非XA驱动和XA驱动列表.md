---
title: '数据库非XA驱动和XA驱动列表'
date: 2013-10-17 19:44:55
categories: 
- DB/NoSQL
tags: 
- non-xa
- xa
- jdbc
- 数据库驱动
- transaction
---
<table style="background-color: rgb(249, 249, 249); border: 1px solid rgb(170, 170, 170); table-layout: auto; border-collapse: collapse; color: rgb(0, 0, 0);"><tbody><tr><th>数据库</th><th>非XA驱动</th><th>XA驱动</th></tr><tr><td>Postgres</td><td>org.postgresql.Driver</td><td>org.postgresql.xa.PGXADataSource</td></tr><tr><td>MySQL</td><td>com.mysql.jdbc.Driver</td><td>com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</td></tr><tr><td>Oracle</td><td>oracle.jdbc.OracleDriver</td><td>oracle.jdbc.xa.client.OracleXADataSource</td></tr><tr><td>DB2</td><td>com.ibm.db2.jcc.DB2Driver</td><td>com.ibm.db2.jcc.DB2XADataSource</td></tr><tr><td>SQL Server</td><td>com.microsoft.sqlserver.jdbc.SQLServerDriver</td><td>com.microsoft.sqlserver.jdbc.SQLServerXADataSource</td></tr><tr><td>Teradata</td><td>com.teradata.jdbc.TeraDriver<br></td></tr></tbody></table>