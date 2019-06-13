---
title: '[JPA] CascadeType.REMOVE与orphanRemoval的区别'
date: 2013-10-26 13:15:59
categories: 
- db+nosql
tags: 
- jpa
- hibernate
- remove
- cascadetype
- orphanremoval
---
### Cascading Remove

将引用字段标注为CascadeType.REMOVE（或包含REMOVE的CascadeType.ALL）表明删除操作将应该自动级联到由该字段引用的实体对象（多个实体对象可以由集合字段引用）:
```
@Entity
class Employee {
     :
    @OneToOne(cascade=CascadeType.REMOVE)
    private Address address;
     :
}
```

### Orphan Removal

JPA2额外支持一种更积极的删除级联模式，可以通过@OneToOne和@OneToMany注释的orphanRemoval元素设置:
```
@Entity
class Employee {
     :
    @OneToOne(orphanRemoval=true)
    private Address address;
     :
}
```

### 区别

两个设置的区别在于关系断开的响应。 例如，将地址字段设置为null或另一个Address对象时，不同设置的结果是不同。
- 如果指定了 **orphanRemoval = true**，则断开关系的的Address实例将被自动删除。这对于清除没有所有者对象（例如Employee）引用的、不该存在的依赖对象（例如Address）很有用。
- 如果仅指定 **cascade = CascadeType.REMOVE**，则不会执行上述自动删除操作，因为断开关系不是删除操作。

### 参考

[Deleting JPA Entity Objects](http://www.objectdb.com/java/jpa/persistence/delete)    