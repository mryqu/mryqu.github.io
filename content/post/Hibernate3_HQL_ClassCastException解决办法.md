---
title: 'Hibernate3 HQL: ClassCastException解决办法'
date: 2013-06-11 18:06:03
categories: 
- Service+JavaEE
tags: 
- hibernate
- hql
- ClassCastException
- ResultTransformer
---
下面的示例代码跑在Hibernate 3.6.8，会抛出异常java.lang.ClassCastException:[Ljava.lang.Object 无法转换成实体对象。通过调试可知返回的仍然是标量字段对象数组，而不是实体对象。
```
public class DemoEntity {
  public static final String DEMO_ENTITY_ID = "demoEntityID";
  public static final String USER_ID = "userID";
  public static final String OFFICE_ID = "officeID";
  
  private Integer demoEntityID;
  private String  userID;
  private Integer officeID;
  private String  subjectTxt;
  
  public List findDemoEntitys(int startID, int limit,
      boolean includeStartIdInResults)
  {
    try
    {
    StringBuilder querySb = new StringBuilder();
      querySb.append("select demo.").append(DemoEntity.DEMO_ENTITY_ID);     
      querySb.append(", demo.").append(DemoEntity.USER_ID);
      querySb.append(", demo.").append(DemoEntity.OFFICE_ID);
      querySb.append(" from DemoEntity demo where demo.").append(DemoEntity.DEMO_ENTITY_ID);
      if (includeStartIdInResults) {
        querySb.append(" >= ").append(startID);
      } else {
        querySb.append(" > ").append(startID);
      }
      querySb.append(" order by demo.").append(DemoEntity.DEMO_ENTITY_ID).append(" asc");
      Query query = sessionFactory.getCurrentSession().createQuery(querySb.toString());
      query.setResultTransformer(Transformers.aliasToBean(DemoEntity.class));
      query.setMaxResults(limit);
      List results = query.setCacheable(true).list();
      return results;
    }
    catch (RuntimeException re)
    {
      throw re;
    }
  }
}
```

通过分析Hibernate3.6.8源码，可知ClassicQueryTranslatorFactory使用了org.hibernate.hql.classic.QueryTranslatorImpl（继承自BasicLoader），它没有将标量字段数组转换成实体对象。
```
protected List getResultList(List results, ResultTransformer resultTransformer) 
throws QueryException {
  if ( holderClass != null ) {
    for ( int i = 0; i < results.size(); i++ ) {
      Object[] row = ( Object[] ) results.get( i );
      try {
        results.set( i, holderConstructor.newInstance( row ) );
      }
      catch ( Exception e ) {
        throw new QueryException( "could not instantiate: " + holderClass, e );
      }
    }
  }
  return results;
}
```

通过分析Hibernate3.6.8源码，可知ASTQueryTranslatorFactory则使用org.hibernate.hql.ast.QueryTranslatorImpl，它使用的是QueryLoader，而QueryLoader会将标量字段数组转换成实体对象。
```
protected List getResultList(List results, ResultTransformer resultTransformer) 
throws QueryException {
  // meant to handle dynamic instantiation queries...
  HolderInstantiator holderInstantiator = buildHolderInstantiator( resultTransformer );
  if ( holderInstantiator.isRequired() ) {
    for ( int i = 0; i < results.size(); i++ ) {
      Object[] row = ( Object[] ) results.get( i );
      Object result = holderInstantiator.instantiate(row);
      results.set( i, result );
    }

    if ( !hasSelectNew() && resultTransformer != null ) {
      return resultTransformer.transformList(results);
    }
    else {
      return results;
    }
  }
  else {
    returnresults;
  }
}
```

**解决方案1**：修改querytranslator factory
将Hibernate配置文件中hibernate.query.factory_class由org.hibernate.hql.classic.ClassicQueryTranslatorFactory修改为org.hibernate.hql.ast.ASTQueryTranslatorFactory,这样就能工作正常。
ClassicQueryTranslatorFactory是手写的传统HQL语法解析器工厂类，ASTQueryTranslatorFactory是更新的、基于ANTLR语法解析器生成的HQL语法解释器工厂类。
```
<propertyname="hibernate.query.factory_class"value="org.hibernate.hql.ast.ASTQueryTranslatorFactory"/>
```

**解决方案2**：不使用setResultTransformer函数，自己对结果进行转换
```
Query query = sessionFactory.getCurrentSession().createQuery(querySb.toString());
//query.setResultTransformer(Transformers.aliasToBean(DemoEntity.class));
query.setMaxResults(limit);
List<Object[]> queryRes = query.setCacheable(true).list();

List<DemoEntity> results = new ArrayList<DemoEntity>();        
if(queryRes!=null && !queryRes.isEmpty())
{
  String[] alias = {DemoEntity.DEMO_ENTITY_ID, DemoEntity.USER_ID, DemoEntity.OFFICE_ID);
  ResultTransformer resTransformer = Transformers.aliasToBean(DemoEntity.class);
  for(int i=0;i<queryRes.size();i++)
  {
     Object[] objs = (Object[]) queryRes.get(i);
     if(objs!=null)
     {
         results.add((DemoEntity) resTransformer.transformTuple(objs, alias));
     }
  }
}
return results;
```