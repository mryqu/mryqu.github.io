---
title: '[Hue] 清空MySQL数据库的hue.django_content_type表时遇到由于外键约束无法删除错误!'
date: 2016-08-26 05:24:54
categories: 
- Hadoop/Spark
- Hue
tags: 
- hue
- django_content_type
- delete
- foreign_key_constrai
- mysql
---
Hue （Hadoop User Experience）是一个使用ApacheHadoop分析数据的Web界面。它可以：
- 将数据加载到Hadoop
- 查看数据、处理数据或准备数据
- 分析数据、搜索数据、对数据进行可视化分析

![[Hue] 清空MySQL数据库的hue.django_content_type表时遇到由于外键约束无法删除错误！](/images/2016/8/0026uWfMzy77IKYxdW7bf.jpg) 默认Hue服务器使用嵌入式数据库SQLite存储元数据和查询信息。当我将其迁移到MySQL时，按照[Cloudera - Hue Installation Guide](https://archive.cloudera.com/cdh5/cdh/5/hue/manual.html)的步骤同步数据库时后清空MySQL中的django_content_type表时遭遇下列问题：
```
hadoop@node50064:~$ $HUE_HOME/build/env/bin/hue syncdb --noinput
Syncing...
Creating tables ...
Creating table auth_permission
Creating table auth_group_permissions
Creating table auth_group
Creating table auth_user_groups
Creating table auth_user_user_permissions
Creating table auth_user
Creating table django_openid_auth_nonce
Creating table django_openid_auth_association
Creating table django_openid_auth_useropenid
Creating table django_content_type
Creating table django_session
Creating table django_site
Creating table django_admin_log
Creating table south_migrationhistory
Creating table axes_accessattempt
Creating table axes_accesslog
Installing custom SQL ...
Installing indexes ...
Installed 0 object(s) from 0 fixture(s)

Synced:
 > django.contrib.auth
 > django_openid_auth
 > django.contrib.contenttypes
 > django.contrib.sessions
 > django.contrib.sites
 > django.contrib.staticfiles
 > django.contrib.admin
 > south
 > axes
 > about
 > filebrowser
 > help
 > impala
 > jobbrowser
 > metastore
 > proxy
 > rdbms
 > zookeeper
 > indexer

Not synced (use migrations):
 - django_extensions
 - desktop
 - beeswax
 - hbase
 - jobsub
 - oozie
 - pig
 - search
 - security
 - spark
 - sqoop
 - useradmin
 - notebook
(use ./manage.py migrate to migrate these)
hadoop@node50064:~$ mysql -uhue -psecretpassword -e "DELETE FROM hue.django_content_type;"
ERROR 1451 (23000) at line 1: Cannot delete or update a parent row: a foreign key constraint fails (`hue`.`auth_permission`, CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`))
```

在网上搜了搜，最后找到Cloudera更新一点的文档[Using an External Database for Hue Using the Command Line](http://www.cloudera.com/documentation/enterprise/latest/topics/cdh_ig_hue_database.html)，根据其建议的下列方式解决了问题：
```
hadoop@node50064:~$ mysql -uhue -psecretpassword -e "show create table hue.auth_permission \G;"
*************************** 1. row ***************************
       Table: auth_permission
Create Table: CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  **CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)**
) **ENGINE=InnoDB** AUTO_INCREMENT=40 DEFAULT CHARSET=utf8
hadoop@node50064:~$ mysql -uhue -psecretpassword -e "alter table hue.auth_permission drop foreign key content_type_id_refs_id_d043b34a;"
hadoop@node50064:~$ mysql -uhue -psecretpassword -e "DELETE FROM hue.django_content_type;"
```

### 参考

[http://grokbase.com/t/cloudera/scm-users/12achamnx1/hue-instructions](http://grokbase.com/t/cloudera/scm-users/12achamnx1/hue-instructions)    
[https://groups.google.com/a/cloudera.org/forum/#!topic/hue-user/49o80Q-49CU](https://groups.google.com/a/cloudera.org/forum/#!topic/hue-user/49o80Q-49CU)    