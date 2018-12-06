---
title: '[Golang] 使用Makefile实现Go项目的跨平台构建'
date: 2017-10-18 05:49:28
categories: 
- Golang
tags: 
- golang
- makefile
- phony
- ldflags
---
通常编译go程序，都是用go build，对于小的示例代码还可以应付，对于稍大一点的项目就有点繁琐了。
上网调差了一下，发现很多人是通过Makefile的形式对Go项目进行可重现构建的。下面我将以hellomake项目这个小示例展示如何使用Makefile实现Go项目的跨平台构建。

### hellomake/Makefile

```
BUILD_ENV := CGO_ENABLED=0
BUILD=`date +%FT%T%z`
LDFLAGS=-ldflags "-w -s -X main.Version=${VERSION} -X main.Build=${BUILD}"

TARGET_EXEC := hellomake

.PHONY: all clean setup build-linux build-osx build-windows

all: clean setup build-linux build-osx build-windows

clean:
    rm -rf build

setup:
    mkdir -p build/linux
    mkdir -p build/osx
    mkdir -p build/windows

build-linux: setup
    ${BUILD_ENV} GOARCH=amd64 GOOS=linux go build ${LDFLAGS} -o build/linux/${TARGET_EXEC}

build-osx: setup
    ${BUILD_ENV} GOARCH=amd64 GOOS=darwin go build ${LDFLAGS} -o build/osx/${TARGET_EXEC}

build-windows: setup
    ${BUILD_ENV} GOARCH=amd64 GOOS=windows go build ${LDFLAGS} -o build/windows/${TARGET_EXEC}.exe
```
需要说明以下几点：
* 该Makefile将构建Linux、Osx和Windows三个平台的二进制可执行文件。
* 如果代码使用了 C binding，你可能会遇到一些问题。Cgo的问题在于需要一个与给定平台兼容的gcc. 如果开发在OSX/Windows 上完成，需要有一个能够兼容Linux的gcc已进行交叉编译。如果需要Cgo, docker镜像是创建 Linux 构建的最好方式。这种方式唯一的要求就是必须安装 Docker。
* LDFLAGS中的-w选项用于抹除DWARF符号表，-s选项用于抹除符号表和调试信息。更多细节详见[参考一](https://golang.org/cmd/link/)。
* 对于Makefile中的目标，如果目录下有跟目标同名的文件，则GNU Make认为已更新则不再执行。Phony目标可以避免这一问题。更多细节详见[参考二](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)。
*   该Makefile可以进一步扩充，实现glide或dep更新、go generate过程......

### hellomake/main.go

```
package main

import (
  "flag"
  "fmt"
  "os"
)

var (
  Version string
  Build   string
)

func main() {
  if len(os.Args) == 2 {
    version := flag.Bool("version", false,
      "print version information and exit")
    flag.Parse()
    if *version {
      fmt.Println("hellomake " + Version + " (" + Build + ")")
      os.Exit(0)
    }
  }

  fmt.Println("Hello World!")
}
```
通过flag包解析命令行参数是否为-version，是的话打印版本信息，否则输出Hello World!
还可以增加构建者姓名等信息。此外如果使用Git代码仓库的话，也可以通过git describe --tags获取Git标签，通过git rev-parse HEAD获得提交的SHA1。

### 构建

我的Windows环境有安装MinGW和Git Bash，所以图省事就直接在Windows平台上直接构建了。启动Git Bash，执行下列命令：
```
/c/MinGW/bin/mingw32-make all VERSION=1.2.3
```
通过GNU make命令构建Go项目，通过命令行传递VERSION变量。

### 测试

```
$ ./build/windows/hellomake -version
hellomake 1.2.3 (2017-10-17T21:15:25+0800)

$ ./build/windows/hellomake
Hello World!
```

### 参考

* * *
[go tool link](https://golang.org/cmd/link/)  
[GNU make - Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)  
[Build Golang projects properly with Makefiles](https://www.slideshare.net/RaPz1/build-golang-projects-properly-with-makefiles)  
[A Makefile for your Go project](https://vincent.bernat.im/en/blog/2017-makefile-build-golang#working-with-non-vendored-packages-only)  
[Golang: Don’t afraid of makefiles](https://sohlich.github.io/post/go_makefile/)  
[GitHub: cloudflare/hellogopher](https://github.com/cloudflare/hellogopher)  
[Golang：无惧makefile](http://blog.csdn.net/ZVAyIVqt0UFji/article/details/78126171)  
[win下 golang 跨平台编译](https://studygolang.com/articles/98?fr=sidebar)  
[Go与Makefile实现跨平台交叉编译](https://cn.aliyun.com/jiaocheng/121488.html)  
[GitHub: TimothyYe/ydict](https://github.com/TimothyYe/ydict/blob/master/Makefile)  