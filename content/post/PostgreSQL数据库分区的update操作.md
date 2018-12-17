---
title: 'PostgreSQL数据库分区的update操作'
date: 2013-07-19 23:23:36
categories: 
- DB/NoSQL
tags: 
- postgresql
- 数据库
- 分区
- update
- 操作
---
```
CREATE TABLE measurement (
   city_id        int not null,
   unitsales      int
);
 
CREATE TABLE measurement_1 (
    CHECK (unitsales < 100 )
) INHERITS (measurement);
CREATE TABLE measurement_2 (
    CHECK (unitsales >= 100 )
) INHERITS (measurement);
 
CREATE OR REPLACE FUNCTIONmeasurement_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.unitsales < 100) THEN
       INSERT INTO measurement_1 VALUES (NEW.*);
    ELSE
       INSERT INTO measurement_2 VALUES (NEW.*);
    END IF;
    RETURNNULL;
END;
$$
LANGUAGE plpgsql;
 
CREATE TRIGGER insert_measurement_trigger
    BEFOREINSERT ON measurement
    FOR EACH ROWEXECUTE PROCEDURE measurement_insert_trigger();
   
INSERT INTO measurement VALUES (1, 1);
INSERT INTO measurement VALUES (2, 2);
INSERT INTO measurement VALUES (3, 300);
INSERT INTO measurement VALUES (4, 400);
 
mysdm=# select * from measurement_1;
city_id | unitsales
---------+-----------
      1|        1
      2|        2
(2 rows)
 
 
mysdm=# select * from measurement_2;
city_id | unitsales
---------+-----------
      3|      300
      4|      400
(2 rows)
```

**Postgres没有智能到在update时根据记录的新值变动分区，而是报错！**
```
mysdm=# updatemeasurement set unitsales=5 where city_id = 3;
ERROR:  new row for relation"measurement_2" violates check constraint"measurement_2_unitsales_check"
```

**如果新值符合原分区的约束，则更新成功。**
**这也证明了仅对insert操作设置触发器，无需对update操作设置触发器。****。**
```
mysdm=# update measurement set unitsales=500where city_id = 3;
UPDATE 1
mysdm=# select * from measurement_2;
city_id | unitsales
---------+-----------
      4|      400
      3|      500
(2 rows)
```