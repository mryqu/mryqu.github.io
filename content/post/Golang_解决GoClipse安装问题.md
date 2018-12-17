---
title: '[Golang] 解决GoClipse安装问题'
date: 2017-10-14 17:22:43
categories: 
- Golang
tags: 
- golang
- goclipse
- eclipse
- godef
- guru
---
按照[GoClipse安装文档](https://github.com/GoClipse/goclipse/blob/latest/documentation/Installation.md)安装Eclipse的GoClipse插件时，提示org.eclipse.platform.feature.group无法找到。
![GoClipse](/images/2017/10/GoClipse.png)
我的Eclipse还是Eclipse 4.4 (Luna)，而GoClipse要求Eclipse 4.6 (Neon)及更高版本，看来不听话是没有好下场的。接着这个机会升级到Eclipse 4.7 (Oxygen)吧。

### 安装gocode、guru、godef

gocode在安装LiteIDE时已经安装。GoClipse下载guru会执行`go get -u golang.org/x/tools/cmd/guru` ，其结果是网站不响应该请求。
```
go get -u github.com/nsf/gocode
go get -u github.com/rogpeppe/godef

mkdir %GOPATH%\src\golang.org\x\
cd %GOPATH%\src\golang.org\x\
git clone https://github.com/golang/tools.git

go install golang.org/x/tools/cmd/guru
```
![guru](/images/2017/10/guru.png) 

### 配置GoClipse

![GoClipse Conf-Go](/images/2017/10/GoClipse-Conf-Go.png) ![GoClipse Conf-Tools](/images/2017/10/GoClipse-Conf-Tools.png)

### 测试

![GoClipse Test](/images/2017/10/GoClipseTest.png) 齐活！