---
title: '使用Consul的十二要素应用（Twelve-Factor App）'
date: 2015-06-16 05:36:28
categories: 
- Tool
- Consul
tags: 
- consul
- twelve-factor
- envconsul
- consul-template
- devops
---
[十二要素应用（The Twelve-Factor App）](http://12factor.net/)主张web应用应该从环境变量里获取其[配置](http://12factor.net/config)。这一实践很快被现代PaaS服务采用以用于允许简单的配置变更。
使用Consul，很容易将这一实践用于你自己的数据中心。如果你基础架构的某些方面部分使用PaaS，Consul是配置数据中心化的一个很好的方式。
在这篇文章中，我们将展示Consul和[envconsul](https://github.com/hashicorp/envconsul)如何在不修改应用程序的情况下被用于设置配置值和在配置变更时触发自动重启。

### 为什么使用环境变量?

根据十二要素应用，web应用配置应该使用环境变量。跟配置文件或Java系统属性这样的机制比，环境变量有很多优点：
- 环境变量是一个与开发语言和操作系统无关的标准。
- 环境变量更难被意外提交到代码库。
- 环境变量跟易于在development、staging、QA这样不同的环境之间改变。
- 无论如何部署，环境变量易于设置和更新。

例如[Heroku](http://www.heroku.com/)这样的完整PaaS解决方案公开一些有用的API以用于为应用自动设置/读取环境变量。
当手动部署应用时，以往这样的事会更复杂一些。而使用Consul，程序员就可以很容易地设置和读取配置，运营工程师就可以很容易地提供支持和维护。

### Consul键值对和Envconsul

Consul能够[存储键值对数据](http://www.consul.io/intro/getting-started/kv.html)。对于设置和获取键值对数据，Consul拥有简单的API和美丽且直观的[web界面](http://www.consul.io/intro/getting-started/ui.html)。对于存储配置数据来说，它是完美的。
很容易看到如何设置和读取配置数据，但是对于配置数据如何变成应用的环境变量还不是很清楚。[envconsul](https://github.com/hashicorp/envconsul)是一个解决该类问题的轻量级解决方案。
使用envconsul，环境变量存储在ConsulKV中并具有某些（以"/"分割的）前缀。例如，为了配置服务"foo"，我们可能存储如下配置：
```
$ curl -X PUT -d 'false' http://localhost:8500/v1/kv/foo/enabled
true
```

这会在键`foo/enabled`中存储值`false`。
之后，使用envconsul, 我们可以将这些键转换为环境变量：
```
$ envconsul foo env
ENABLED=false
```

`envconsul`是一个对UNIX非常友好的应用。他有两个必需的参数：一个用于查找数据的KV前缀和一个应用及其可选参数。在上例中，我们告诉envconsul配置位于前缀`foo`下，且我们想运行应用`env`，该应用仅仅是输出环境变量。
在示例结果中，我们可以清楚地看到`ENABLED`如我们在ConsulKV中所设置的`false`。

如果将`env`改成你自己的应用，那么环境变量将暴露给你的应用。例如，为了运行一个Rails服务器你可能做如下操作。注意在真实生产场景中，你可能不直接运行Rails内建服务器，但是它不失为一个好案例：
```
$ envconsul foo bin/rails server
...
```

### 自动重载

使用PaaS，当你修改任何配置时你的应用将自动重启。我们可以以最小的代价通过Consul和Envconsul实现相同效果。
通过对envconsul添加`-reload`标志，一旦配置键发生增删改，envconsul将中断(SIGTERM)并重启你的应用：
```
$ envconsul -reload foo bin/rails server
...
```
<font color="#FF0000">注：该功能已经在0.4.0版本移除。</font>
[Consul HTTP API](http://www.consul.io/docs/agent/http.html)支持对给定前缀KV中的变更进行长轮询。一旦KV中发生变更，Envconsul通过这种方式可以高效地进行检测。

### 改良流程

对应用配置使用Consul和envconsul可以将PaaS化应用配置易用性带入你自己的原生环境。
对于开发者而言，他们可以无需跟运营工程师沟通或重新部署应用就可以设置配置。
对于运营来说，Consul对整个基础架构的服务发现和配置提供了统一的解决方案。Consul自动复制数据并存储在磁盘上以方便备份，运营工程师也可以高枕无忧了。

### 我的实践

Envconsul获取的环境变量既可以直接给启动服务器的命令使用（例如上面启动Rails内建服务器的`bin/rails`命令）；也可以通过python之类的脚本存成Java系统属性文件，通过chpst这样可以加载环境变量/系统属性文件的命令间接给Java命令使用。
```
envconsul \
-once \
-log-level info \
-consul localhost:8500 \
-upcase=false \
-prefix config/foo/jvm \
foo env /usr/local/tomcat/bin/catalina.sh run
```

### 参考

[Twelve-Factor Applications with Consul](https://hashicorp.com/blog/twelve-factor-consul.html)   
[Github：hashicorp/envconsul](https://github.com/hashicorp/envconsul)  
[Github：hashicorp/consul-template](https://github.com/hashicorp/consul-template)  
[Github：mhamrah/docker-envconsul](https://github.com/mhamrah/docker-envconsul)  
[Docker Hub：panteras/paas-in-a-box](https://hub.docker.com/r/panteras/paas-in-a-box/~/dockerfile/)  
[Scalable Architecture DR CoN: Docker, Registrator, Consul, Consul Template and Nginx](https://www.airpair.com/scalable-architecture-with-docker-consul-and-nginx)  