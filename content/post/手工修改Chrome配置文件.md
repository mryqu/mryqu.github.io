---
title: '手工修改Chrome配置文件'
date: 2014-03-02 19:57:00
categories: 
- Tool
tags: 
- chrome
- 配置
---
当初装Chrome，g.cn上死活下载不了，随便装了一个澳洲版的。结果访问taobao、weibo被认成了澳洲用户，都被推到了海外入口。
一开始折腾Chrome的配置菜单，没找到。后来直接修改C:\Users\\AppData\Local\Google\Chrome\UserData\Default\Preferences搞定了。
原始值：
```
      "last_known_google_url": "https://www.google.com.au/",
      "last_prompted_google_url": "https://www.google.com.au/",
```
修改后：
```
      "last_known_google_url": "https://www.google.com.hk/",
      "last_prompted_google_url": "https://www.google.com.hk/",
```
