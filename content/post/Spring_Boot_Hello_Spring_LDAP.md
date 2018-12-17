---
title: '[Spring Boot] Hello Spring LDAP'
date: 2015-07-06 06:20:32
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- ldap
- odm
- boot
- apacheds
---
这个帖子设定了标题后，一直忙于其他事情，拖延了两个月终于能够结贴了。

### 部分示例代码

#### LdapConfiugration.java
```
package com.yqu.ldap.odm;

import com.yqu.ldap.odm.dao.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.LdapContextSource;

import javax.annotation.PostConstruct;

@Configuration
@ComponentScan(basePackages={"com.yqu.ldap.odm"})
public class LdapConfiugration {
  @Autowired
  private Environment _environment;

  private static Log log = LogFactory.getLog(LdapConfiugration.class);

  @PostConstruct
  private void init() {
    log.debug("environment: yqu.ldap.url:" + 
        _environment.getProperty("yqu.ldap.url"));
    log.debug("environment: yqu.ldap.userDN:" + 
        _environment.getProperty("yqu.ldap.userDN"));
    log.debug("environment: yqu.ldap.password:" + 
        _environment.getProperty("yqu.ldap.password"));
    log.debug("environment: yqu.ldap.base:" + 
        _environment.getProperty("yqu.ldap.base"));
  }

  @Bean(name="ldapContextSource")
  public LdapContextSource ldapContextSource() {
    String url = _environment.getProperty("yqu.ldap.url");
    String user = _environment.getProperty("yqu.ldap.userDN");
    String password = _environment.getProperty("yqu.ldap.password");
    String base = _environment.getProperty("yqu.ldap.base");
    if (url == null || user == null || password == null) {
      log.error("Missing properties for contextSource.");
    }
    LdapContextSource context = new LdapContextSource();
    context.setUrl(url);
    context.setUserDn(user);
    context.setPassword(password);
    context.setBase(base);
    return context;
  }

  @Bean(name="ldapTemplate")
  @DependsOn("ldapContextSource")
  public LdapTemplate ldapTemplate() {
    LdapTemplate ldapTemplate = new LdapTemplate();
    ldapTemplate.setContextSource(ldapContextSource());
    return ldapTemplate;
  }

  @Bean(name="personDao")
  @DependsOn("ldapTemplate")
  public PersonDao personDao()
  {
    OdmPersonDaoImpl personDao = new OdmPersonDaoImpl();
    personDao.setLdapTemplate(ldapTemplate());
    return personDao;
  }
}
```

#### LdapTestConfig.java

```
package com.yqu.ldap.odm;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.ClassPathResource;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.test.EmbeddedLdapServerFactoryBean;
import org.springframework.ldap.test.LdifPopulator;

@Profile("test")
@Configuration
@ComponentScan(basePackages={"com.yqu.ldap.odm"})
public class LdapTestConfig {

  @Bean
  @DependsOn("embeddedLdapServer")
  public LdifPopulator ldifPopulator(ContextSource contextSource) {
    LdifPopulator ldifPopulator = new LdifPopulator();
    ldifPopulator.setContextSource(contextSource);
    ldifPopulator.setResource(new ClassPathResource("setup_data.ldif"));
    ldifPopulator.setBase("dc=jayway,dc=se");
    ldifPopulator.setClean(true);
    ldifPopulator.setDefaultBase("dc=jayway,dc=se");
    return ldifPopulator;
  }

  @Bean(name = "embeddedLdapServer")
  public EmbeddedLdapServerFactoryBean embeddedLdapServerFactoryBean() {
    EmbeddedLdapServerFactoryBean embeddedLdapServerFactoryBean = 
        new EmbeddedLdapServerFactoryBean();
    embeddedLdapServerFactoryBean.setPartitionName("example");
    embeddedLdapServerFactoryBean.setPartitionSuffix("dc=jayway,dc=se");
    embeddedLdapServerFactoryBean.setPort(18880);
    return embeddedLdapServerFactoryBean;
  }
}
```

#### application.properties

```
server.context-path=/HelloSpringLdapOdm
server.port=8080

spring.profiles.active=test,dev

# spring.dao.exceptiontranslation.enabled=false
yqu.ldap.url=ldap://127.0.0.1:18880
yqu.ldap.userDN=uid=admin,ou=system
yqu.ldap.password=secret
yqu.ldap.base=dc=jayway,dc=se
yqu.ldap.clean=true

applicationDefaultJvmArgs: [
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=55558"
]
```

#### setup_data.ldif

```
dn: c=Sweden,dc=jayway,dc=se
objectclass: top
objectclass: country
c: Sweden
description: The country of Sweden

dn: ou=company1,c=Sweden,dc=jayway,dc=se
objectclass: top
objectclass: organizationalUnit
ou: company1
description: First company in Sweden

dn: cn=Some Person,ou=company1,c=Sweden,dc=jayway,dc=se
objectclass: top
objectclass: person
objectclass: organizationalPerson
objectclass: inetOrgPerson
uid: some.person
userPassword: password
cn: Some Person
sn: Person
description: Sweden, Company1, Some Person
telephoneNumber: +46 555-123456

dn: cn=Some Person2,ou=company1,c=Sweden,dc=jayway,dc=se
objectclass: top
objectclass: person
objectclass: organizationalPerson
objectclass: inetOrgPerson
uid: some.person2
userPassword: password
cn: Some Person2
sn: Person2
description: Sweden, Company1, Some Person2
telephoneNumber: +46 555-654321
```

#### build.gradle

```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.6.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
    baseName = 'hello-springldapodm'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-actuator")
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("org.springframework:spring-tx")
    compile("org.springframework.ldap:spring-ldap-core:2.0.3.RELEASE")
    compile("org.springframework.ldap:spring-ldap-test:2.0.3.RELEASE")
    compile("org.springframework.data:spring-data-commons")
    compile("com.fasterxml.jackson.core:jackson-databind:2.6.0")
    compile("org.springframework.hateoas:spring-hateoas")
    compile("org.springframework.plugin:spring-plugin-core:1.1.0.RELEASE")
    compile("com.jayway.jsonpath:json-path:0.9.1")
    compile("org.apache.commons:commons-lang3:3.4")   
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 测试

#### 列举所有用户

![List users](/images/2015/7/0026uWfMgy6WFpERRwAb0.jpg)

#### 查询某一用户

![Query specified user](/images/2015/7/0026uWfMgy6WFqqokFr39.jpg)

#### 添加新用户

![Add user](/images/2015/7/0026uWfMgy6WFqat2Q75f.jpg)

#### 更新某一用户

![Update user](/images/2015/7/0026uWfMgy6WFqbiuDP3d.jpg)

#### 再次列举所有用户

![List users](/images/2015/7/0026uWfMgy6WFqfKEWx4d.jpg)

### 参考

[Spring LDAP Reference](http://docs.spring.io/spring-ldap/docs/current/reference/)  
[GitHub：spring-projects/spring-ldap](https://github.com/spring-projects/spring-ldap/)  
[spring-ldap samples](https://github.com/spring-projects/spring-ldap/tree/master/samples)  
[Spring Guide：Authenticating a User with LDAP](http://spring.io/guides/gs/authenticating-ldap/)  
[LDAP Parameters](http://www.iana.org/assignments/ldap-parameters/ldap-parameters.xhtml)  
[ApacheDS](https://directory.apache.org/apacheds/)  