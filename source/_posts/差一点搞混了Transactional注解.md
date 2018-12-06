---
title: '差一点搞混了Transactional注解'
date: 2014-04-01 20:03:28
categories: 
- Service及JavaEE
- Spring
tags: 
- transactional
- anotation
- javaee
- spring
---
今天给我的Srping业务层加如下Service和Transactional注解：
```
@Service
@Scope(BeanDefinition.SCOPE_SINGLETON)
@Transactional(propagation=Propagation.REQUIRED,
               timeout=600, 
               rollbackFor=Exception.class)
```

结果总是不认propagation、timeout和rollbackFor，后来才发现我引入类定义错了，本来应该用Spring的[org.springframework.transaction.annotation.Transactional](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/transaction/annotation/Transactional.html)，可是引入了JavaEE用于CDI(Contextsand Dependency Injection for the Java EEplatform，上下文和依赖注入)bean的[javax.transaction.Transactional](https://javaee-spec.java.net/nonav/javadocs/javax/transaction/Transactional.html),不注意还真容易混淆。