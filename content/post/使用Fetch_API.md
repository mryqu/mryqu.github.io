---
title: '使用Fetch_API'
date: 2018-03-09 05:50:21
categories: 
- FrontEnd
tags: 
- fetch_api
- chrome
- devtool
- javascript
- html
---
今天又学了一招在Chrome developer tool中通过[Fetch_API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)发起HTTP请求。
![fetch_api](/images/2018/03/fetch_api.jpg)代码示例：
```
fetch('https://jsonplaceholder.typicode.com/posts/1')
  .then(response => response.json())
  .then(json => console.log(json))
```


