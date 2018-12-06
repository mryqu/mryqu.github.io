---
title: '[Golang] GOPATH和包导入'
date: 2017-10-20 05:43:09
categories: 
- Golang
tags: 
- golang
- gopath
- package
- import
---

才开始玩GoLang，碰到一些与包导入相关的问题：
*   go build没有找到vendor目录下的包
*   local import "./XXX" in non-local package

### GoLang自定义包的特点

1.  Go的package不局限于一个文件，可以由多个文件组成。组成一个package的多个文件，编译后实际上和一个文件类似，组成包的不同文件相互之间可以直接引用变量和函数，不论是否导出；因此，组成包的多个文件中不能有相同的全局变量和函数（这里有一个例外就是包的初始化函数：init函数）
2.  Go不要求package的名称和所在目录名相同，但是你最好保持相同，否则容易引起歧义。因为引入包的时候，go会使用子目录名作为包的路径，而你在代码中真正使用时，却要使用你package的名称。
3.  每个子目录中只能存在一个package，否则编译时会报错。
4.  Go的package是以绝对路径GOPATH来寻址的，不要用相对路径来导入

### 包的初始化函数init

包中可以有多个初始化函数init，每个初始化函数都会被调用，且顺序固定。
1.  对同一个Go文件的init()调用顺序是从上到下的
2.  对同一个package中不同文件是按文件名字符串比较“从小到大”顺序调用各文件中的init()函数。
3.  对于对不同的package，如果不相互依赖的话，按照main包中"先import的后调用"的顺序调用其包中的init()
4.  如果package存在依赖，则先调用最早被依赖的包中的init()

### GOPATH

go命令依赖一个重要的环境变量：$GOPATH。从go 1.8开始，GOPATH环境变量现在有一个默认值，如果它没有被设置。 它在Unix上默认为$HOME/go,在Windows上默认为%USERPROFILE%/go。GOPATH支持多个目录。
```
$GOPATH
  src
   |--github.com
          |-mryqu
              |-prj1
                 |-vendor
   |--prj2
          |-vendor

   pkg
    |--相应平台
         |-github.com
               |--mryqu
                    |-prj1
                         |-XXX.a
                         |-YYY.a
                         |-ZZZ.a
         |-prj2
               |-AAA.a
               |-BBB.a
               |-CCC.a
```
Go加载包时会从vendor tree、 $GOROOT下的src目录以及$GOPATH中的多目录下的src目录查找。

### 相对路径导入

通过go build无法完成非本地导入（non-local imports），必须使用go build main.go。go install根本不支持非本地导入。
相对路径导入文档位于[https://golang.org/cmd/go/#hdr-Relative_import_paths](https://golang.org/cmd/go/#hdr-Relative_import_paths)
更多细节见：
*   [https://groups.google.com/forum/#!topic/golang-nuts/1XqcS8DuaNc/discussion](https://groups.google.com/forum/#!topic/golang-nuts/1XqcS8DuaNc/discussion)
*   [https://github.com/golang/go/issues/12502](https://github.com/golang/go/issues/12502)
*   [https://github.com/golang/go/issues/3515#issuecomment-66066361](https://github.com/golang/go/issues/3515#issuecomment-66066361)

### 参考
* * *
[Build Web Application with Golang](https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/01.2.md)  
[关于golang中包（package）的二三事儿](https://studygolang.com/articles/155)  
[Go: local import in non-local package](https://stackoverflow.com/questions/30885098/go-local-import-in-non-local-package)  