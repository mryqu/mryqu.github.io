---
title: '[Golang] Go程序内嵌I18N properties文件'
date: 2017-10-19 06:11:03
categories: 
- Golang
tags: 
- golang
- go-bindata
- generate
- i18n
- properties
---
本博文将介绍一下如何将I18N properties文件内嵌到Go程序中。一般来说，go-i18n等Go包官方示例使用JSON文件保存I18N消息，而我的示例还是采用properties文件。

## go-bindata

go-bindata包可以将任何文件转换为可管理的Go源代码，在将二进制数据嵌入Go程序时是非常有帮助的。文件数据在转换成原始字节切片之前可做选择性的gzip压缩。
在我的示例中，我选择用go-bindata将i18n/resources下的i18n properties文件嵌入Go程序。

### 安装
```
go get -u github.com/jteeuwen/go-bindata/...
```
地址最后的三个点 ...会分析所有子目录并下载依赖编译子目录内容，而go-bindata的命令行工具在子目录中。go-bindata命令行工具将被安装到$GOPATH/bin目录中。
![go-bindata](/images/2017/10/go-bindata.png)
### 资源文件

#### i18n/resources/locale.properties
```
mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata example.
```
#### i18n/resources/locale_en.properties
```
mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata example.
```
#### i18n/resources/locale_zh-Hans.properties
```
mryqu.hello=欢迎来到Golang世界！
mryqu.intro=这是一个go-bindata示例。
```

### 操练

看了go-bindata的帮助后，感觉go-bindata简单易用。这里就探索一下nocompress选项吧。
```
cd {MyPrj}/i18n
go-bindata -pkg i18n -o resources.go  resources/
go-bindata -pkg i18n -o resources-nocompress.go -nocompress resources/
```
通过对比resources.go和resources-nocompress.go可以看出，resources.go里面多引入了bytes、compress/gzip和io包，多生成了一个bindataRead函数用于读取gzip压缩后的数据。
![go-bindata compress opt](/images/2017/10/go-bindata-compressOpt.png)
在resources.go中的内嵌数据：
```
var _resourcesLocaleProperties = []byte("\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\xff\xca\x2d\xaa\x2c\x2c\xd5\xcb\x48\xcd\xc9\xc9\xb7\x0d\x4f\xcd\x49\xce\xcf\x4d\x55\x28\xc9\x57\x70\xcf\xcf\x49\xcc\x4b\x57\x28\xcf\x2f\xca\x49\x51\xe4\xe5\x82\xa8\xca\xcc\x2b\x29\xca\xb7\x0d\xc9\xc8\x2c\x56\xc8\x2c\x56\x48\x54\x48\xcf\xd7\x4d\xca\xcc\x4b\x49\x2c\x49\x54\x48\xad\x48\xcc\x2d\xc8\x49\xd5\x03\x04\x00\x00\xff\xff\x45\xdc\x42\x7f\x4f\x00\x00\x00")

var _resourcesLocale_enProperties = []byte("\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\xff\xca\x2d\xaa\x2c\x2c\xd5\xcb\x48\xcd\xc9\xc9\xb7\x0d\x4f\xcd\x49\xce\xcf\x4d\x55\x28\xc9\x57\x70\xcf\xcf\x49\xcc\x4b\x57\x28\xcf\x2f\xca\x49\x51\xe4\xe5\x82\xa8\xca\xcc\x2b\x29\xca\xb7\x0d\xc9\xc8\x2c\x56\xc8\x2c\x56\x48\x54\x48\xcf\xd7\x4d\xca\xcc\x4b\x49\x2c\x49\x54\x48\xad\x48\xcc\x2d\xc8\x49\xd5\x03\x04\x00\x00\xff\xff\x45\xdc\x42\x7f\x4f\x00\x00\x00")

var _resourcesLocale_zhHansProperties = []byte("\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\xff\xca\x2d\xaa\x2c\x2c\xd5\xcb\x48\xcd\xc9\xc9\xb7\x7d\xb6\x66\xd1\x8b\xfd\x7d\xcf\xe6\x2e\x7d\xda\xb1\xc1\x3d\x3f\x27\x31\x2f\xfd\xc9\x8e\x69\xcf\xa7\xf6\xbc\xdf\xd3\xc8\xcb\x05\x51\x98\x99\x57\x52\x94\x6f\xfb\x62\xff\xcc\x67\x33\xd6\x3f\xd9\xd1\xf0\x64\xc7\xaa\xf4\x7c\xdd\xa4\xcc\xbc\x94\xc4\x92\xc4\xe7\x4b\x76\x3d\xd9\xd7\xfd\xb8\xa1\x09\x10\x00\x00\xff\xff\xf7\xd1\x50\xc9\x54\x00\x00\x00")
```
在resources-nocompress.go中的内嵌数据：
```
var _resourcesLocaleProperties = []byte(`mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata example.`)

var _resourcesLocale_enProperties = []byte(`mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata example.`)

var _resourcesLocale_zhHansProperties = []byte(`mryqu.hello=欢迎来到Golang世界！
mryqu.intro=这是一个go-bindata示例。`)
```
在resources-nocompress.go中的内嵌数据和properties文件中的一模一样，而resources.go中的内嵌数据经过gzip压缩后已经看不出来原貌了。

## go generate

从Go1.4起包含go generate命令，可以通过扫描Go源码中的特殊注释来识别要运行的常规命令。go generate不是go build的一部分，它不包含依赖关系分析，必须在运行go build之前显式运行。
Go generate命令很容易使用。要使go generate驱动上面的go-bindata过程，在同一目录中的任何一个普通（非生成）.go文件中，将该注释添加到文件中的任何位置:
```
//go:generate go-bindata -pkg i18n -o resources.go resources/
```
注释必须从行的开始处开始，并在//和go:generate之间没有空格。在该标记之后，该行的其余部分指定go generate运行的命令。

### i18n/i18n.go
```
package i18n

//go:generate go-bindata -pkg i18n -o resources.go resources/

import (
        "fmt"
        "strings"
)

var Translations = map[string]string{}

const (
        AssetSuffix    = ".properties"
        FileNamePrefix = "locale_"
)

func init() {
        assets, err := AssetDir("resources")
        if err != nil {
                fmt.Println("Unable to read required assets:"+err)
        }
        for _, asset := range assets {
                flName := strings.TrimSuffix(asset, AssetSuffix)
                assetLocale := strings.TrimPrefix(flName, FileNamePrefix)
                if "" == assetLocale {
                        assetLocale = "en"
                }
                Translations[assetLocale] = string(MustAsset("resources/" + asset))
        }
}
```

### 操练

```
cd {MyPrj}
go generate -x ./i18n
```
一切顺利！

## 参考

*****
[GitHub：jteeuwen/go-bindata](https://github.com/jteeuwen/go-bindata)  
[Go 内嵌静态资源](https://studygolang.com/articles/5068)  
[The Go Blog - Generating code](https://blog.golang.org/generate)  



