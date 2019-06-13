---
title: 'Hello UnRAVL'
date: 2016-08-18 05:47:19
categories: 
- Service+JavaEE
tags: 
- unravl
- rest
- validation
- sas
- opensource
---
### UnRAVL介绍


UnRAVL（Uniform REST API ValidationLanguage）是用于验证REST应用编程接口的JSON领域特定语言。UnRAVL由SAS架构师DavidBiesack实现，并作为SAS开源软件在GitHub上发布。![Hello UnRAVL](/images/2016/8/0026uWfMzy74h7tN1W4bc.png)

UnRAVL脚本包含一个REST API调用的JSON描述:
- HTTP方法（**GET、POST、PUT、DELETE、HEAD、PATCH**）
- URI
- (可选的)HTTP头
- (可选的)请求消息体
- (可选的)认证

对于每个API调用，一个UnRAVL脚本可以包含用于验证结果的一或多个断言。某些断言可以表达为前置条件，即在进行API调用之前必须为真。下列内容可以断言：
- 结果消息体匹配期望的JSON、文本或其他数据
- 存在带有特定值的特定头
- HTTP状态码为特定值或在特定集合内
- 响应消息体匹配基准（benchmark）
- 通过Groovy表达式测试响应或环境变量中的元素为真
- 一个环境变量已赋值

UnRAVL也支持从RESTAPI调用结果中抽取数据、与环境变量进行数据绑定并用于之后的API调用验证。例如，将一个创建资源的`POST` 调用响应的`Location` 头进行保存，并将此URL用于后继`GET` 、`PUT` 、`DELETE` 调用。
模板功能提供了可重用的API验证构建能力。

### UnRAVL示例

#### build.gradle
```
buildscript {
  repositories {
    mavenCentral()    
  }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'

jar {
  baseName = 'HelloUnRAVL'
  version =  '0.1.0'
}

repositories {
  mavenCentral()
}

sourceCompatibility = 1.7
targetCompatibility = 1.7

ext {
  jacksonVersion = "2.5.+"
  groovyVersion = "2.4.3"
  springVersion = "4.2.2.RELEASE"
  httpClientVersion = "4.5"
  httpCoreVersion = "4.4.1"
  commonsCodecVersion = "1.10"
  log4jVersion = "1.2.17"
  guavaVersion = "18.0"
  jsonPathVersion = '2.+'
  jsonSchemaValidatorVersion = "2.2.6"
  jsonSchemaCoreVersion = "1.2.5"
  jacksonCoreUtilsVersion = "1.8"
  slf4jVersion = "1.7.16"
}

dependencies {  
  compile files('libs/sas.unravl-1.2.2-SNAPSHOT.jar')
  compile group: 'com.fasterxml.jackson.core', name: 'jackson-core', version: jacksonVersion
  compile group: 'com.fasterxml.jackson.core', name: 'jackson-annotations', version: jacksonVersion
  compile group: 'com.fasterxml.jackson.core', name: 'jackson-databind', version: jacksonVersion
  compile group: 'org.codehaus.groovy', name: 'groovy-all', version: groovyVersion
  compile group: 'org.springframework', name: 'spring-core', version: springVersion
  compile group: 'org.springframework', name: 'spring-web', version: springVersion
  compile group: 'org.apache.httpcomponents', name: 'httpclient', version: httpClientVersion
  compile group: 'org.apache.httpcomponents', name: 'httpcore', version: httpCoreVersion
  compile group: 'commons-codec', name: 'commons-codec', version: commonsCodecVersion
  compile group: 'log4j', name: 'log4j', version: log4jVersion
  compile group: 'com.google.guava', name: 'guava', version: guavaVersion
  compile group: 'com.github.fge', name: 'json-schema-validator', version: jsonSchemaValidatorVersion
  compile group: 'com.github.fge', name: 'json-schema-core', version: jsonSchemaCoreVersion
  compile group: 'com.github.fge', name: 'jackson-coreutils', version: jacksonCoreUtilsVersion
  compile group: 'com.jayway.jsonpath', name: 'json-path', version: jsonPathVersion
  compile group: 'org.slf4j', name: 'slf4j-log4j12', version: slf4jVersion
}
```

#### com/yqu/unravl/HelloUnRAVL.java
```
package com.yqu.unravl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sas.unravl.UnRAVLException;
import com.sas.unravl.UnRAVLRuntime;
import com.sas.unravl.util.Json;

public class HelloUnRAVL {

  public static List<JsonNode> parseUravlScript(String content)
      throws IOException, UnRAVLException {
    JsonNode root;
    List<JsonNode> roots = new ArrayList<JsonNode>();

    ObjectMapper mapper = new ObjectMapper();
    root = mapper.readTree(content);
    if (root.isArray()) {
      for (JsonNode next : Json.array(root)) {
        roots.add(next);
      }
    } else {
      roots.add(root);
    }

    return roots;
  }

  public static void testSinaShortURL(Map<String, Object> env) {
    UnRAVLRuntime runtime = new UnRAVLRuntime(env);
    String tcnTemplate = "{" +
        "  \"name" : \"SinaShortURL\"," +
        "  \"GET\" : \"http://t.cn/{sURL}\"," +
        "  \"assert\": [ { \"status\" : 200 } ]" +
        "}";

    try {
      List<JsonNode> unravlTemplate = parseUravlScript(tcnTemplate);
      runtime.execute(unravlTemplate);

      Map<String, Object> bindings = runtime.getBindings();
      int failedAssertionCount = (int) bindings.get("failedAssertionCount");
      System.out.println("failedAssertionCount:"+failedAssertionCount);
      
    } catch (IOException e) {
      e.printStackTrace();
    } catch (UnRAVLException e) {
      e.printStackTrace();
    }
  }

  public static void main(String[] args) {
    Map<String, Object> env = new HashMap<String, Object>();
    env.put("sURL", "RLoGZKa");
    testSinaShortURL(env);
  }
}
```

测试结果：![Hello UnRAVL](/images/2016/8/0026uWfMzy74h6ZW7KQf4.png)

### 参考

[GitHub: sassoftware/unravl](https://github.com/sassoftware/unravl)    
[UnRAVL脚本参考指南](https://github.com/sassoftware/unravl/blob/master/doc/Reference.md)    
[UnRAVL issues](https://github.com/sassoftware/unravl/issues)    