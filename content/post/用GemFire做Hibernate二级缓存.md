---
title: '用GemFire做Hibernate二级缓存'
date: 2013-06-16 11:13:02
categories: 
- Service及JavaEE
- Cache
- GemFire
tags: 
- hibernate
- gemfire
- 缓存
---

### 打开二级缓存
```
<property name="hibernate.cache.use_second_level_cache">true</property> 
```

### 为查询缓存设置Cache Factory
```
<property name="hibernate.cache.region.factory_class">
  com.gemstone.gemfire.modules.hibernate.GemFireRegionFactory
</property> 
```

### 共享缓存模式
```
ENABLE_SELECTIVE|DISABLE_SELECTIVE|ALL|NONE 
```

ENABLE_SELECTIVE (默认值及推荐值): 仅标注为可缓存的实体会被缓存。
DISABLE_SELECTIVE: 仅标注为不可缓存的实体才不会被缓存。
ALL: 即使实体标为不可缓存也会被缓存。
NONE: 即使实体标为可缓存也不会被缓存。该选项意味着完全禁止二级缓存。

### GemFire相关配置

设置GemFire缓存属性
```
<property name="gemfire.PROPERTY_NAME">PROPERTY_VALUE</property>
```

设置GemFire缓存默认region类型
```
<property name="gemfire.default-region-attributes-id">
  REGION_ATTRIBUTE
</property> 
```
REGION_ATTRIBUTE是预定义region类型快捷定义中的任一个。默认为REPLICATE_HEAP_LRU。其他有效region快捷定义包括:REPLICATE、 REPLICATE_PERSISTENT、 PARTITION、 PARTITION_PERSISTENT、PARTITION_REDUNDANT、 PARTITION_REDUNDANT_PERSISTENT。

设置特定GemFire缓存region属性
```
<property name="gemfire.region-attributes-for: com.foo.Bar">
  REGION_ATTRIBUTE
</property> 
```

### 缓存映射

```
@Cache
(
 CacheConcurrencyStrategy usage(); 
 String region() default ""; 
 String include() default "all"; 
)
```

usage: 缓存并发策略(NONE, READ_ONLY, NONSTRICT_READ_WRITE, READ_WRITE,TRANSACTIONAL) 
region (可选项，默认为实体类的全类名或集合的全类名加属性名):缓存region名 
include (选项项，默认为all): all则缓存所有实体属性，non-lazy仅缓存非懒惰加载的实体属性。

#### 对缓存实体使用注释

```
@Entity 
@Cacheable 
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE) 
public class Forest { ... }
```

#### 对缓存集合使用注释

```
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER) 
@JoinColumn(name="CUST_ID") 
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE) 
public SortedSet getTickets() {
  return tickets;
}
```

GemFire支持READ_ONLY、NONSTRICT_READ_WRITE、READ_WRITE和TRANSACTIONAL缓存并发策略。

### 缓存模式

CacheMode 参数用于控制具体的 Session 如何与二级缓存进行交互:
- CacheMode.NORMAL(默认值)：从二级缓存中读写数据。
- CacheMode.GET：从二级缓存中读取数据，但不会向二级缓存写数据。
- CacheMode.PUT：仅向二级缓存写数据，但不从二级缓存中读数据。
- CacheMode.REFRESH：仅向二级缓存写数据，但不从二级缓存中读数据。通过hibernate.cache.use_minimal_puts 的设置，强制二级缓存从数据库中读取数据，刷新缓存内容。

void Session.setCacheMode(CacheMode cacheMode): 设置会话的缓存模式
Query Query.setCacheMode(CacheMode cacheMode):为本次查询覆盖当前会话缓存模式
Criteria Criteria.setCacheMode(CacheMode cacheMode):为本次查询覆盖当前会话缓存模式