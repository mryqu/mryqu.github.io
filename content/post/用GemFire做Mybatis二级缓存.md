---
title: '用GemFire做Mybatis二级缓存'
date: 2013-05-22 09:12:27
categories: 
- Service+JavaEE
- Cache
- GemFire
tags: 
- gemfire
- mybatis
- 二级缓存
---
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