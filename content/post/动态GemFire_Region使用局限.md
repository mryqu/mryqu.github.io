---
title: '动态GemFire Region使用局限'
date: 2013-07-05 21:23:00
categories: 
- Service+JavaEE
- Cache
- GemFire
tags: 
- gemfire
- 动态region
- 局限
---

### 介绍

当前项目原有设计使用了嵌套的Map作为缓存。我在使用GemFire产品时使用普通region替代外层map，使用动态region替代内层map。

对于"/outer_region/Dimension"region中的条目，键是维ID（例如5），值是动态region"/inter_region/Dimension/5".
"/outer_region/Dimension" region的容量是256个条目，动态region"/inter_region/Dimension/5"的容量是10个条目。
当维#5被删除，"/outer_region/Dimension"相应条目应该删除，而动态region"/inter/Dimension/5"应该被销毁。

测试发现，当GemFire节点通过API创建了动态region后，它会将动态region列表发送给其他节点，此后的GemFire节点在创建Cache会失败。通过异常日志可知动态region会在Cache创建过程中被创建，但后继GemFire节点无法找到父region (**在该节点创建Cache之前根本没机会创建****region!**),这是导致失败的原因。

如果对cache使用cache-xml-file， GemFire会先创建普通region之后创建动态region。这需要将一个cache下所有region定义都放到cache-xml-file里，上述问题可能会被避免。但是一个cache被多个项目共享，所有项目的region定义放在一起的话，配置耦合度很高，对于产品的灵活性和扩展性很不利。


### 日志

```
Caused by: com.gemstone.gemfire.cache.RegionDestroyedException: Error -- Could not find a region named: '/inter_region/Dimension'
  at com.gemstone.gemfire.cache.DynamicRegionFactory.createDynamicRegionImpl(DynamicRegionFactory.java)
  at com.gemstone.gemfire.cache.DynamicRegionFactory.createDefinedDynamicRegions(DynamicRegionFactory.java)
  at com.gemstone.gemfire.cache.DynamicRegionFactory._internalInit(DynamicRegionFactory.java)
  at com.gemstone.gemfire.internal.cache.DynamicRegionFactoryImpl.internalInit(DynamicRegionFactoryImpl.java)
  at com.gemstone.gemfire.internal.cache.GemFireCacheImpl.readyDynamicRegionFactory(GemFireCacheImpl.java)
  at com.gemstone.gemfire.internal.cache.GemFireCacheImpl.initializeDeclarativeCache(GemFireCacheImpl.java)
  at com.gemstone.gemfire.internal.cache.GemFireCacheImpl.init(GemFireCacheImpl.java)
  at com.gemstone.gemfire.internal.cache.GemFireCacheImpl.create(GemFireCacheImpl.java)
  at com.gemstone.gemfire.cache.CacheFactory.create(CacheFactory.java)   
  at com.gemstone.gemfire.cache.CacheFactory.create(CacheFactory.java)   
  at org.springframework.data.gemfire.CacheFactoryBean.createCache(CacheFactoryBean.java)   
  at org.springframework.data.gemfire.CacheFactoryBean.init(CacheFactoryBean.java)   
  at org.springframework.data.gemfire.CacheFactoryBean.getObject(CacheFactoryBean.java)   
  at org.springframework.data.gemfire.CacheFactoryBean.getObject(CacheFactoryBean.java)   
  at org.springframework.beans.factory.support.FactoryBeanRegistrySupport.doGetObjectFromFactoryBean(FactoryBeanRegistrySupport.java)   
  ... 34 more
```