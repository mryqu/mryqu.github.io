---
title: '[Golang] Go项目的国际化 '
date: 2017-10-21 06:34:41
categories: 
- Golang
tags: 
- golang
- i18n
- go-bindata
- properties
- go-i18n
---

因为我看的那些书里都没有提及Go项目的国际化实现，但在放狗搜索前，还是觉得跟Java/JS项目中的实践应该都差不多。搜了一下才发现自己Too young too simple！
在[Internationalization plan for Go](https://groups.google.com/forum/?fromgroups=#!topic/golang-nuts/_dHb28WG68g)中提到了Golang曾经的I18N路线图：
*   对国际化文本提供全面支持
*   对国际化日期、时间等提供支持
*   对多语言消息提供支持

这个2011年的讨论有人提及Golang已经支持UTF8/unicode，日期时间自己可以格式化，其他人纷纷表示不同意他的观点，然后就没有然后了。
Golang的标准库还有提供完整的I18N支持，所以还需要对众多的Golang I18N库进行技术选型。通过[https://golanglibs.com/search?q=i18n](https://golanglibs.com/search?q=i18n)可知[go-i18n](https://github.com/nicksnyder/go-i18n)排名第一，而且使用者也比较多。[i18n4go](https://github.com/maximilien/i18n4go)为大厂IBM的cloud CTO出品，从Cloud Foundary CLI中提取出来的，估计能遇到的坎都解决掉了，但是排名并不靠前。
最终决定开始我的go-18n学习之旅。

## 通过go-bindata嵌入i18n properties文件

具体细节见之前的博文[Go程序内嵌I18N properties文件](/post/golang_go程序内嵌i18n_properties文件)。  

### 资源文件

#### i18n/resources/locale.properties
```
mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata-i18n example.
mryqu.verinfo={{.Cli}} Version {{.Version}} (Build: {{.Build}})
```
#### i18n/resources/locale_en.properties
```
mryqu.hello=Welcome to Golang world!
mryqu.intro=This is a go-bindata-i18n example.
mryqu.verinfo={{.Cli}} Version {{.Version}} (Build: {{.Build}})
```
#### i18n/resources/locale_zh-CN.properties
```
mryqu.hello=欢迎来到Golang世界！
mryqu.intro=这是一个go-bindata-i18n示例。
mryqu.verinfo={{.Cli}} 版本 {{.Version}} (构建：{{.Build}})
```
## 其他源码

### i18n/i18n.go

与之前的博文[Go程序内嵌I18N properties文件](/post/golang_go程序内嵌i18n_properties文件)相比，这里添加了下面内容：
1. 使用github.com/magiconair/properties包获取properties文件内的键值对；
2. 通过github.com/nicksnyder/go-i18n/i18n包判断properties文件语言、为文件内所有键值对创建新的翻译。（如果不用properties文件，而是json或TOML格式文件，i18n.LoadTranslationFile就可以直接完成这些事情了，见[https://github.com/nicksnyder/go-i18n/blob/master/i18n/bundle/bundle.go](https://github.com/nicksnyder/go-i18n/blob/master/i18n/bundle/bundle.go)。）

go-i18n的优点：
*   实现了[CLDR plural rules](http://cldr.unicode.org/index/cldr-spec/plural-rules)。
*   使用[text/template](https://golang.google.cn/pkg/text/template/)处理带有变量的字符串。
*   翻译文件可以是简单的JSON、TOML和YAML。

```
package i18n

//go:generate go-bindata -pkg i18n -o resources.go resources/

import (
  "fmt"
  "github.com/magiconair/properties"
  "github.com/nicksnyder/go-i18n/i18n"
  "github.com/nicksnyder/go-i18n/i18n/language"
  "github.com/nicksnyder/go-i18n/i18n/translation"
  "strings"
)

const (
  DefaultLocale = "en"
  AssetSuffix    = ".properties"
  FileNamePrefix = "locale_"
)

var locale = DefaultLocale
var tDefault i18n.TranslateFunc = i18n.IdentityTfunc()
var T i18n.TranslateFunc

func init() {
  assets, err := AssetDir("resources")
  if err != nil {
    fmt.Println("Unable to read required assets:"+err.Error())
  }
  for _, asset := range assets {
    flName := strings.TrimSuffix(asset, AssetSuffix)
    assetLocale := strings.TrimPrefix(flName, FileNamePrefix)
    if "" == assetLocale {
      assetLocale = "en"
    }
    transFile := string(MustAsset("resources/" + asset))

    p, err := properties.Load([]byte(transFile), properties.UTF8)
    if err != nil {
      fmt.Printf("ERROR: during properties processing - %+v\n", err)
    }

    tranDocuments := []map[string]interface{}{}
    for _, k := range p.Keys() {
      tranDocuments = append(tranDocuments,
        map[string]interface{}{
          "id":          k,
          "translation": p.GetString(k, k),
        })
    }

    languages := language.Parse(assetLocale)
    for _, lang:= range languages {
      for _, trans := range tranDocuments {
        // TODO error handling
        t, err := translation.NewTranslation(trans)
        if err != nil {
          fmt.Printf("ERROR: during translation processing - %+v\n", err)
        }
        i18n.AddTranslation(lang, t)
      }
    }

    tDefault, _ = i18n.Tfunc(DefaultLocale)
    T = tDefault

  }
}

func SetLocale(l string) {
  locale = l
  T = TfuncWithFallback(l)
}

func TfuncWithFallback(l string) i18n.TranslateFunc {
  t, err := i18n.Tfunc(l)
  if err != nil {
    fmt.Println("failed to set i18n.Tfunc with "+l)
  }
  return func(translationID string, args ...interface{}) string {
    if translated := t(translationID, args...); translated != translationID {
      return translated
    }

    return tDefault(translationID, args...)
  }
}
```
### main.go
```
package main

import (    
  "flag"
  "fmt"  
  "os"
  "hello-bindata-i18n/i18n"
)

var (
  Cli     string = "hello-bindata-i18n"
  Version string
  Build   string
)

func main() {
  if len(os.Args) > 1 {
    version := flag.Bool("version", false,
      "print version information and exit")
    locale := flag.String("locale", "en",
      "locale info")
    flag.Parse()

    if locale != nil {
      i18n.SetLocale(*locale)
    }

    if *version {
      fmt.Println(i18n.T("mryqu.verinfo",
        map[string]interface{}{"Cli": Cli, "Version": Version, "Build": Build}))
      os.Exit(0)
    }
  }

  fmt.Println(i18n.T("mryqu.hello"))
}
```
### Makefile

更多细节见之前的博文[使用Makefile实现Go项目的跨平台构建](/post/golang_使用makefile实现go项目的跨平台构建) 。这里在setup规则里增加了glide update，增加了generate规则。
```
BUILD_ENV := CGO_ENABLED=0
BUILD=`date +%FT%T%z`
LDFLAGS=-ldflags "-w -s -X main.Version=${VERSION} -X main.Build=${BUILD}"

TARGET_EXEC := helloi18n

.PHONY: all clean setup generate build-linux build-osx build-windows

all: clean setup generate build-linux build-osx build-windows

clean:
        rm -rf build

setup:
        mkdir -p build/linux
        mkdir -p build/osx
        mkdir -p build/windows
        - ${BUILD_ENV} glide update

generate:
        go generate -x ./i18n

build-linux: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=linux go build ${LDFLAGS} -o build/linux/${TARGET_EXEC}

build-osx: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=darwin go build ${LDFLAGS} -o build/osx/${TARGET_EXEC}

build-windows: setup
        ${BUILD_ENV} GOARCH=amd64 GOOS=windows go build ${LDFLAGS} -o build/windows/${TARGET_EXEC}.exe
```
## 测试
```
  $ build/windows/helloi18n.exe
  Welcome to Golang world!

  $ build/windows/helloi18n.exe -version
  hello-bindata-i18n Version 1.2.3 (Build: 2017-10-21T20:45:26+0800)

  $ build/windows/helloi18n.exe -locale zh-CN
  欢迎来到Golang世界！

  $ build/windows/helloi18n.exe -locale zh-CN -version
  hello-bindata-i18n 版本 1.2.3 (构建：2017-10-21T20:45:26+0800)

  $ build/windows/helloi18n.exe -locale zh
  欢迎来到Golang世界！

  $ build/windows/helloi18n.exe -locale zh -version
  hello-bindata-i18n 版本 1.2.3 (构建：2017-10-21T20:45:26+0800)

  $ build/windows/helloi18n.exe -locale fr
  failed to set i18n.Tfunc with fr
  Welcome to Golang world!
```

## 参考
* * *
[GitHub：nicksnyder/go-i18n](https://github.com/nicksnyder/go-i18n)  
[GitHub：jteeuwen/go-bindata](https://github.com/jteeuwen/go-bindata)  
[Go 内嵌静态资源](https://studygolang.com/articles/5068)  
[The Go Blog - Generating code](https://blog.golang.org/generate)  
[Go Web 编程 - 10 国际化和本地化](https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/10.0.md)  
[I18n strategies for Go with App Engine?](https://stackoverflow.com/questions/14124630/i18n-strategies-for-go-with-app-engine)  
[Internationalization plan for Go](https://groups.google.com/forum/?fromgroups=#!topic/golang-nuts/_dHb28WG68g)  
[GNU gettext utilities](https://www.gnu.org/software/gettext/manual/gettext.html)  

