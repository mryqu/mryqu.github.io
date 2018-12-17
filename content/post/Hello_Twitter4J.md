---
title: 'Hello Twitter4J'
date: 2015-10-19 06:10:11
categories: 
- DataBuilder
tags: 
- twitter
- twitter4j
- api
- crawler
- socialmedia
---
Twitter4J是Twitter API的第三方Java库。本演示用它通过关键字搜索推文。

**获取Twitter应用证书**
![Hello Twitter4J](/images/2015/10/0026uWfMgy6WnOS8iYQa4.jpg)
**示例代码**
```
package com.yqu.twitter4j;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;

public class HelloTwitter4J { // I18NOK:CLS
  public static void main(String[] args) {
    try {
      // The factory instance is re-useable and thread safe.
      Twitter twitter = TwitterFactory.getSingleton();
      Query query = new Query("夏洛特烦恼");
      query.setLang("zh");
      query.setCount(10);
      QueryResult result = twitter.search(query);
      for (Status status : result.getTweets()) {
        System.out.println(status.getCreatedAt()+":"+status.getText());  
      }     
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}

```

**twitter.properties**
```
debug=true
oauth.consumerKey=*********************
oauth.consumerSecret=******************************************
oauth.accessToken=**************************************************
oauth.accessTokenSecret=******************************************

```

**build.gradle**
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
    baseName = 'hello-twitter4j'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile 'org.twitter4j:twitter4j-core:4.0+'
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

**输出:**
```
Sun Oct 18 06:35:44 EDT 2015:看下这个tc版的夏洛特烦恼
Sun Oct 18 05:50:21 EDT 2015:老婆和闺蜜在看夏洛特烦恼，我在这边看孩子，原因是。。。。我觉得国产电影真心没有我闺女好看。。。。
Sun Oct 18 05:30:17 EDT 2015:Photo: 夏洛特烦恼.Goodbye.Mr.Loser.2015.TC720P.X264.AAC.Mandarin.CHS-ENG.Mp4Ba... http://t.co/Hk1kGRKTKk
Sun Oct 18 03:50:01 EDT 2015:很多年前微博上流行的那个段子：多希望某天醒来，发现外面阳光正好，老师站在讲台上讲课，一颗粉笔正要砸向你，周围都是年轻的面孔，桌上还有你睡觉留下的口水。夏洛特烦恼在这开始，加入：你喜欢的姑娘就坐在你的面前，那时一切还没开始，于是你狠狠地吻了下去……(那时在微博还改编过一个版本😂😂)
Sun Oct 18 03:40:41 EDT 2015:<夏洛特烦恼>不就是吊丝的黄粱一梦吗，梦里爱人变坏，自己名扬天下，然后说什么还是老情人好，梦醒来一切散去，就醒悟了，爱得不要不要的，娇柔的笑点，真是日了狗了的剧情😒😒
Sun Oct 18 03:26:17 EDT 2015:曝<夏洛特烦恼>抄袭 两部电影对比揭真相(图) http://t.co/GXpMXyBU3w #news #报纸 #新闻 #新华网
Sun Oct 18 03:13:15 EDT 2015:Goodbye Mr. Loser 夏洛特烦恼 2015 https://t.co/jtK2Vxak3I 来自 @YouTube
Sun Oct 18 02:41:27 EDT 2015:曝<夏洛特烦恼>抄袭 两部电影对比揭真相(图) http://t.co/EmoJbxdFRD #news #报纸 #新闻 #新华网
Sun Oct 18 02:10:18 EDT 2015:<夏洛特烦恼>票房破10亿 沈腾兑现承诺晒裸照
编者按：1905电影网讯 据悉闫非、彭大魔执导，沈腾和马丽领衔主演的穿越青春爆
http://t.co/vgPqccQxEf http://t.co/rcnRdKYpdb
Sun Oct 18 02:10:02 EDT 2015:RT @basinattuite: 炸裂！<夏洛特烦恼>居然全片抄袭了<教父>导演的旧作！http://t.co/cQyPeG9mHS
```

### 参考

[Twitter4J](http://twitter4j.org/en/index.html)  
[Twitter4J code examples](http://twitter4j.org/en/code-examples.html)  
[Twitter4J configuration](http://twitter4j.org/en/configuration.html)  