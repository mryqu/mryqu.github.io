---
title: 'Gradle代理配置'
date: 2015-08-31 05:46:52
categories: 
- Tool
- Gradle
tags: 
- gradle
- proxy
- configuration
---
### HTTP代理配置

```
gradlew -Dhttp.proxyHost=[myServer] -Dhttp.proxyPort=[myPort] -Dhttp.proxyUser=[myUser] -Dhttp.proxyPassword=[myPassword]
```

### HTTPS代理配置

```
gradlew -Dhttps.proxyHost=[myServer] -Dhttps.proxyPort=[myPort] -Dhttps.proxyUser=[myUser] -Dhttps.proxyPassword=[myPassword]
```
