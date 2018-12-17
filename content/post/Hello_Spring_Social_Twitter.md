---
title: 'Hello Spring Social Twitter'
date: 2015-11-01 06:03:04
categories: 
- DataBuilder
tags: 
- spring
- social
- twitter
- crawler
- datascience
---
学习了[Spring Accessing Twitter Data Guide](http://spring.io/guides/gs/accessing-twitter/)，稍作修改，练习一下用Spring Social Twitter搜索推文。

### HelloSpringTwitter代码

#### src/main/java/com/yqu/springtwitter/Application.java
```
package com.yqu.springtwitter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

} 
```

#### src/main/java/com/yqu/springtwitter/HelloController.java
```
package com.yqu.springtwitter;

import javax.inject.Inject;

import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/")
public class HelloController {

  private Twitter twitter;

  private ConnectionRepository connectionRepository;

  @Inject
  public HelloController(Twitter twitter, 
      ConnectionRepository connectionRepository) {
    this.twitter = twitter;
    this.connectionRepository = connectionRepository;
  }

  @RequestMapping(method=RequestMethod.GET)
  public String helloTwitter(Model model, 
      @RequestParam(
          value = "searchTerm", 
          defaultValue = "mryqu", 
          required = false) String searchTerm,
      @RequestParam(
          value = "limit", 
          defaultValue = "20", 
          required = false) int limit) {
    if (connectionRepository.findPrimaryConnection(
        Twitter.class) == null) {
      return "redirect:/connect/twitter";
    }

    //OAuth1Connection conn = (OAuth1Connection) 
    //    connectionRepository.findPrimaryConnection(Twitter.class);
    //System.out.println(conn);

    model.addAttribute(twitter.userOperations().getUserProfile());
    SearchResults res = twitter.searchOperations().search(searchTerm, limit);
    model.addAttribute("tweets", res.getTweets());
    return "hello";
  }
}
```

#### src/main/resources/templates/connect/twitterConnect.html
![twitterConnect.html](/images/2015/11/0026uWfMgy6XfJASEnP95.jpg)

#### src/main/resources/templates/connect/twitterConnected.html
![twitterConnected.html](/images/2015/11/0026uWfMgy6XfJDaz598b.png)

#### src/main/resources/templates/hello.html
![hello.html](/images/2015/11/0026uWfMgy6XfJETpsXcf.png)

#### src/main/resources/application.properties
```
spring.social.twitter.appId={{put app ID here}}
spring.social.twitter.appSecret={{put app secret here}}
```

#### build.gradle
```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.7.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
    baseName = 'hello-spring-twitter'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-thymeleaf")
    compile("org.springframework.social:spring-social-twitter")
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 测试

![Hello Spring Social Twitter](/images/2015/11/0026uWfMgy6XfIQgc3973.jpg)![Hello Spring Social Twitter](/images/2015/11/0026uWfMgy6XfJ1cQzAbe.jpg)

### 参考

[Spring Social Twitter Project](http://projects.spring.io/spring-social-twitter/)  
[Spring Social Twitter Reference](http://docs.spring.io/spring-social-twitter/docs/current/reference/htmlsingle/)  
[Spring Social Project](http://projects.spring.io/spring-social/)  
[Spring Guide: Registering an Application with Twitter](http://spring.io/guides/gs/register-twitter-app/)  
[Spring Guide: Accessing Twitter Data](http://spring.io/guides/gs/accessing-twitter/)  
[Spring Guide: Creating a stream of live twitter data using Spring XD](http://spring.io/guides/gs/spring-xd/)  