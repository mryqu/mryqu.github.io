---
title: '升级tsc.js解决TypeScript编译失败问题'
date: 2017-03-07 06:10:36
categories: 
- 前端
tags: 
- ts5052
- sourcemap
- ts5053
- inlinesourcemap
- typescript
---
今天项目忽然构建失败，遭遇下列错误：
```
error TS5052: Option 'sourceRoot' cannot be specified without specifying option 'sourceMap'.
error TS5053: Option 'sourceRoot' cannot be specified with option 'inlineSourceMap'.
```
查了下tsconfig.json，发现前两天"sourceMap"属性由true改为了false，又增加了值为true的"inlineSourceMap"属性。
最后只好把项目里的tsc.js从1.6.4升级成2.1.6才解决问题。