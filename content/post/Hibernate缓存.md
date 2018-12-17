---
title: 'Hibernate缓存'
date: 2013-05-25 09:40:06
categories: 
- Service及JavaEE
- Cache
tags: 
- hibernate
- 缓存
- 一级缓存
- 二级缓存
- 查询缓存
---
## Hibernate缓存

Hibernate带有三种不同缓存机制：一级缓存、二级缓存和查询缓存。

### SessionFactory和Session
SessionFactory(在JEE中叫做EntityManager)的用途是创建会话，初始化JDBC链接并（使用例如C3P0之类的可插拔provider）进行池化。SessionFactory是非可变的，通过hibernate.cfg.cml文件或Springbean配置中提供的匹配信息、缓存信息等配置进行创建。会话是最低级的工作单元，对应一个数据库事物。当会话创建后并对Hibernate实体机型一些操作，比如设置实体的一个属性，Hibernate不会立即更新底层数据库表。相反Hibernate记录实体的状态（是否为脏数据），并在会话最终刷新更新到数据库。这就是Hibernate所谓的一级缓存。

### 一级缓存

一级缓存是Hibernate记录正在进行的会话加载和接触的实体有可能的脏数据状态。正在进行的会话代表工作单元，始终使用，无法关闭。一级缓存的用途是隐藏对数据库许多SQL查询或更新，并在会话最终批量一起执行。当想起一级缓存的时候就应该想到会话。

### 二级缓存

二级缓存是进程范围内的缓存，与一个SessionFactory绑定。二级缓存可被相同（通常一个应用程序仅一个）SessionFactory的所有会话共享。默认二级缓存没有使能。二级缓存不存储任何实体实例，而是存储“脱水”状态，即字符串或整形数组代表实体的属性，一个实体id指向“脱水”的实体。概念上可以认为它是一个映射，id作为键，数组作为值。或像下面用于缓存region的这些东西：
```
public class Person {
  private Person parent;
  private Set<Person> children;
  
  public void setParent(Person p) { parent = p; }
  public void setChildren(Set<Person> set) { children = set; }
  public Set<Person> getChildren() { return children; }
  public Person getParent() { return parent; }
}
```

Hibernate映射配置如下:
```
<class name="org.javalobby.tnt.hibernate.Person">
  <cache usage="read-write"/>
  <id name="id" column="id" type="long">
     <generator class="identity"/>
  </id>
  <property name="firstName" type="string"/>
  <property name="middleInitial" type="string"/>
  <property name="lastName" type="string"/>
  <many-to-one name="parent" column="parent_id" class="Person"/>
  <set name="children">
    <key column="parent_id"/>
    <one-to-many class="Person"/>
  </set>
</class>
```

Hibernate概念上为此类持有如下记录:
```
*-----------------------------------------*
|            Person Data Cache            |
|-----------------------------------------|
| 1 -> [ "John" , "Q" , "Public" , null ] |
| 2 -> [ "Joey" , "D" , "Public" ,  1   ] |
| 3 -> [ "Sara" , "N" , "Public" ,  1   ] |
*-----------------------------------------*
```
因此，本例中Hibernate保留三个字符串和一个用于“多对一”父子关系的可序列化标识符，而不是保留真正的对象实例。这非常重要：一、Hibernate不用担心客户代码操作对象会破坏缓存；二、关联关系和关联由于是简单标识符不会变得‘陈旧’，并易于更新到最新状态。缓存不是对象树，而是概念上的数组映射。概念一词被连续使用，是因为Hibernate为Cache做了更多的幕后工作，用户如果不想实现自己的provider则无需担心其内部实现。Hibernate将对象的状态称之为“脱水的”，因为它含有对象所有重要的信息，但是对Hibernate更为可控。
你有可能注意到子关联在缓存中被省略掉了。Hibernate的控制颗粒度可以让你决定哪些关联应被加入缓存，从二级缓存恢复业务数据时哪些关联应重新判决。当关联有可能被其他类修改但不想对已缓存的类做显式级联修改时，提供了更多控制选项。
默认设置是不缓存关联。如果你对此不了解并对Hibernate缓存如果工作一无所知，仅仅简单打开缓存，有可能仅仅增加了管理缓存的负担而没有获得相应的好处。毕竟，缓存的最大优点是无需通过N+1数据库查询而获得复杂关联。
在此例中，我们仅处理person类，并知道关联能被适当地管理，因此更新映射以让子关联可以被缓存。
```
  <set name="children"> 
  <cache usage="read-write"/>
  <key column="parent_id"/>
  <one-to-many class="Person"/>
```

下面是person数据缓存的更新版本:
```
*-----------------------------------------------------*
|                     Person Data Cache               |
|-----------------------------------------------------|
| 1 -> [ "John" , "Q" , "Public" , null , [ 2 , 3 ] ] |
| 2 -> [ "Joey" , "D" , "Public" ,  1   , []        ] |
| 3 -> [ "Sara" , "N" , "Public" ,  1   , []        ] |
*-----------------------------------------------------*
```
需要再次指出的是仅仅缓存相关部分的ID。

当我们从不使用缓存数据库加载ID为‘1’，将执行下列查询:
```
select * from Person where id=1 ; 加载id为1的person
select * from Person where parent_id=1 ; 加载id为1的person的孩子(将返回2, 3)
select * from Person where parent_id=2 ; 加载id为2的person的孩子(将返回none)
select * from Person where parent_id=3 ; 加载id为3的person的孩子(将返回none)
```

当使用缓存（假设已完成全部加载）时，直接加载将**不再**对数据库进行查询，因为它能通过标识从缓存中查找。但假如我们没有对关联进行缓存，需要对数据库进行如下查询:
```
select * from Person where parent_id=1 ; 加载id为1的person的孩子(将返回2, 3) 
select * from Person where parent_id=2 ; 加载id为2的person的孩子(将返回none) 
select * from Person where parent_id=3 ; 加载id为3的person的孩子(将返回none)
```

SQL查询的数量同没有使用缓存近似一样。这就是尽可能缓存关联为什么很重要的原因。
如果我们使用更复杂的不是基于ID进行查询，例如姓名，Hibernate在这种情况下仍会对数据库进行一次查询。示例代码如下：
```
Query query = session.createQuery("from Person as p wherep.firstName=?");
query.setString(0, "John");
List l = query.list();
```
这会对数据库进行如下查询(即使所有关联已被缓存).
```
select * from Person where firstName='John'
```
查询结果为‘1’，然后缓存可以用来查询其他孩子信息。查询缓存可用于对上述的查询进行缓存。

### 查询缓存

Hibernate查询缓存默认没有使能。它使用两个叫做org.hibernate.cache.StandardQueryCache和org.hibernate.cache.UpdateTimestampsCache的缓存region。第一个将带有参数的查询作为键进行存储，第二个记录查询结果。如果缓存查询的实体部分被更新，查询缓冲逐出查询及查询结果。因此查询缓冲必须设置逐出则略。一个对ID的简单加载不会使用查询缓存，但是下面的这样查询就会使用查询缓存：
```
Query query = session.createQuery("from Person as p where p.parent.id=? and p.firstName=?");
query.setInt(0, Integer.valueOf(1));
query.setString(1, <font color="red">"Joey");
query.setCacheable(**true**);
List l = query.list();
```

查询缓存:
```
*----------------------------------------------------------------------------------------*
|                                           Query Cache                                  |
|----------------------------------------------------------------------------------------|
| ["from Person as p where p.parent.id=? and p.firstName=?", [ 1 , "Joey"] ] -> [  2 ] ] |
*----------------------------------------------------------------------------------------*
```

键为查询和参数值组合，值为查询结果标识符列表。注意查询可能修改返回对象的关联时从内部看这将变得更为复杂更不要说查询可能不是对整个对象进行查询而是对对象部分标量属性的查询。也就是说，这仅仅是从概念上对查询缓存的一种看法。
如果二级缓存使能(用于查询缓存返回的对象),id为2的Person及其他关联“脱水”对象将从二级缓存获取并转换成实体对象。

## 二级缓存并发策略

二级缓存有四个可选的并发策略：
- 只读（Read-only）: 这种策略对于从来不修改、只需要频繁读取的数据是非常有用的，也是最简单、性能最好的缓存策略。但必须保证数据不会被修改或删除，否则就会出错。
- 非严格读写（Nonstrict read/write）:这种策略不保证不能保证缓存与数据库中数据的一致性。如果存在两个事务并发地访问缓存数据的可能，则应该为该数据配置一个很短的过期时间，以减少读脏数据的可能。因此，更适用于频繁读取数据、偶尔修改数据并容忍偶尔脏读的场合。
- 读写（Read/write）:如果数据需要被更新，Read/write缓存策略可能是比较合适的。这种策略比read-only消耗更多的资源。在非JTA环境中，每个事务必须在Session.close()或Session.disconnect()调用之前结束。Hibenate在此模式下作为轻量级XA协调器自己管理事务。所有数据库操作必须在一个事务中，无法使用自动提交模式。在flush时，Hibernate搜索会话并搜索所有更新的/插入的/删除的对象并刷新至数据库，之后锁定并更新缓存。此时其他事物无法读写缓存。如果事物回滚，仅释放锁并将这些对象逐出缓存，之后其他事物可以读写缓存。如果事物提交，仅释放锁，之后其他事物可以读写缓存。读写策略提供了“readcommitted"数据库隔离级别。对于经常被读但很少修改的数据可以采用这种策略，它可以防止读脏数据。
- 事物（Transactional）:这是一个完全事务支持的策略，可以在JTA环境中使用。它提供了RepeatableRead事务隔离级别。它可以防止脏读和不可重复读这类的并发问题。

## 注意事项

- Hibernate内部始终透明地使用一级缓存。当查询缓存关闭时，HQL查询会对数据库执行SQL查询而不是从一级缓存加载。Hibernate需要键用来从一级缓存加载对象。应此，如果已经获得键的情况下，使用load或者get比HQL查询更适合。此外Iterator方法读写一级缓存，List方法只写不读一级缓存。
- 一级缓存不能禁用，但可以通过Session的clear方法和evict方法清理一级缓存，从而达到禁止写缓存的效果
- Get，Load，Iterator方法读写二级缓存，List方法只写不读二级缓存。在一次会话中可以通过设置会话的CacheMode为Put来禁用读操作，设置CacheMode为Get来禁用写操作。也可以通过SessionFacotry的evict方法清理二级缓存来达到禁止写二级缓存的效果。
- 当会话的创建时戳(txTimestamp)比二级缓存中缓存对象的更新时戳大时，它会从二级缓存加载；否则，对数据库执行SQL查询。
- 查询缓存会缓存Hibernate查询结果的键。这些键之后用于Hibernate从一级缓存或二级缓存加载对象。List方法读写查询缓存，Iterator不读查询缓存。

## 附注

### 1. Hibernate二级缓存文档

http://docs.jboss.org/hibernate/orm/3.2/reference/en/html/performance.html#performance-cache  
http://docs.jboss.org/hibernate/orm/3.6/reference/en-US/html/performance.html  
http://docs.jboss.org/hibernate/orm/4.2/manual/en-US/html/ch20.html#performance-cache  

### 2. Hibernate缓存介绍
http://acupof.blogspot.com/2008/01/background-hibernate-comes-with-three.htmlhttp://apmblog.compuware.com/2009/02/16/understanding-caching-in-hibernate-part-one-the-session-cache/ 
http://apmblog.compuware.com/2009/02/16/understanding-caching-in-hibernate-part-two-the-query-cache/ 
http://apmblog.compuware.com/2009/03/24/understanding-caching-in-hibernate-part-three-the-second-level-cache/http://www.javalobby.org/java/forums/t48846.htmlhttp://www.javacodegeeks.com/2012/02/hibernate-cache-levels-tutorial.htmlhttp://consultingblogs.emc.com/manjunathasubbarya/archive/2011/10/30/cache-using-hibernate.aspx
http://itindex.net/detail/40549-hibernate-缓存-缓存
http://blog.csdn.net/woshichenxu/article/details/586361

### 3. Hibernate二级缓存并发策略
http://stackoverflow.com/questions/8662609/hibernate-l2-cache-read-write-or-transactional-cache-concurrency-strategy-on-cl  
http://stackoverflow.com/questions/8186890/nonstrict-read-write-vs-read-write-in-hibernate  
http://wangbt5191-hotmail-com.iteye.com/blog/1711129  

### 4. Hibernate缓存限制
http://squirrel.pl/blog/2011/08/24/hibernate-cache-is-fundametanlly-broken/https://hibernate.atlassian.net/browse/HHH-6600  