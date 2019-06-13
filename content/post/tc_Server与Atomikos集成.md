---
title: 'tc Server与Atomikos集成'
date: 2013-10-13 17:15:41
categories: 
- Service+JavaEE
tags: 
- tcserver
- atomikos
- tomcat
- database
- jms
---
tc Server是基于Apache的Tomcat的，Atomikos有篇文档介绍[Tomcat与Atomikos集成](http://www.atomikos.com/Documentation/Tomcat7Integration35)，同样适用于tcServer。

## Atomikos安装配置

### 复制JAR文件

复制下列JAR文件到TCS_HOME/lib目录：
- atomikos-util.jar
- transactions.jar
- transactions-api.jar
- transactions-jdbc.jar
- transactions-jdbc-deprecated.jar
- transactions-jms.jar
- transactions-jms-deprecated.jar
- transactions-jta.jar
- transactions-osgi.jar
- geronimo-jms_1.1_spec.jar
- geronimo-jta_1.0.1B_spec.jar
- JDBC驱动
- 如果使用Hibernate：transactions-hibernate3.jar和/或transactions-hibernate2.jar

### 复制Atomikos配置文件

将[jta.properties](http://www.atomikos.com/pub/Documentation/Tomcat7Integration35/jta.properties)复制到TCS_HOME/lib目录并做适当修改。
```
com.atomikos.icatch.service=com.atomikos.icatch.standalone.UserTransactionServiceFactory
com.atomikos.icatch.console_file_limit=10240000
com.atomikos.icatch.output_dir=${catalina.base}/logs
com.atomikos.icatch.log_base_dir=${catalina.base}/logs
com.atomikos.icatch.max_actives=-1
com.atomikos.icatch.default_jta_timeout=3600000
com.atomikos.icatch.max_timeout=3600000
com.atomikos.icatch.tm_unique_name=tm
com.atomikos.icatch.console_log_level=WARN
com.atomikos.icatch.force_shutdown_on_vm_exit=false
```

### 复制类文件

创建AtomikosLifecycleListener和BeanFactory两个类并放置在TCS_HOME/lib目录：
创建用于Atomikos的tc Server生命期监视器：当tcServer实例启动时，创建UserTransactionManager并初始化；当tcServer关闭时，关闭UserTransactionManager。
```
package com.atomikos.tomcat;

import org.apache.catalina.Lifecycle;
import org.apache.catalina.LifecycleEvent;
import org.apache.catalina.LifecycleListener;

import com.atomikos.icatch.jta.UserTransactionManager;

public class AtomikosLifecycleListener implements LifecycleListener
{

  private UserTransactionManager utm;

  public void lifecycleEvent(LifecycleEvent event) {
    try {
      if (Lifecycle.START_EVENT.equals(event.getType())) {
        if (utm == null) {
          utm = new UserTransactionManager();
        }
        utm.init();
      } else if (Lifecycle.AFTER_STOP_EVENT.equals(event.getType())) {
        if (utm != null) {
          utm.close();
        }
      }
    } catch (Exception e) {}
  }
}
```

创建用于Atomikos的tc Server JNDIbean工厂类：为数据库数据源创建AtomikosDataSourceBean，为JMS数据源创建AtomikosConnectionFactoryBean
```
package com.atomikos.tomcat;

import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.Name;
import javax.naming.NamingException;
import javax.naming.RefAddr;
import javax.naming.Reference;
import javax.naming.spi.ObjectFactory;

import com.atomikos.beans.PropertyUtils;

public class BeanFactory implements ObjectFactory
{
  public Object getObjectInstance(Object obj, Name name, 
    Context nameCtx, Hashtable environment) throws NamingException
  {
    if ((obj == null) || !(obj instanceof Reference)) {
      return null;
    }

    Reference ref = (Reference)obj;
    String beanClassName = ref.getClassName();
    
    try {
      Class<?> beanClass = Class.forName(beanClassName);
      System.out.println("Creating instance of " + beanClassName);      

      Object bean = beanClass.newInstance();
      
      Enumeration<RefAddr> properties = ref.getAll();
      while (properties.hasMoreElements()) 
      {
        RefAddr refAddr = properties.nextElement();
        String propertyName = refAddr.getType();

        if ((!propertyName.equals("factory")) && 
          (!propertyName.equals("singleton")) && 
          (!propertyName.equals("description")) && 
          (!propertyName.equals("scope")) && 
          (!propertyName.equals("auth")))
        {
          String propertyValue = (String)refAddr.getContent();
          System.out.println("Setting " + propertyName + "=" + propertyValue);          

          PropertyUtils.setProperty(bean, propertyName, propertyValue);
        }
      }

      System.out.println("Initializing " + bean);

      // initialize the bean
      Method method = beanClass.getMethod("init", (Class<?>[])null);
      method.invoke(bean, (Object[]) null);

      return bean;
    }
    catch (Exception e) {
      System.out.println(e.getClass().getName() + ": " + e.getMessage());
      throw (NamingException)(new NamingException("Error creating instance of: " + beanClassName).initCause(e));
    }
  }       
}
```
