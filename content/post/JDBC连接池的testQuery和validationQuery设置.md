---
title: 'JDBC连接池的testQuery/validationQuery设置'
date: 2014-05-07 21:20:32
categories: 
- Service及JavaEE
tags: 
- jdbc
- 连接池
- testquery
- validationquery
- 数据库
---
在《[Tomcat中使用Connector/J连接MySQL的超时问题](/post/tomcat中使用connectorj连接mysql的超时问题)》帖子中想要增加对连接池中连接的测试/验证，防止数据库认为连接已死而Web应用服务器认为连接还有效的问题，Mysql文档中提到Tomcat文档中的例子中用的是validationQuery，但是网上还有很多帖子写的是testQuery，到底用哪一个呢？
原来这跟连接池的实现有关：

|连接池实现|该功能属性名
|-----
|[The Tomcat JDBC Connection Pool](https://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html)|validationQuery
|[The Apache Commons DBCP Connection Pool](http://commons.apache.org/proper/commons-dbcp/configuration.html)|validationQuery
|[c3p0 - JDBC3 Connection and Statement Pooling](http://www.mchange.com/projects/c3p0/#preferredTestQuery)|preferredTestQuery
|[ Atomikos：Tomcat Spring ActiveMQ MySQL JMX Integration](http://www.atomikos.com/Documentation/TomcatSpringActiveMQMySQLJMXIntegration)<br>[分析Atomikos数据连接池源码，弄清testQuery](http://blog.csdn.net/fbysss/article/details/5393626)|testQuery

此外，测试/验证连接池连接的SQL语句也因数据库而异：
[Efficient SQL test query or validation query that will work across all (or most) databases](http://stackoverflow.com/questions/3668506/efficient-sql-test-query-or-validation-query-that-will-work-across-all-or-most)
[DBCP - validationQuery for different Databases](http://vondrnotes.blogspot.com.au/2012/05/validationquery-for-different-databases.html)

综合上述两个帖子，汇总结果如下：

|数据库|测试/验证查询
|-----
|MySQL|SELECT 1
|PostgreSQL|SELECT 1
|Microsoft SQL Server|SELECT 1
|SQLite|SELECT 1
|H2|SELECT 1
|Ingres|SELECT 1
|Oracle|select 1 from dual
|DB2|select 1 from sysibm.sysdummy1 或SELECT current date FROM sysibm.sysdummy1
|Apache Derby|VALUES 1 FROM SYSIBM.SYSDUMMY1 或SELECT 1 FROM SYSIBM.SYSDUMMY1
|HSQLDB|SELECT 1 FROM any_existing_table WHERE 1=0 或SELECT 1 FROM INFORMATION_SCHEMA.SYSTEM_USERS
|Informix|select count(*) from systables
