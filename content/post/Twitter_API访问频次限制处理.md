---
title: 'Twitter API访问频次限制处理'
date: 2015-11-10 06:11:32
categories: 
- DataBuilder
tags: 
- twitter
- access
- rate
- limitation
- twitter4j
---
在我前面的博文[社交媒体API访问频次限制](/post/社交媒体api访问频次限制)中，列举了[Twitter API访问频次限制](https://dev.twitter.com/rest/public/rate-limiting)。

### [Twitter API访问频次限制](https://dev.twitter.com/rest/public/rate-limiting)

TwitterAPI访问频次按15分钟为间隔。有两类桶：15分钟内允许15次调用，及15分钟内允许180次调用。Twitter搜索属于后者，在15分钟内允许180次调用。
当向Twitter发送请求后，可以通过解析响应头来获取限制信息。该信息是基于应用/用户上下文的：
- X-Rate-Limit-Limit: 对给定请求的访问速率上限
- X-Rate-Limit-Remaining: 15分钟时间窗中剩余请求数
- X-Rate-Limit-Reset: 速率限制复位前（基于UTC）的剩余时间窗秒数

一旦对Twitter的请求超过了频次限制，Twitter将返回HTTP 429 “Too ManyRequests”响应码及如下消息体：
```
{ "errors": [ { "code": 88, "message": "Rate limit exceeded" } ] }
```

除了通过解析响应头，还可以通过向Twitter发送[rate_limit_status](https://dev.twitter.com/rest/reference/get/application/rate_limit_status)请求获取API访问限制信息。

### Twitter4J对Twitter API访问频次限制的处理

Twitter4J的RateLimitStatusJSONImpl类用于处理响应头中的访问限制信息：
![Twitter API访问频次限制处理](/images/2015/11/0026uWfMgy70l4Hwxzo86.png)
Twitter4J的TwitterResponseImpl抽象类用于存放解析过的访问限制信息以供应用程序使用：
![Twitter API访问频次限制处理](/images/2015/11/0026uWfMgy70l4BbTd6c0.jpg)
此外，还可以注册RateLimitStatusListener监听器实例。由Twitter4J的TwitterBaseImpl类可知，当解析到响应头中的API访问频次限制信息，RateLimitStatusListener监听器实例的onRateLimitStatus方法会被调用；当收到的响应码为420"Enhance Your Claim"、503 "Service Unavailable"或429 "Too ManyRequests"，RateLimitStatusListener监听器实例的onRateLimitReached方法将会被调用。
