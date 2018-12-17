---
title: '了解PhantomJS'
date: 2016-04-13 06:02:28
categories: 
- 前端
tags: 
- phantomjs
---
今天看到我们的项目依赖[PhantomJS](http://phantomjs.org/)，就稍作了解。

### PhantomJS 是什么?

官方介绍如下：
> PhantomJS is a headless WebKit scriptable with a JavaScript API. It has fast and native support for various web standards: DOM handling, CSS selector, JSON, Canvas, and SVG.

PhantomJS是无需浏览器基于WebKit的全Web栈，支持JS解析引擎、渲染引擎、请求处理等，但是不包括显示和用户交互页面。

### PhantomJS的使用场景

- 无浏览器网站测试：支持使用Jasmine、QUnit、Mocha、Capybara、WebDriver等框架进行功能测试。
- 页面截屏：抓取页面内容，包括SVG和Canvas。
- 页面自动化：使用标准DOMAPI或jQuery等通用库访问和操作网页。
- 网页监控：监控网页加载和导出成标准HAR文件。让使用YSlow和Jenkins的性能分析自动化。

大概可以估计出PhantomJS的作用了，应该是用于单元测试吧。
