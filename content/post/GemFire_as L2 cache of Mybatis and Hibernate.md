---
title: '使用GemFire做Mybatis/Hibernate二级缓存'
date: 2013-05-22 09:12:27
categories: 
- Cache
tags: 
- gemfire
- mybatis
- hibernate
- cache
---

## 使用GemFire做Mybatis二级缓存  

MyBatis支持第三方二级缓存实现，目前支持Ehcache、Hazelcast和OSCache。
GemFire不在支持的范围，但是可以通过实现org.apache.ibatis.cache.Cache接口来使用。

### MyBatis的Cache配置及实现
1. 设置MyBatis的Cache全局使用开关：默认是true，如果它配成false，其余各个MapperXML文件配成支持cache也没用。
    ```
    <settings>                                 
    <setting name="cacheEnabled" value="true"/>
    </settings>
    ```
2. 各个Mapper XML文件，默认是不采用cache。在配置文件加一行就可以支持cache：
    ```
     <cache /> 
    ```
3. 实现GemfireCache
    ```
    package com.yqu.mybatis.caches.gemfire;
    
    import com.gemstone.gemfire.cache.AttributesFactory;
    import com.gemstone.gemfire.cache.CacheFactory;
    import com.gemstone.gemfire.cache.Region;
    
    import java.util.concurrent.locks.ReadWriteLock;
    import java.util.concurrent.locks.ReentrantReadWriteLock;
    
    import org.apache.ibatis.cache.Cache;
    import org.apache.ibatis.cache.CacheException;
    
    public final class GemfireCache implements Cache {
    
      private static Region<object> mybatis_region = null; 
      private Region<object> region = null;   
      private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock(); 
      private String id; 
       
      public void setId(String id) { 
        this.id = id; 
      } 
       
      public void setRegion(Region<object> region) { 
        this.region = region; 
      } 
       
      public Region<object> getRegion() { 
        return region; 
      } 
       
      private static synchronized Region<object> getParentRegion() 
      { 
        if(mybatis_region==null) 
        { 
          com.gemstone.gemfire.cache.Cache cache = new CacheFactory() 
            .set("name", "mybatis_gemfire_cache") 
            .set("cache-xml-file", "gemfire.xml").create(); 
          mybatis_region = cache.getRegion("mybatis_gemfire_region"); 
        } 
        return mybatis_region; 
      } 
       
      @SuppressWarnings({ "deprecation", "unchecked", "rawtypes" }) 
      public GemfireCache(String id) { 
        if (id == null) { 
          throw new IllegalArgumentException("Cache instances require an ID"); 
        } 
        this.id = id; 
             
        region = getParentRegion().getSubregion(id); 
        if (null == region) { 
          AttributesFactory attrFactory = 
              new AttributesFactory(mybatis_region.getAttributes()); 
           
          region = mybatis_region.createSubregion(id, attrFactory.create()); 
        } 
      } 
       
      public void clear() { 
        if (null != region) { 
          try { 
            region.clear(); 
          } catch (Throwable t) { 
            throw new CacheException(t); 
          }   
        } 
      } 
       
      public String getId() { 
        return this.id; 
      } 
       
      public Object getObject(Object key) { 
        Object retVal = null; 
        if (null != region) { 
          if (region.containsKey(key.hashCode())) { 
            try { 
              retVal = region.get(key.hashCode()); 
            } catch (Throwable t) { 
              throw new CacheException(t); 
            }   
          } 
        } 
        return retVal; 
      } 
       
      public ReadWriteLock getReadWriteLock() { 
        return this.readWriteLock; 
      } 
       
      public int getSize() { 
        if (null != region) { 
          try { 
            return region.size(); 
          } catch (Throwable t) { 
            throw new CacheException(t); 
          } 
        } 
        return 0; 
      } 
       
      public void putObject(Object key, Object value) { 
        if (null != region) { 
          try { 
            region.put(key.hashCode(), value); 
          } catch (Throwable t) { 
            throw new CacheException(t); 
          } 
        } 
      } 
       
      public Object removeObject(Object key) { 
        if (null != region) { 
          try { 
            return region.remove(key.hashCode()); 
          } catch (Throwable t) { 
            throw new CacheException(t); 
          } 
        } 
        return null; 
      } 
       
      @Override 
      public boolean equals(Object obj) { 
        if (this == obj) { 
          return true; 
        } 
        if (obj == null) { 
          return false; 
        } 
        if (!(obj instanceof Cache)) { 
          return false; 
        } 
         
        Cache otherCache = (Cache)obj; 
        return this.id.equals(otherCache.getId()); 
      } 
       
      @Override 
      public int hashCode() { 
        return this.id.hashCode(); 
      } 
       
      @Override 
      public String toString() { 
        return "GemfireCache{" + this.id + "}"; 
      } 
    }
    ```

4. Mapper XML文件配置支持cache后，文件中所有的Mapperstatement就支持了。此时要个别对待某条可以通过useCache禁止使用cache：
    ```
    <select id="inetAton" parameterType="string" resultType="integer" useCache="false">    
    select inet_aton(#{name})
    </select>
    ```

### 参考
[iBatis OSCache example tutorial](http://howtodoinjava.com/2013/01/06/how-to-enable-caching-in-ibatis-using-oscache/)  
http://www.webdbtips.com/60455/  
[MyBatis的Cache实际意义不大](http://blog.csdn.net/xuezhimeng/article/details/7378096)  
[EhcacheCache.java](http://grepcode.com/file/repo1.maven.org/maven2/org.mybatis.caches/mybatis-ehcache/1.0.0-RC1/org/mybatis/caches/ehcache/EhcacheCache.java)  

## 使用GemFire做Hibernate二级缓存  

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