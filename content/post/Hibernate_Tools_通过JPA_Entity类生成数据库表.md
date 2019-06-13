---
title: '[Hibernate Tools] 通过JPA Entity类生成数据库表'
date: 2015-08-29 07:19:26
categories: 
- Service+JavaEE
- Hibernate
tags: 
- hibernate
- jpa
- entity
- generate
- table
---
以前用过hbm2ddlAnt任务通过Hibernate映射文件生成数据库DDL。现在使用JPA后，不知道还有没有标准工具了。找了一圈，还是HibernateTools。

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