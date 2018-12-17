---
title: 'Java解析YAML'
date: 2015-07-01 05:37:02
categories: 
- Java
tags: 
- yaml
- java
- snakeyaml
- yamlbeans
- jackson
---
继前博文[YAML](/post/yaml)介绍了YAML语法，本文将着重研究Java解析YAML。当前还在维护的YAML解析器/生成器有：
- [SnakeYAML](https://bitbucket.org/asomov/snakeyaml)
  - 完整的YAML 1.1解析器，尤其是SnakeYAML能够分析来自于规范的所有示例
  - 支持Unicode，包括UTF-8/UTF-16的输入/输出
  - 为序列化和反序列化本地的Java对象提供了高级API
  - 支持YAML类型库中的所有类型
  - 比较理性的错误信息
- [YamlBeans](https://github.com/EsotericSoftware/yamlbeans)：支持YAML 1.0和1.1
- [FasterXML/jackson-dataformat-yaml](FasterXML/jackson-dataformat-yaml)：处于原型阶段

SnakeYAML和YamlBeans都在GoogleCode仓库时，SnakeYAML的使用人数和提交者均优于YamlBeans。目前大多数帖子还是推荐选用SnakeYAML，而SpringBoot读取YAML配置采用的就是SnakeYAML。为了测试SnakeYAML，我首先创建了一个HelloSnakeYAML项目。

#### conf.yaml

```
spring:
    application:
        name: cruncher
    datasource:
        driverClassName: com.mysql.jdbc.Driver
        url: jdbc:mysql://localhost/test
server:
    port: 9000

```

#### Contact.java

```
package com.yqu.yaml;

import java.util.List;

public class Contact {
    private String name;
    private int age;
    private List phoneNumbers;

    public Contact(String name, int age, List phoneNumbers) {
        this.name = name;
        this.age = age;
        this.phoneNumbers = phoneNumbers;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public List getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(List phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
    }
}
```

#### Phone.java

```
package com.yqu.yaml;

public class Phone {
    private String name;
    private String number;

    public Phone(String name, String number) {
        this.name = name;
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
```

#### HelloSnakeYAML.java

```
package com.yqu.yaml;

import org.yaml.snakeyaml.Yaml;

import java.io.FileInputStream;
import java.io.FileWriter;
import java.net.URL;
import java.util.Arrays;
import java.util.List;

public class HelloSnakeYAML {
    public static void test1() {
        try {
            Yaml yaml = new Yaml();
            URL url = HelloSnakeYAML.class.getClassLoader().getResource("conf.yaml");
            if (url != null) {
                Object obj = yaml.load(new FileInputStream(url.getFile()));
                System.out.println(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void test2() {
        try {
            Contact c1 = new Contact("test1", 1, Arrays.asList(
                    new Phone("home", "1111"),
                    new Phone("work", "2222")));
            Contact c2 = new Contact("test2", 23, Arrays.asList(
                    new Phone("home", "1234"),
                    new Phone("work", "4321")));
            List contacts = Arrays.asList(c1, c2);
            Yaml yaml = new Yaml();
            yaml.dump(contacts, new FileWriter("contact.yaml"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        test1();
        test2();
    }
}
```

#### build.gradle

```
buildscript {
    repositories {
        mavenCentral()
        maven { url "http://repo.spring.io/libs-milestone" }
    }

}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'

jar {
    baseName = 'HelloSnakeYAML'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
    maven { url "http://repo.spring.io/libs-milestone" }
}

sourceCompatibility = 1.7
targetCompatibility = 1.7

dependencies {  
    compile("org.yaml:snakeyaml:1.15")    
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

#### test1结果

```
{spring={application={name=cruncher}, datasource={driverClassName=com.mysql.jdbc.Driver, url=jdbc:mysql://localhost/test}}, server={port=9000}}
```

#### test2结果

```
- !!com.yqu.yaml.Contact
  age: 1
  name: test1
  phoneNumbers:
  - {name: home, number: '1111'}
  - {name: work, number: '2222'}
- !!com.yqu.yaml.Contact
  age: 23
  name: test2
  phoneNumbers:
  - {name: home, number: '1234'}
  - {name: work, number: '4321'}
```