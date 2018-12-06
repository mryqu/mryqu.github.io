---
title: '解：failed to create task or type cobertura-instrument'
date: 2011-11-07 19:50:31
categories: 
- Java
tags: 
- cobertura
- 测试覆盖率
- ant
- code coverage
---
由于项目需要，学习使用cobertura检查junit测试覆盖率。
结果ant总是报错：
```
BUILD FAILEDbuild.xml:54: Problem: failed to create task or typecobertura-instrumentCause: The name is undefined.Action: Check the spelling.Action: Check that any custom tasks/types have been declared.Action: Check that any<presetdef>/<macrodef>declarations have taken place.
```

搜了一些文章，都无解，最后看cobertura的example，找到病根。
解决方法：
将<taskdef classpath="cobertura.classpath"resource="tasks.properties" />改成<taskdef classpathref="cobertura.classpath"resource="tasks.properties" />就好了。
