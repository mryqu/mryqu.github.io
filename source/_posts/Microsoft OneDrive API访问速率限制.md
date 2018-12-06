---
title: 'Microsoft OneDrive API访问速率限制'
date: 2016-10-15 06:11:28
categories: 
- DataBuilder
tags: 
- onedrive
- api
- rate
- limit
- quota
---
一开始查看OneDrive文档[Quota facet](https://dev.onedrive.com/facets/quotainfo_facet.htm),，发现里面介绍的是OneDrive存储容量配额，跟API访问速率限制没有关系。除此之外，没有发现任何相关信息。
OneDrive文档[Error response](https://dev.onedrive.com/misc/errors.htm)里面，看到如下跟访问速率限制相关的错误：
- Status code: 429 (Too Many Requests)和509 (Bandwidth LimitExceeded)
- The code property: activityLimitReached (The app or user hasbeen throttled)
- Detailed error code: throttledRequest (Too many requests)