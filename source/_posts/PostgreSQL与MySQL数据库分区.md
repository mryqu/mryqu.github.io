---
title: 'PostgreSQL与MySQL数据库分区'
date: 2013-07-16 21:10:39
categories: 
- DB/NoSQL
tags: 
- 数据库
- 分区
- partitioning
- mysql
- postgresql
---
数据库分区是逻辑数据库的分割。分区可以通过创建独立的较小数据库（每个有自己的表、索引和事物日志）或分割所选的元素（例如一个表）来实现。数据库分区通常是为了易管理性、性能和数据有效性。


## 分类

分区主要有两种形式：

### 水平分区

水平分区是将不同的行放入不同的表中。比如将邮编小于50000的客户放入“东部客户”表中，将邮编等于或大于50000的客户放入“西部客户”表中。该例中有两个分区表“东部客户”和“西部客户”，其合集视图就是所有客户的完整视图。
通过这样的方式不同分区里面的物理列分割的数据集得以组合，从而进行个体分割（单分区）或集体分割（1个或多个分区）。所有在表中定义的列在每个数据集中都能找到，所以表的特性依然得以保持。

### 垂直分区

垂直分区创建含有（主键加上）较少列的表并使用额外的表存储（主键加上）剩余的列，每个分区表中都含有其中列所对应的行。范式化是内在包含垂直分区的过程。
垂直分区被称为“行分割”，通常用于分割表中（查找很慢的）动态数据和（查找很快的、使用较动态数据更频繁的）静态数据。这样在保证数据相关性的同时，在诸如统计分析之类的查询中访问静态数据还能提高性能。
不同的物理存储也可以用于垂直分区，例如不频繁使用的列或者宽列被存入不同的设备。
其缺点是需要管理冗余列，查询所有数据需要join操作。


## 分区标准

当前高端关系数据库管理系统提供分割数据库的不同标准。这些标准使用分区键基于一定标准分配分区。常用的标准为：

### 基于范围的分区

通过判断分区键是否在一定范围内选择分区。例如所有邮编列在70000和79999之间的行可以是一个分区。

### 基于列表的分区

一个分区分配给一列数值。如果分区键为这些值之一，该分区被选中。例如所有国家列为冰岛、挪威、瑞典、芬兰或丹麦的行可以是一个北欧国家分区。

### 基于哈希的分区

哈希函数的返回值决定分区归属。假设有四个分区，哈希函数返回值为0到3。
组合分区允许上述分区方案的一定组合。例如先使用基于范围的分区，然后使用基于哈希的分区。


## PostgreSQL数据库分区

PostgreSQL支持基本的数据库分区，本文以PostgreSQL 9.1为例介绍一下PostgreSQL数据库分区。

### 优点

分区具有下列优点：
- 在某些情况下查询性能能显著提升，特别是表中频繁访问的行在一个单独分区或者少数量分区中。分区替代索引起始列会减少索引大小，使频繁使用的索引更有可能放入内存。
- 当查询或更新访问单个分区的大部分记录时，通过对分区的顺序扫描取代对全表的索引读或随机读，也会提升性能。
- 如果批量加载和删除需求付诸于分区设计，这些需求可以通过添加或删除分区来完成。ALTER TABLE NOINHERIT和DROP TABLE都比批量操作更快，而且完全可以避免批量删除导致的VACUUM负担。
- 很少使用的数据可被移往更便宜更慢的存储媒体。

这些优点仅在表非常大时是真正有价值的。对表采用分区的收益取决于应用程序，一般经验法则是表超过了数据库服务器的物理内存时使用分区。

### 表继承

PostgreSQL通过表继承支持分区，每个分区作为单个父表的子表创建。父表本身通常为空，仅用于代表整个数据集。
```
CREATE TABLE cities (
    name            text,
    population      float,
    altitude        int     -- in feet
);

CREATE TABLE capitals (
    state           char(2)
) INHERITS (cities);
```
父表的所有check约束和not-null约束自动被子表继承，其他类型的约束（unique、主键和外键约束）不会被继承。
```
SELECT name, altitude FROM cities WHERE altitude > 500;
SELECT name, altitude FROM ONLY cities WHERE altitude > 500;    
-- 通过ONLY关键词，第二个查询仅作用于表cities而不会用于cities的子表。
```

### 支持的分区标准

PostgreSQL数据库支持基于范围的分区和基于列表的分区。

### 分区实现案例

- 创建主表measurement
   ```
   CREATE TABLE measurement (
       city_id         int not null,
       logdate         date not null,
       peaktemp        int,
       unitsales       int
   );
   ```
- 创建分区表
   ```
   CREATE TABLE measurement_y2006m02 (
       CHECK ( logdate >= DATE '2006-02-01' AND logdate < DATE '2006-03-01' )
   ) INHERITS (measurement);
   
   CREATE TABLE measurement_y2006m03 (
       CHECK ( logdate >= DATE '2006-03-01' AND logdate < DATE '2006-04-01' )
   ) INHERITS (measurement);
   
   ...
   
   CREATE TABLE measurement_y2007m11 (
       CHECK ( logdate >= DATE '2007-11-01' AND logdate < DATE '2007-12-01' )
   ) INHERITS (measurement);
   
   CREATE TABLE measurement_y2007m12 (
       CHECK ( logdate >= DATE '2007-12-01' AND logdate < DATE '2008-01-01' )
   ) INHERITS (measurement);
   
   CREATE TABLE measurement_y2008m01 (
       CHECK ( logdate >= DATE '2008-01-01' AND logdate < DATE '2008-02-01' )
   ) INHERITS (measurement);
   ```
- 为分区表的键列创建索引（可选）
   ```
   CREATE INDEX measurement_y2006m02_logdate ON measurement_y2006m02 (logdate);
   CREATE INDEX measurement_y2006m03_logdate ON measurement_y2006m03 (logdate);
   
   ...
   
   CREATE INDEX measurement_y2007m11_logdate ON measurement_y2007m11 (logdate);
   CREATE INDEX measurement_y2007m12_logdate ON measurement_y2007m12 (logdate);
   CREATE INDEX measurement_y2008m01_logdate ON measurement_y2008m01 (logdate);
   ```
- 创建触发器
   ```
   CREATE OR REPLACE FUNCTION measurement_insert_trigger()
   RETURNS TRIGGER AS $$
   BEGIN
       IF ( NEW.logdate >= DATE '2006-02-01' AND
            NEW.logdate < DATE '2006-03-01' ) THEN
           INSERT INTO measurement_y2006m02 VALUES (NEW.*);
       ELSIF ( NEW.logdate >= DATE '2006-03-01' AND
               NEW.logdate < DATE '2006-04-01' ) THEN
           INSERT INTO measurement_y2006m03 VALUES (NEW.*);
       ...
       ELSIF ( NEW.logdate >= DATE '2008-01-01' AND
               NEW.logdate < DATE '2008-02-01' ) THEN
           INSERT INTO measurement_y2008m01 VALUES (NEW.*);
       ELSE
           RAISE EXCEPTION 'Date out of range.  Fix the measurement_insert_trigger() function!';
       END IF;
   
       RETURN NULL;
   END;
   
   $$
   
   LANGUAGE plpgsql;
   
   CREATE TRIGGER insert_measurement_trigger
       BEFORE INSERT ON measurement
       FO EACH ROW EXECUTE PROCEDURE measurement_insert_trigger();
   ```

约束排除是一种能够提高分区表性能的查询优化技术。当使用约束排除，下列查询会仅扫描分区表measurement_y2008m01；当禁止掉约束排除，查询会扫描measurement的所有分区表。
```
SET constraint_exclusion = on;
SELECT count(*) FROM measurement WHERE logdate >= DATE '2008-01-01';
```


## MySQL数据库分区

MySQL从5.1开始支持数据库分区，本文以MySQL 5.7为例介绍一下MySQL数据库分区。

### 支持的分区类型

- 基于范围的分区
- 基于列表的分区
- 基于哈希的分区
- 基于键的分区
- 子分区--组合分区

基于键的分区之外的其他分区类型所使用的列受限于INT或NULL类型(RANGE COLUMNS和LIST COLUMNS还可处理DATE和DATETIME类型)，基于键的分区没有这个限制。
对于NULL，MySQL的分区实现把它当作任何非空的值都小来处理

### 基于范围的分区

使用PARTITION BY RANGE关键词的分区表达式返回结果必须是整数型的。
```
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT NOT NULL,
    store_id INT NOT NULL
)

PARTITION BY RANGE (store_id) (
    PARTITION p0 VALUES LESS THAN (6),
    PARTITION p1 VALUES LESS THAN (11),
    PARTITION p2 VALUES LESS THAN (16),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);
```

```
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)

PARTITION BY RANGE ( YEAR(separated) ) (
    PARTITION p0 VALUES LESS THAN (1991),
    PARTITION p1 VALUES LESS THAN (1996),
    PARTITION p2 VALUES LESS THAN (2001),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);
```

```
CREATE TABLE quarterly_report_status (
    report_id INT NOT NULL,
    report_status VARCHAR(20) NOT NULL,
    report_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

PARTITION BY RANGE ( UNIX_TIMESTAMP(report_updated) ) (
    PARTITION p0 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-01-01 00:00:00') ),
    PARTITION p1 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-04-01 00:00:00') ),
    PARTITION p2 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-07-01 00:00:00') ),
    PARTITION p3 VALUES LESS THAN ( UNIX_TIMESTAMP('2008-10-01 00:00:00') ),
    PARTITION p4 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-01-01 00:00:00') ),
    PARTITION p5 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-04-01 00:00:00') ),
    PARTITION p6 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-07-01 00:00:00') ),
    PARTITION p7 VALUES LESS THAN ( UNIX_TIMESTAMP('2009-10-01 00:00:00') ),
    PARTITION p8 VALUES LESS THAN ( UNIX_TIMESTAMP('2010-01-01 00:00:00') ),
    PARTITION p9 VALUES LESS THAN (MAXVALUE)
);
```

使用PARTITION BY RANGE COLUMNS关键词的分区表达式可以是DATE或DATETIME类型，并且可以接受多列作为一个元组进行分区。
```
CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)

PARTITION BY RANGE COLUMNS(joined) (
    PARTITION p0 VALUES LESS THAN ('1960-01-01'),
    PARTITION p1 VALUES LESS THAN ('1970-01-01'),
    PARTITION p2 VALUES LESS THAN ('1980-01-01'),
    PARTITION p3 VALUES LESS THAN ('1990-01-01'),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
```

```
CREATE TABLE rangecolumn (
    a INT,
    b INT
)

PARTITION BY RANGE COLUMNS(a,b) (
    PARTITION p0 VALUES LESS THAN (0,10),
    PARTITION p1 VALUES LESS THAN (10,20),
    PARTITION p2 VALUES LESS THAN (10,30),
    PARTITION p3 VALUES LESS THAN (10,35),
    PARTITION p4 VALUES LESS THAN (20,40),
    PARTITION p5 VALUES LESS THAN (MAXVALUE,MAXVALUE)
);
```

### 基于列表的分区

使用PARTITION BY LIST关键词的分区表达式返回结果必须是整数型的。
```
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)

PARTITION BY LIST(store_id) (
    PARTITION pNorth VALUES IN (3,5,6,9,17),
    PARTITION pEast VALUES IN (1,2,10,11,19,20),
    PARTITION pWest VALUES IN (4,12,13,14,18),
    PARTITION pCentral VALUES IN (7,8,15,16)
);
```

使用PARTITION BY LIST COLUMNS关键词的分区表达式可以是DATE或DATETIME类型，并且可以接受多列作为一个元组进行分区。
```
CREATE TABLE customers_2 (
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    street_1 VARCHAR(30),
    street_2 VARCHAR(30),
    city VARCHAR(15),
    renewal DATE
)

PARTITION BY LIST COLUMNS(renewal) (
    PARTITION pWeek_1 VALUES IN('2010-02-01', '2010-02-02', '2010-02-03',
        '2010-02-04', '2010-02-05', '2010-02-06', '2010-02-07'),
    PARTITION pWeek_2 VALUES IN('2010-02-08', '2010-02-09', '2010-02-10',
        '2010-02-11', '2010-02-12', '2010-02-13', '2010-02-14'),
    PARTITION pWeek_3 VALUES IN('2010-02-15', '2010-02-16', '2010-02-17',
        '2010-02-18', '2010-02-19', '2010-02-20', '2010-02-21'),
    PARTITION pWeek_4 VALUES IN('2010-02-22', '2010-02-23', '2010-02-24',
        '2010-02-25', '2010-02-26', '2010-02-27', '2010-02-28')
);
```

### 基于哈希的分区

使用PARTITION BY HASH关键字的哈希算法是简单地对分区数取模。
```
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)

PARTITION BY HASH(store_id)
PARTITIONS 4;
```

使用PARTITION BY LINEAR HASH关键字的线性哈希算法：
V是大于等于分区数的最接近的2的幂数。计算方法为：V = POWER(2, CEILING(LOG(2, 分区数)))
Set N = F(column_list) & (V - 1).
当N大于等于分区数时，做如下循环计算直至小于分区数：
  V = CEIL(V / 2)
  N = N & (V - 1)

```
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)

PARTITION BY LINEAR HASH( YEAR(hired) )
PARTITIONS 6;
```

如果一个员工2003年入职，则分区为#3。
V = POWER(2, CEILING( LOG(2,6) )) = 8
N = YEAR('2003-04-14') & (8 - 1)
   = 2003 & 7
   = 3

如果一个员工1998年入职，则分区为#2。
V = 8
N = YEAR('1998-10-19') & (8-1)
  = 1998 & 7
  = 6
N = 6 & CEILING(8 / 2)
  = 6 & 3
  = 2

### 基于键的分区

基于键的分区与基于哈希的分区类似，除了基于哈希的分区使用用户自定义的表达式，而基于键的分区使用MySQL提供的与PASSWORD()相类似的哈希算法。
键列表可以为空，也可以为多个列名。
键列表为空，使用主键id。
```
CREATE TABLE k1 (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20)
)

PARTITION BY KEY()
PARTITIONS 2;
```

键列表为空，使用UNIQUE键KEY。
```
CREATE TABLE k1 (
    id INT NOT NULL,
    name VARCHAR(20),
    UNIQUE KEY (id)
)

PARTITION BY KEY()
PARTITIONS 2;
```

键列表为s1,此例效果等同于空的键列表。
```
CREATE TABLE tm1 (
    s1 CHAR(32) PRIMARY KEY
)

PARTITION BY KEY(s1)
PARTITIONS 10;
```

使用PARTITION BY LINEAR KEY关键字与使用PARTITION BY LINEAR HASH关键字具有一样的效果。
```
CREATE TABLE tk (
    col1 INT NOT NULL,
    col2 CHAR(5),
    col3 DATE
)

PARTITION BY LINEAR KEY (col1)
PARTITIONS 3;
```

### 子分区--组合分区

子分区隐形定义：
```
CREATE TABLE ts (id INT, purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) )
    SUBPARTITIONS 2 (
        PARTITION p0 VALUES LESS THAN (1990),
        PARTITION p1 VALUES LESS THAN (2000),
        PARTITION p2 VALUES LESS THAN MAXVALUE
    );
```

子分区显性定义：
```
CREATE TABLE ts (id INT, purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990) (
            SUBPARTITION s0,
            SUBPARTITION s1
        ),
        PARTITION p1 VALUES LESS THAN (2000) (
            SUBPARTITION s2,
            SUBPARTITION s3
        ),
        PARTITION p2 VALUES LESS THAN MAXVALUE (
            SUBPARTITION s4,
            SUBPARTITION s5
        )
    );    
```

### 分区修剪（Partition Pruning）

分区修剪与PostgreSQL数据库的约束排除功能一样，就是不扫描与值不匹配的分区。

### 分区选择

PostgreSQL数据库需要为分区创建表，而MySQL不需要。那如何仅对某个分区进行查询呢？分区选择就是解决这一需求的方案。
```
CREATE TABLE employees  (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(25) NOT NULL,
    lname VARCHAR(25) NOT NULL,
    store_id INT NOT NULL,
    department_id INT NOT NULL
)   

PARTITION BY RANGE(id)  (
    PARTITION p0 VALUES LESS THAN (5),
    PARTITION p1 VALUES LESS THAN (10),
    PARTITION p2 VALUES LESS THAN (15),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);
```

下面的查询语句仅应用于分区p1。
```
SELECT * FROM employees PARTITION (p1);
```

### 分区约束与限制

MySQL分区的约束与限制很多，这里就不列举了，详见[MySQL手册](http://dev.mysql.com/doc/refman/5.7/en/partitioning-limitations.html)。