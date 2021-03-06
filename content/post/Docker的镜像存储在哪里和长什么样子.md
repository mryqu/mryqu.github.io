---
title: 'Docker的镜像存储在哪里和长什么样子'
date: 2015-07-05 00:27:30
categories: 
- Tool
- Docker
tags: 
- docker
- image
- 存储位置
- 存储方式
- devops
---
接触docker后，我就有个疑问：我们用docker pull镜像后，该镜像是存储在哪里的？是以一个特俗的二进制类型存储的么？后来阅读了[Docker的镜像存储在哪里](http://my.oschina.net/guol/blog/263750)这篇博文，得以解惑，并进行了验证。
Docker的镜像存储在/var/lib/docker目录下，存储方式有点像Git那样有reference和实际的objects，并且是实际内容是diff那样的增量存放。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UCAWCsX630.png)

- - -

## [Docker的镜像存储在哪里](http://my.oschina.net/guol/blog/263750)

有个疑问就是我们用docker pull镜像后，该镜像是存储在哪里的？
当你仅仅是使用docker启动一个实例的时候，是超级简单的，但是当你制作自己的Dockerfile时，可能会有一些迷惑，那就是我的docker镜像存储在哪里了。这个听起来让我感觉有点一筹莫展，对于dockerimage的存储我还是一无所知。最后你只能把镜像发布到公共DockerIndex上面，但是，在过去一段时间内你是无法删除它的，但是现在你可以通过官方的WEB界面来删除它了。

### Image VS Dockerfile

这个看起来有点混淆，但是它们是有差别的，docke使用images运行你的代码，而不是Dockerfile。Dockerfile是你用dockerbuild命令来构建image的。如果你在浏览器中浏览DockerIndex，你会发现有很多images显示在上面，但是你不能看见构建它们的Dockerfile。当你使用dockerpush命令发布image时，它不会发布你的源代码，它只会发布从你源代码构建出来的镜像。

### Registry VS Index

下一个混淆的是Registry和Index，它们是怎么样区分的？index是管理公共web接口上的accounts、permission、search、tagging和所有精细的方面的。而registry是存储和提供实际image的，它委托index进行身份验证。当你运行dockersearch命令的时候，它搜索的是index，而不是registry。实际上，它可能搜索的是index知道的多个registry。当你运行dockerpush或者dockerpull命令时，index决定你是否有权限访问和修改images，当index同意你操作后，registry是提供images存储的地方，index会计算出哪个registry有你需要的镜像，并把请求转发过去。当你在本地运行dockerimages命令时，你可能是同时和index和registry进行交互。

### Repository

docker's使用镜像就像使用GitHub一样容易，但是有三个混淆的地方：
- repository和registry之间的区别
- repository和image之间的区别
- repository和index username之间的区别

其实repository并不是其中任何一个组件，而是指所有的组件。当你运行dockerimages命令时，你会看到如下： ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBW6cLctc1.jpg)
images列表看起来像repositories列表？实际上images是GUIDs，但这并不是如何和他们交互。当你执行dockerbuild或者dockercommit命令时，你可以指定image的名称，这个名称的格式是username/image_name，但这并不一定，它可以是任何形式的，他甚至可以是你已经知道的发布的镜像名称。当你执行dockerpush的时候，index会查看镜像名称，检查该镜像是否在repository中，如果在，接着检查你是否有权限访问该repository，如果有权限，则允许你push新版本的image到该repository上。因此，一个registry保留了它收集到的repository的名称，它本身跟踪收集到的images的GUIDs。thisis also where tags comein，你可以tag一个image，并且存储多个版本使用不同的GUIDs在同一个repository中，访问不同的标记的版本image，可以使用username/image_name:tag。
从上图中你可以看到我们有三个不同版本的image叫ubuntu12，每个的tag都是不同的，repository使用ubuntu12的名称来保存这些，因此，当我们看到ubuntu12的时候，它像一个image名称，但是实际上它使repository名称，repository名称有特殊的设计架构，index可以从第一部分解析出username，并且找出他在哪里。因此，当出现一个guol/ubuntu时会产生混淆，官方的repository名称是类似username/image_name这样的，我们想当然的认为repository名称是image_name，但是根据docker的文档发现repository的名称有时指的是全部的名称，有时指的是image_name。比如就像ubuntu，它就没有username，是不是有点乱了.........

### Local Storage on the Docker Host

我们已经了解完如何和远程存储进行交互了，但是当你运行dockerimages的时候，仅仅给你看到的是你的机器上有哪些image。这些镜像在哪里呢？第一个要查看的地方是/var/lib/docker/。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWdKIhj41.png)
查看repositories-aufs文件的内容，它的内容是在你本机上的repositories。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWiu39M9a.jpg)
看看，它完全匹配了docker images的输出内容。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWxYeS480.jpg)
现在我们来看看/var/lib/docker/graph/的内容。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWD1asQ8c.jpg)
我倒，显示的非常不友好啊，看看docker是怎样跟踪这些镜像的，是基于repositories-aufs文件，构建了一个映射到repository名称和tag的关系表。我们看看ubuntu12的仓库，它有三个镜像，标记分别是12.04、precise、latest。采用的是IDd431f556799d35dfae1278a1ee41a393db70058dedb9a7fc554b0506b5b241cb，我们看看这个目录里面有什么。
 ![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWKtzmH03.jpg)
只有两个文件：
- json：保存image的metadata
- layersize：只是一个数字，表明layer的大小 

![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWLUkvE2a.jpg)
主要镜像的差异在/var/lib/docker/aufs/diff/目录下，每次都会把镜像改变的部分存储在该目录下的相关ID目录里面。 
![Docker的镜像存储在哪里和长什么样子?](/images/2015/7/0026uWfMgy6UBWNEWG2e6.jpg)

参考：[Where are Docker images stored?](http://blog.thoward37.me/articles/where-are-docker-images-stored/)
