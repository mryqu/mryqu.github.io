---
title: '[Golang] Win10下Glide的安装和使用'
date: 2017-10-16 15:47:55
categories: 
- Golang
tags: 
- golang
- glide
- windows
- dependencies
- package
---

不论是开发Java还是你正在学习的Golang，都会遇到依赖管理问题。Java有牛逼轰轰的Maven和Gradle。 Golang亦有Godep、Govendor、Glide、dep等等。本文主要给大家介绍[Glide](https://github.com/Masterminds/glide)。 [Glide](https://github.com/Masterminds/glide)是Golang的包管理工具，是为了解决Golang依赖问题的。 为什么需要[Glide](https://github.com/Masterminds/glide)？ 原因很简单，Go语言原生包管理的缺陷。罗列一下Golang的get子命令管理依赖有很多大缺陷：
*   能拉取源码的平台很有限，绝大多数依赖的是 github.com
*   不能区分版本，以至于令开发者以最后一项包名作为版本划分
*   依赖 列表/关系 无法持久化到本地，需要找出所有依赖包然后一个个 go get
*   只能依赖本地全局仓库（GOPATH/GOROOT），无法将库放置于项目局部仓库（$PROJECT_HOME/vendor）

[Glide](https://github.com/Masterminds/glide)是有下列几大主要功能：
*   持久化依赖列表至配置文件中，包括依赖版本（支持范围限定）以及私人仓库等
*   持久化关系树至 lock 文件中（类似于 yarn 和 cargo），以重复拉取相同版本依赖
*   兼容 go get 所支持的版本控制系统：Git, Bzr, HG, and SVN
*   支持 GO15VENDOREXPERIMENT 特性，使得不同项目可以依赖相同项目的不同版本
*   可以导入其他工具配置，例如： Godep, GPM, Gom, and GB

[Glide](https://github.com/Masterminds/glide)在Mac或Linux上是很容易安装的，但是在Win10 x64上据说最新版有问题。详见[https://github.com/Masterminds/glide/issues/873](https://github.com/Masterminds/glide/issues/873)。
想多了没用，还是实干吧。从[https://github.com/Masterminds/glide/releases](https://github.com/Masterminds/glide/releases)上下载了glide-v0.13.0-windows-amd64.zip，里面就一个glide.exe。
![glide install](/images/2017/10/glide.png)
将glide.exe放入%GOPATH%/bin下，然后将%GOPATH%/bin加入环境变量Path中，由于我的Go版本是1.9所以GO15VENDOREXPERIMENT环境变量就不用管了。执行` glide --version` ，开头没问题呀！
![glide version](/images/2017/10/glideVer.png)
进入我的项目目录%GOPATH%/src/helloglide，执行下列命令：
```
glide create #创建新的工作空间，生成glide.yaml
glide get github.com/pborman/uuid  #获取uui包
glide install #建立glide.lock版本
go build #构建项目

glide list #列举项目导入的所有包
INSTALLED packages:
        github.com\pborman\uuid

glide tree #以树的形式列举项目导入的所有包
[WARN]  The tree command is deprecated and will be removed in a future version
helloglide
|-- github.com/pborman/uuid   (XXXXXX\helloglide\vendor\github.com\pborman\uuid)
```
一切顺利，之前算是我庸人自扰吧。Go官方有了dep项目，[Glide](https://github.com/Masterminds/glide)也呼吁切换到dep上去，所以对Glide的学习就到这里吧。

### 参考

* * *
[GitHub：Masterminds/glide](https://github.com/Masterminds/glide)  
[The glide.yaml File](https://glide.readthedocs.io/en/latest/glide.yaml/)  
[Semantic Versioning 2.0.0](https://semver.org/)  
[Versions and Ranges in glide](https://glide.readthedocs.io/en/latest/versions/)  
[Golang依赖管理工具：glide从入门到精通使用](https://studygolang.com/articles/10453?fr=email)  