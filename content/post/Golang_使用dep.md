---
title: '[Golang] 使用dep'
date: 2017-10-22 06:00:25
categories: 
- Golang
tags: 
- golang
- dep
- package
- dependency
- management
---

之前的博文[[Golang]Win10下Glide的安装和使用](/post/golang_win10下glide的安装和使用)记录了对Glide的学习，本博将记录对Golang包管理工具dep的学习使用。

## dep介绍

在2012年，go get成为获取依赖包的方式。dep的FAQ中有一段描述dep是否要取代go get的解答，一句话概括就是：依赖管理工具是为应用管理代码的，go get是为GOPATH管理代码的。go get仅仅支持获取master branch上的latest代码，没有指定version、branch或revision的能力。这不符合gopher对自己项目所依赖的第三方包受控的期望。
在2015年，Russ Cox在Go 1.5发布前期以一个experiment feature身份紧急加入vendor机制，vendor标准化了项目依赖的第三方库的存放位置，隔离不同项目依赖的同一个包的不同版本。
Golang的包管理一直没有官方统一的解决方案，因此也产生了很多非官方的包管理工具。这些工具很多都很不错，但是相互兼容性差。随着Go语言在全球范围内应用的愈加广泛，缺少官方包管理工具这一问题变得日益突出。2016年GopherCon大会后，由微服务框架go-kit作者Peter Bourgon牵头， 在Go官方的组织下，Go包管理委员会经过各种头脑风暴和讨论后发布了“[包管理建议书](https://docs.google.com/document/d/18tNd8r5DV0yluCR7tPvkMTsWD_lYcRO7NhpNSDymRr8)”，并启动了最有可能被接纳为官方包管理工具的项目dep的设计和开发。当前主导dep开发的是Sam Boyer，Sam也是dep底层包依赖分析引擎-gps的作者。2017年年初，dep项目正式对外开放。

## 安装

我的实验平台是Win10，所以无法通过brew或者shell脚本安装，只能通过go get安装：
```
go get -u github.com/golang/dep/cmd/dep
```
安装完，执行dep命令，出现帮助代表安装成功。
```
$ dep
Dep is a tool for managing dependencies for Go projects

Usage: "dep [command]"

Commands:

  init     Set up a new Go project, or migrate an existing one
  status   Report the status of the project's dependencies
  ensure   Ensure a dependency is safely vendored in the project
  prune    Pruning is now performed automatically by dep ensure.
  version  Show the dep version information

Examples:
  dep init                               set up a new project
  dep ensure                             install the project's dependencies
  dep ensure -update                     update the locked versions of all dependencies
  dep ensure -add github.com/pkg/errors  add a dependency to the project

Use "dep help [command]" for more information about a command.

$ dep help ensure
Usage: dep ensure [-update | -add] [-no-vendor | -vendor-only] [-dry-run] [-v] [...]

Project spec:

  [:alt source URL][@]

Ensure gets a project into a complete, reproducible, and likely compilable state:

  * All non-stdlib imports are fulfilled
  * All rules in Gopkg.toml are respected
  * Gopkg.lock records precise versions for all dependencies
  * vendor/ is populated according to Gopkg.lock

Ensure has fast techniques to determine that some of these steps may be
unnecessary. If that determination is made, ensure may skip some steps. Flags
may be passed to bypass these checks; -vendor-only will allow an out-of-date
Gopkg.lock to populate vendor/, and -no-vendor will update Gopkg.lock (if
needed), but never touch vendor/.

The effect of passing project spec arguments varies slightly depending on the
combination of flags that are passed.

Examples:

  dep ensure                                 Populate vendor from existing Gopkg.toml and Gopkg.lock
  dep ensure -add github.com/pkg/foo         Introduce a named dependency at its newest version
  dep ensure -add github.com/pkg/foo@^1.0.1  Introduce a named dependency with a particular constraint

For more detailed usage examples, see dep ensure -examples.

Flags:

  -add          add new dependencies, or populate Gopkg.toml with constraints for existing dependencies (default: false)
  -dry-run      only report the changes that would be made (default: false)
  -examples     print detailed usage examples (default: false)
  -no-vendor    update Gopkg.lock (if needed), but do not update vendor/ (default: false)
  -update       update the named dependencies (or all, if none are named) in Gopkg.lock to the latest allowed by Gopkg.toml (default: false)
  -v            enable verbose logging (default: false)
  -vendor-only  populate vendor/ from Gopkg.lock without updating it first (default: false)
```

## 使用

### main.go

仍然使用博文[[Golang]Win10下Glide的安装和使用](/post/golang_win10下glide的安装和使用)中的源码示例：
```
package main

import (
  "fmt"
  "github.com/pborman/uuid"
);

func main() {
        id := uuid.New();
        fmt.Println("Hello uuid:"+id);
}
```

### 初始化

通过dep init命令创建新项目（使用了-v选项打印更多细节）：
```
$ dep init -v
Getting direct dependencies...
Checked 5 directories for packages.
Found 1 direct dependencies.
Root project is "hellodep"
 1 transitively valid internal packages
 1 external packages imported from 1 projects
(0)   ? select (root)
(1)     ? attempt github.com/pborman/uuid with 1 pkgs; 5 versions to try
(1)         try github.com/pborman/uuid@v1.1
(1)     ? select github.com/pborman/uuid@v1.1 w/1 pkgs
  ? found solution with 1 packages from 1 projects

Solver wall times by segment:
         b-list-pkgs: 5.0792684s
              b-gmal: 5.0078158s
     b-source-exists: 2.1603804s
     b-list-versions: 1.4574079s
         select-atom:         0s
               other:         0s
         select-root:         0s
  b-deduce-proj-root:         0s
             satisfy:         0s
            new-atom:         0s

  TOTAL: 13.7048725s

  Using ^1.1.0 as constraint for direct dep github.com/pborman/uuid
  Locking in v1.1 (e790cca) for direct dep github.com/pborman/uuid
(1/1) Wrote github.com/pborman/uuid@v1.1
```
dep init大致会做这么几件事：
- 利用gps分析当前代码包中的包依赖关系；
- 将分析出的项目包的直接依赖(即main.go显式import的第三方包，direct dependency)约束(constraint)写入项目根目录下的Gopkg.toml文件中；
- 将项目依赖的所有第三方包（包括直接依赖和传递依赖transitive dependency）在满足Gopkg.toml中约束范围内的最新version/branch/revision信息写入Gopkg.lock文件中；
- 创建root vendor目录，并且以Gopkg.lock为输入，将其中的包（精确checkout 到revision）下载到项目root vendor下面。
执行完dep init后，dep会在当前目录下生成若干文件：
```
├── Gopkg.lock
├── Gopkg.toml
├── main.go
└── vendor/
       └── github.com/
              └── pborman/
                     └── uuid/
```
Gopkg.toml：记录了一个直接依赖uuid，确定的uuid依赖版本约束为1.1.0
```
[[constraint]]
  name = "github.com/pborman/uuid"
  version = "1.1.0"

[prune]
  go-tests = true
  unused-packages = true
```
Gopkg.lock：记录了在上述约束下所有依赖可用的最新版本
```
[[projects]]
  name = "github.com/pborman/uuid"
  packages = ["."]
  revision = "e790cca94e6cc75c7064b1332e63811d4aae1a53"
  version = "v1.1"

[solve-meta]
  analyzer-name = "dep"
  analyzer-version = 1
  inputs-digest = "fbe0d2bde8a8c1659d0e965328bda4e05f246c471267358b9dfe9c95fd1025ff"
  solver-name = "gps-cdcl"
  solver-version = 1
```
至此，dep init完毕，相关依赖包也已经被vendor，可以使用go build/install进行程序构建了。
如果你对dep自动分析出来的各种约束和依赖的版本没有异议，那么这里就可以将Gopkg.toml和Gopkg.lock作为项目源码的一部分提交到代码库中了。这样其他人在下载了你的代码后，可以通过dep直接下载lock文件中的第三方包版本，并存在vendor里。这样就使得无论在何处，项目构建的依赖库理论上都是一致的，实现可重现构建。但一般不推荐将vendor目录提交到代码仓库，vendor的提交会让代码库变得异常庞大，且更新vendor时大量的diff会影响到成员对代码的review（注：对于Git代码仓库可通过.gitignore过滤掉）。

### 构建

这里构建是通过Makefile进行，由于其他成员将项目从代码仓库克隆到本地后并没有vendor目录，所以在setup规则里使用dep ensure -vendor-only命令通过Gopkg.lock和Gopkg.toml中的数据创建vendor目录和同步里面的包，之后就可以完成可重现构建了。
```
BUILD_ENV := CGO_ENABLED=0
LDFLAGS=-ldflags "-w -s"

TARGET_EXEC := hellodep

.PHONY: all clean setup generate build-linux build-osx build-windows

all: clean setup generate build-linux build-osx build-windows

clean:
        rm -rf build

setup:
        mkdir -p build/linux
        mkdir -p build/osx
        mkdir -p build/windows
        - ${BUILD_ENV} dep ensure -vendor-only

build-linux: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=linux go build ${LDFLAGS} -o build/linux/${TARGET_EXEC}

build-osx: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=darwin go build ${LDFLAGS} -o build/osx/${TARGET_EXEC}

build-windows: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=windows go build ${LDFLAGS} -o build/windows/${TARGET_EXEC}.exe
```
dep ensure命令的一些选项如下：
- -no-vendor选项允新Gopkg.lock，但不更新vendor目录
- -vendor-only选项允许使用过时的Gopkg.lock创建vendor目录
- -update选项更新Gopkg.lock中的命名依赖到Gopkg.toml允许的最高版本

### 指定依赖

如果依赖包相对Gopkg.lock增加了多个版本，而项目组想要使用较新的功能时，可能会尝试用dep ensure -update命令获取最新的依赖包。
一旦发现使用最新的依赖包有问题怎么办？可以通过在Gopkg.toml指定依赖版本使用较新的可用依赖包。

### dep本地缓存

dep会在$GOPATH/pkg/dep/sources下留了一块“自留地”，用于缓存所有从network上下载的依赖包。
对dep init命令使用-gopath选项会优选从$GOPATH查找依赖包。

## 参考

*****
[GitHub：golang/dep](https://github.com/golang/dep)  
[dep FAQ](https://github.com/golang/dep/blob/master/docs/FAQ.md)  
[dep roadmap](https://github.com/golang/dep/wiki/Roadmap)  
[Gopkg.toml](https://golang.github.io/dep/docs/Gopkg.toml.html)  
[Gopkg.lock](https://golang.github.io/dep/docs/Gopkg.lock.html)  
[dep - Go dependency management](https://go-talks.appspot.com/github.com/edmontongo/presentations/2017-05/dep/dep.slide)  
[初窥dep](https://studygolang.com/articles/10008)  
[Golang官方依赖管理工具：dep](https://studygolang.com/articles/10589)  
[Go最新的dep详解](https://studygolang.com/articles/9435)  



