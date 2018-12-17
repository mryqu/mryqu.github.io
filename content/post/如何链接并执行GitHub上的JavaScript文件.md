---
title: '如何链接并执行GitHub上的JavaScript文件'
date: 2015-07-10 00:28:30
categories: 
- 前端
tags: 
- github
- javascript
- execute
- mime
- text/plain
---
想要玩一下[jquery-mockjax](https://github.com/jakerella/jquery-mockjax)，其原始文件为https://raw.githubusercontent.com/jakerella/jquery-mockjax/master/dist/jquery.mockjax.js ，加入我的html文件进行测试。结果却遇到下列问题：
```
Refused to execute script from ... because its MIME type (text/plain) is not executable, and strict MIME type checking is enabled.
```

查到了StackOverflow上的一个帖子[Link and execute external JavaScript file hosted on GitHub](http://stackoverflow.com/questions/17341122/link-and-execute-external-javascript-file-hosted-on-github) ，原来GitHub开始使用`X-Content-Type-Options:nosniff`以令更多的现代浏览器执行严格MIME类型检查，之后返回原始文件的MIME类型故意让浏览器不能使用。帖子中提到的临时解决方法是将raw.githubusercontent.com替换为rawgit.com。我将上一链接替换成https://rawgit.com/jakerella/jquery-mockjax/master/dist/jquery.mockjax.js ，解决问题！
