---
title: 'Activiti 5.17 JNDI数据源配置'
date: 2015-02-12 20:18:53
categories: 
- workflow
tags: 
- activiti
- mysql
- jndi
- datasource
- postgres
---
Activiti演示环境采用的是[h2](http://www.h2database.com/html/main.html)内存数据库。为了便于研究代码，所以将其迁移到我已有的MySQL/PostgreSQL数据库上去。

## MySQL

### MySQL配置
activiti数据库DDL文件位于activiti-engine-5.17.0.jar\org\activiti\db\create\，MySQL 5.6.4及其之后版本与之前的版本使用的是不同的DDL文件。将下列用于MySQL5.6.4+的DDL文件提取保存到某一目录下。
- activiti.mysql.create.engine.sql
- activiti.mysql.create.identity.sql
- activiti.mysql.create.history.sql

MySQL命令如下：
```
create database ActivitiDB character set utf8 collate utf8_general_ci;
use ActivitiDB;
source c:/activiti.mysql.create.engine.sql;
source c:/activiti.mysql.create.identity.sql;
source c:/activiti.mysql.create.history.sql;
```

### Tomcat配置
删除下列MyBatis配置文件：
- apache-tomcat-7\webapps\activiti-explorer\WEB-INF\classes\db.properties
- apache-tomcat-7\webapps\activiti-rest\WEB-INF\classes\db.properties

修改下列Spring配置文件：
- apache-tomcat-7\webapps\activiti-explorer\WEB-INF\classes\activiti-custom-context.xml
- apache-tomcat-7\webapps\activiti-rest\WEB-INF\classes\activiti-custom-context.xml

去掉XMl注释，删除"dbProperties"bean，将"dataSource"bean改成JNDI数据源。
![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6Q2Kx9lHn5d.jpg)

修改下列Tomcat上下文，配置Tomcat JNDI资源：
- apache-tomcat-7\webapps\activiti-explorer\META-INF\context.xml![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6Q2KAdHkX57.jpg)
- apache-tomcat-7\webapps\activiti-rest\META-INF\context.xml![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6Q2KB71NQee.jpg)

## PostgreSQL

### PostgreSQL配置
activiti数据库DDL文件位于activiti-engine-5.17.0.jar\org\activiti\db\create\，将下列用于PostgreSQL的DDL文件提取保存到某一目录下。
- activiti.postgres.create.engine.sql
- activiti.postgres.create.identity.sql
- activiti.postgres.create.history.sql

PostgreSQL命令如下：
```
CREATE DATABASE ActivitiDB WITH ENCODING 'UTF8' TEMPLATE=template0;
\c ActivitiDB;
\i c:/activiti.postgres.create.engine.sql;
\i c:/activiti.postgres.create.identity.sql;
\i c:/activiti.postgres.create.history.sql;
```

### Tomcat配置

删除下列MyBatis配置文件：
- apache-tomcat-7\webapps\activiti-explorer\WEB-INF\classes\db.properties
- apache-tomcat-7\webapps\activiti-rest\WEB-INF\classes\db.properties

修改下列Spring配置文件：
- apache-tomcat-7\webapps\activiti-explorer\WEB-INF\classes\activiti-custom-context.xml
- apache-tomcat-7\webapps\activiti-rest\WEB-INF\classes\activiti-custom-context.xml

去掉XMl注释，删除"dbProperties"bean，将"dataSource"bean改成JNDI数据源。
![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6Q2Kx9lHn5d.jpg)

修改下列Tomcat上下文，配置Tomcat JNDI资源：
- apache-tomcat-7\webapps\activiti-explorer\META-INF\context.xml
   ![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6QN85B6Hp03.jpg)
- apache-tomcat-7\webapps\activiti-rest\META-INF\context.xml
   ![Activiti 5.17 JNDI数据源配置](/images/2015/2/0026uWfMgy6QN87gXNp13.jpg)