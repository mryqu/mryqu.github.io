---
title: 'Facebook根据请求API版本返回不同内容？'
date: 2017-04-27 06:10:12
categories: 
- DataBuilder
tags: 
- facebook
- api
- version
- empty
- depend
---
今天跟测试组同事研究Facebook返回内容时，发现一个奇怪现象：抓取湖南卫视的Page，当API版本为2.3至2.8时，返回结果内容为空；而API版本为2.9时，返回有内容的响应。
![FB API 2.7 Response](/images/2017/04/FB27Response.png) ![FB API 2.9 Response](/images/2017/04/FB29Response.png)

