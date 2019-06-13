---
title: '发现Hibernate 3.2.6统计中一个bug'
date: 2013-06-18 17:13:28
categories: 
- Service+JavaEE
- Hibernate
tags: 
- hibernate
- Statistics
---
今天使用Hibernate的统计类，分析一下结果。结果发现了一个bug，不能获得查询缓存中的查询语句。
这个bug倒在3.6.8已经修改了，不过还是影响我的工作。
```
Statistics stat = sessionFactory.getStatistics();
logger.info("isStatisticsEnabled:"+stat.isStatisticsEnabled());
logger.info("stat="+stat.toString());       
logger.info("queries="+Arrays.toString(stat.getQueries()));
```

org.hibernate.stat.StatisticsImpl.java
```
public String[] getQueries() {
  return ArrayHelper.toStringArray( queryStatistics.keySet());
}
```

org.hibernate.util.ArrayHelper.java (Hibernate 3.2.6)
```
public static String[] toStringArray(Collection coll) {
  return (String[]) coll.toArray(EMPTY_STRING_ARRAY);
}
```

org.hibernate.util.ArrayHelper.java (Hibernate3.6.8)
```
public static String[] toStringArray(Collection coll) {
  return (String[]) coll.toArray( new String[coll.size()]);
}
```