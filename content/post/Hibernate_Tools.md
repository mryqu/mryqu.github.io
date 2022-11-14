---
title: 'Hibernate Tools实践'
date: 2015-08-29 07:19:26
categories: 
- Service+JavaEE
tags: 
- hibernate
- jpa
- entity
- generate
- table
---
以前用过hbm2ddlAnt任务通过Hibernate映射文件生成数据库DDL。现在使用JPA后，不知道还有没有标准工具了。找了一圈，还是HibernateTools。

## 通过JPA Entity类生成数据库表

### 在Eclipse中安装JBoss Tools中的Hibernate Tools插件

![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRW0YDMd2.png)

### 创建JPA项目CustomerDemo

#### 使用向导创建JPA项目

![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRW4nMu3a.png)

#### 项目基本设置

![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRW7zkO9e.png)

#### 设置JPA Facet

此处选用了EclipseLink 2.5.x平台。如选择Generatic2.1平台，在生成数据库Schema时会报“Generate Tables from Entities is notsupported by the Generic Platform”。
用户库ECLIPSELINK_JPA包含如下jar文件：
- eclipselink.jar
- javax.persistence.jar
- org.eclipse.persistence.jpa.modelgen.jar
- org.eclipse.persistence.jpars.jar

![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRWfowR1d.png)

### Entity类代码及设置

#### Customer类

```
package hello;

import javax.persistence.*;

@Entity
@Table(name="CUSTOMER")
public class Customer {

  @Id
  @Column(name="CUSTOMER_ID", nullable=false, updatable=false, unique=true)
  @GeneratedValue(strategy=GenerationType.AUTO)
  private Long id;
  @Column(name = "CUSTOMER_FNAME")
  private String firstName;
  @Column(name = "CUSTOMER_LNAME")
  private String lastName;

  protected Customer() {}

  public Customer(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  @Override
  public String toString() {
    return String.format(
        "Customer[id=%d, firstName='%s', lastName='%s']",
        id, firstName, lastName);
  }

  public Long getId() {
    return id;
  }

  public String getFirstName() {
    return firstName;
  }

  public String getLastName() {
    return lastName;
  }
}
```
![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRWj7ZAae.jpg)

#### 加入Persistent Unit

让Customer类由应用中的EntityManager实例管理。
![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRWnyP46e.jpg)

### 生成数据库表

![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xRWr0PFeb.jpg) ![[Hibernate Tools] 通过JPA Entity类生成数据库表](/images/2015/8/0026uWfMzy76xTXKsrQce.jpg)
生成的createDDL.sql文件：
```
CREATE TABLE CUSTOMER (CUSTOMER_ID BIGINT NOT NULL UNIQUE, CUSTOMER_FNAME VARCHAR(255), CUSTOMER_LNAME VARCHAR(255), PRIMARY KEY (CUSTOMER_ID))
CREATE TABLE SEQUENCE (SEQ_NAME VARCHAR(50) NOT NULL, SEQ_COUNT DECIMAL(38), PRIMARY KEY (SEQ_NAME))
INSERT INTO SEQUENCE(SEQ_NAME, SEQ_COUNT) values ('SEQ_GEN', 0)
```

生成的dropDLL.sql文件：
```
DROP TABLE CUSTOMER
DELETE FROM SEQUENCE WHERE SEQ_NAME = 'SEQ_GEN'
```

## 通过数据库表生成JPA Entity类

本文与前一博文 通过JPA Entity类生成数据库表 正好相反，实践一下如何通过数据库表生成JPA Entity类。

### 在Eclipse中安装JBoss Tools中的Hibernate Tools插件

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76xRW0YDMd2.png)

### 创建JPA项目PetStoreDemo

#### 使用向导创建JPA项目

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76xRW4nMu3a.png)

#### 项目基本设置

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIydl5I6e.png)

#### 设置JPA Facet

此处选用了Generatic 2.1平台，用户库HIBERNATE_JPA包含如下jar文件：
- hibernate-commons-annotations.jar
- hibernate-core.jar
- hibernate-jpa-2.1-api.jar

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIyfZOIe4.png)

### 通过数据库表生成JPA Entity类

#### 执行“Generate Entities from Tables”

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIyiDOv67.jpg)

#### 选择库表

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIykMkf27.png)

#### 设置库表关联关系

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIyoIMCd6.png)

#### 定制生成Entity的默认行为

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIysQhn45.png)

#### 设置单个Entity

![[Hibernate Tools] 通过数据库表生成JPA Entity类](/images/2015/8/0026uWfMzy76yIyvD7C9c.png)

#### 生成结果

下面以Item为例，展示生成结果。
```
package com.yqu.jpetstore;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="item")
@NamedQuery(name="Item.findAll", query="SELECT i FROM Item i")
public class Item implements Serializable {
  private static final long serialVersionUID = 1L;
  private String itemid;
  private String attr1;
  private String attr2;
  private String attr3;
  private String attr4;
  private String attr5;
  private BigDecimal listprice;
  private String status;
  private BigDecimal unitcost;
  private Product product;
  private Supplier supplierBean;

  public Item() {
  }

  @Id
  @GeneratedValue(strategy=GenerationType.AUTO)
  @Column(unique=true, nullable=false, length=10)
  public String getItemid() {
    return this.itemid;
  }

  public void setItemid(String itemid) {
    this.itemid = itemid;
  }

  @Column(length=80)
  public String getAttr1() {
    return this.attr1;
  }

  public void setAttr1(String attr1) {
    this.attr1 = attr1;
  }

  @Column(length=80)
  public String getAttr2() {
    return this.attr2;
  }

  public void setAttr2(String attr2) {
    this.attr2 = attr2;
  }

  @Column(length=80)
  public String getAttr3() {
    return this.attr3;
  }

  public void setAttr3(String attr3) {
    this.attr3 = attr3;
  }

  @Column(length=80)
  public String getAttr4() {
    return this.attr4;
  }

  public void setAttr4(String attr4) {
    this.attr4 = attr4;
  }

  @Column(length=80)
  public String getAttr5() {
    return this.attr5;
  }

  public void setAttr5(String attr5) {
    this.attr5 = attr5;
  }

  @Column(precision=10, scale=2)
  public BigDecimal getListprice() {
    return this.listprice;
  }

  public void setListprice(BigDecimal listprice) {
    this.listprice = listprice;
  }

  @Column(length=2)
  public String getStatus() {
    return this.status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  @Column(precision=10, scale=2)
  public BigDecimal getUnitcost() {
    return this.unitcost;
  }

  public void setUnitcost(BigDecimal unitcost) {
    this.unitcost = unitcost;
  }

  //bi-directional many-to-one association to Product
  @ManyToOne
  @JoinColumn(name="productid", nullable=false)
  public Product getProduct() {
    return this.product;
  }

  public void setProduct(Product product) {
    this.product = product;
  }

  //bi-directional many-to-one association to Supplier
  @ManyToOne
  @JoinColumn(name="supplier")
  public Supplier getSupplierBean() {
    return this.supplierBean;
  }

  public void setSupplierBean(Supplier supplierBean) {
    this.supplierBean = supplierBean;
  }
}
```
