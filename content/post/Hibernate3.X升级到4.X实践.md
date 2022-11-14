---
title: 'Hibernate3.X升级到4.X实践'
date: 2013-06-07 22:49:33
categories: 
- Service+JavaEE
tags: 
- hibernate
- hibernate3
- hibernate4
- 升级
- 实践
---
### Jar调查

|**jar文件**|**Hibernate 4.2.2**|**当前的Hibernate**|**操作**
|---
|antlr.jar|required, 2.7.7|3.2.0|无需改变。
|dom4j.jar|required, 1.6.1|1.6.1|无需改变。
|hibernate-commons-annotations.jar|required, 4.0.2|3.3.1|替换。
|hibernate-corel.jar|required, 4.2.2|3.2.6|替换。
|hibernate-jpa-2.0-api.jar|required, 1.0.1||增加。
|javassist.jar|required, 3.15.0|3.15.0|无需改变。
|jboss-logging.jar|required, 3.1.0||增加。
|jboss-transaction-api_1.1_specl.jar|required, 1.0.1||一开始增加，后来去掉了。
|hibernate-annotations.jar|null|3.3.1|去掉。从Hibernate3.6.0开始hibernate-annotations被合并到hibernate-core。
|hibernate-entitymanager.jar|jpa, 4.2.2|3.2.2|替换。

### 修改HibernateUtil

将AnnotationConfiguration替换成Configuration；
在使用ServiceRegistry;
```
Configuration config = new Configuration().configure();
ServiceRegistry  serviceRegistry = newServiceRegistryBuilder()
 .applySettings(config.getProperties()).buildServiceRegistry();
sessionFactory = config.buildSessionFactory(serviceRegistry);
```

### Hibernate4不支持Ant HibernateToolTask。

使用Hibernate3和HibernateToolTask创建hibernate.cfg.xml
使用Hibernate4编译。
https://community.jboss.org/thread/177200

### 修改Web容器下的jar文件

- 替换hibernate3.jar为hibernate-core.jar
- 替换hibernate-commons-annotations.jar
- 删除ejb3-persistence.jar
- 删除hibernate-annotations.jar
- 复制hibernate-entitymanager.jar
- 复制hibernate-jpa-2.0-api.jar
- 复制jboss-logging.jar
- 复制jboss-transaction-api_1.1_spec.jar （最终没有复制）

### 通过删除jboss-transaction-api_1.1_spec.jar解决TransactionManager冲突
```
org.springframework.jndi.TypeMismatchNamingException: Objectof type [class com.atomikos.icatch.jta.J2eeTransactionManager]available at JNDI location [java:comp/env/TransactionManager] isnot assignable to [javax.transaction.TransactionManager]
```

### 通过删除ejb3-persistence.jar解决javax.persistence冲突
```
java.lang.NoSuchMethodError:javax.persistence.OneToMany.orphanRemoval()
```
ejb3-persistence.jar和hibernate-jpa-2.0-api.jar冲突。hibernate-jpa-2.0-api.jar无法删除，否则会导致java.lang.ClassNotFoundException:javax.persistence.Access。

### Atomikos没有正式支持Hibernate4，使用临时方案
```
java.lang.ClassNotFoundException:org.hibernate.transaction.JTATransactionFactory
```
AtomikosJTATransactionFactory扩展org.hibernate.transaction.JTATransactionFactory(实现org.hibernate.transaction.TransactionFactory接口).
在hibernate4实现中，JTATransactionFactory已被org.hibernate.engine.transaction.internal.jta.JtaTransactionFactory(实现org.hibernate.engine.transaction.spi.TransactionFactory接口)所取代。
http://fogbugz.atomikos.com/default.asp?community.6.2843.5

### 通过修改hibernate.cfg.xml配置解决NoClassDefFoundError
```
java.lang. NoClassDefFoundError: Could not load requestedclass :org.hibernate.hql.classic.ClassicQueryTranslatorFactory
```
将hibernate.query.factory_class设置为org.hibernate.hql.internal.classic.ClassicQueryTranslatorFactory

```
java.lang.NoClassDefFoundError:org/hibernate/cache/QueryCacheFactory
```
将hibernate.cache.query_cache_factory设置为org.hibernate.cache.internal.StandardQueryCacheFactory