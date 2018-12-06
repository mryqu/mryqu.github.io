---
title: '[Gradle] 设置项目属性的三种方式'
date: 2015-04-07 05:36:16
categories: 
- Tool
- Gradle
tags: 
- gradle
- project
- property
- set
---
#### 命令行
```
gradle bootRun -PyquPropKey=yquPropValue
```

#### build.properties
```
yquPropKey=yquPropValue
```

#### gradle.properties

添加ext块：
```
ext {
  yquPropKey=yquPropValue
}
```
