---
title: 'Gradle multi-project Builds on HelloSocialMedia'
date: 2015-10-22 05:38:15
categories: 
- DataBuilder
tags: 
- gradle
- multi-project
- build
- socialmedia
---
尝试对我的HelloSocialMedia演示代码集合使用Gradle的多项目构建，项目结构如下：
```
HelloSocialMedia/
  build.gradle
  settings.gradle
  HelloYoutubeAnalytics/
    build.gradle
  HelloGoogleAnalytics/
    build.gradle
  HelloTwitter4J/
    build.gradle
  HelloRestFB/
    build.gradle
```

**settings.gradle**
```
rootProject.name = 'HelloSocialMedia'

include "HelloYoutubeAnalytics"
include "HelloGoogleAnalytics"
include "HelloTwitter4J"
include "HelloRestFB"

project(":HelloYoutubeAnalytics").name = "HelloSocialMedia-YoutubeAnalytics"
project(":HelloGoogleAnalytics").name = "HelloSocialMedia-GoogleAnalytics"
project(":HelloTwitter4J").name = "HelloSocialMedia-Twitter4J"
project(":HelloRestFB").name = "HelloSocialMedia-RestFB"
```

**build.gradle**
```
buildscript {
  repositories {
    mavenCentral()
  }
}

subprojects {
  apply plugin: 'java'
  apply plugin: 'eclipse'
  apply plugin: 'idea'
 
  repositories {
    mavenCentral()
  }
        
  sourceCompatibility = 1.8
  targetCompatibility = 1.8    
}
```

**HelloYoutubeAnalytics/build.gradle**
```
jar {
  baseName = 'hello-youbube-analytics'
  version =  '0.1.0'
}

dependencies {
  compile 'com.google.api-client:google-api-client-gson:1.20.0' exclude module: 'httpclient'
  compile 'com.google.apis:google-api-services-youtube:v3-rev150-1.20.0'
  compile 'com.google.apis:google-api-services-youtubeAnalytics:v1-rev53-1.20.0'
  compile 'com.google.apis:google-api-services-youtubereporting:v1-rev1-1.20.0'
}
```

**HelloGoogleAnalytics/build.gradle**
```
jar {
  baseName = 'hello-google-analytics'
  version =  '0.1.0'
}

dependencies {
  compile 'com.google.api-client:google-api-client-gson:1.20.0' exclude module: 'httpclient'
  compile 'com.google.apis:google-api-services-analytics:v3-rev118-1.20.0'
}
```

**HelloTwitter4J/build.gradle**
```
jar {
  baseName = 'hello-twitter4j'
  version =  '0.1.0'
}

dependencies {
  compile 'org.twitter4j:twitter4j-core:4.0+'
}
```

**HelloRestFB/build.gradle**
```
jar {
  baseName = 'hello-restfb'
  version =  '0.1.0'
}

dependencies {
  compile 'com.restfb:restfb:1.15.0'
}
```

### 参考

[Gradle user guide: Multi-project Builds](https://docs.gradle.org/current/userguide/multi_project_builds.html)  