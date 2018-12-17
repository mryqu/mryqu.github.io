---
title: '[JS] 通过升级npm解决了error TS2322和TS2307'
date: 2018-01-28 05:48:25
categories: 
- 前端
tags: 
- npm
- grunt
- typescript
- error
- TS2322
- TS2307
---

上一个项目有个defect需要解决，很久没有动它了，所以一上来先**git pull**更新代码库，然后通过**gradlew clean build --refresh-dependencies**进行构建，不料竟然碰到很多TS2322和TS2307错误，最后:grunt_build任务以失败告终。通过如下命令更新npm，问题不复重现。
```
npm cache clean
npm install
```

不过具体是怎么解决的问题，还是不太清楚。有可能是因为npm升级了TypeScript，从而使问题得以解决。
```
C:\>npm list -g
C:\Users\xxxxxx\AppData\Roaming\npm
`-- typescript@2.1.6

C:\xxxgitws\xxxxxx-app>npm list typescript
xxxxxx-app@3.0.0-0 C:\xxxgitws\xxxxxx-app
`-- guides-buildtools-openuibundled@8.0.0
  `-- guides-buildtools-openui@8.0.0
    `-- typescript@2.4.1
```