---
title: '批处理：搜索Jar包中的类文件'
date: 2013-10-20 15:55:59
categories: 
- Java
tags: 
- 批处理
- jar
- class
- windows
- 搜索
---
网上转载的很多，原文出处不详。

批处理文件利用7z和findstr两个命令搜索当前目录下所有Jar包，分析是否有所要查找的类文件：
```
@echo off  
SETLOCAL  

set WHICH_CLASS=%1  
echo WHICH_CLASS=%WHICH_CLASS%  

for /F %%i in ('dir /A:-D /S /B *.jar') do 7z l %%i | findstr %WHICH_CLASS% && echo %WHICH_CLASS% found in: "%%i"  
echo "Finished class finding..."  
echo "======================================"  
ENDLOCAL 
```

命令运行格式：
```
findclass com\\yqu\\kxmt\\TestFindClass.class
```