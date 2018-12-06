---
title: 'Apt-get代理配置'
date: 2015-05-20 00:03:27
categories: 
- Tool
- Linux
tags: 
- apt-get
- dns
- source
- proxy
- ubuntu
---
在公司安装Ubuntu docker后使用apt-get update总是失败，经历了一番周折才成功。

### DNS？

一开始怀疑是DNS问题，可以学习了下面几个帖子：
- [Docker apt-get update fails](http://stackoverflow.com/questions/24832972/docker-apt-get-update-fails)
- [Docker - Network calls fail during image build on corporate network](http://stackoverflow.com/questions/24151129/docker-network-calls-fail-during-image-build-on-corporate-network)
- [How do I set my DNS on Ubuntu 14.04?](http://unix.stackexchange.com/questions/128220/how-do-i-set-my-dns-on-ubuntu-14-04)

检查我ubuntu配置：
```
 cat /etc/resolv.conf
```
确认DNS没有问题。

### Ubuntu官方服务器？

是不是我的机器连不上欧美的Ubuntu官方服务器，换成中国服务器试试。尝试了[Ubuntu 14.04服务器列表](http://wiki.ubuntu.org.cn/Template:14.04source)上的中国服务器还是不成。

### Apt-get代理？

照着[how to install packages with apt-get on a system connected via proxy?](http://askubuntu.com/questions/89437/how-to-install-packages-with-apt-get-on-a-system-connected-via-proxy)设置一番，成功了

设置/etc/apt/apt.conf：
```
Acquire::http::proxy "http://yourServer:yourPort/";
Acquire::ftp::proxy "ftp://yourServer:yourPort/";
Acquire::https::proxy "https://yourServer:yourPort/";
```

如需用户名、密码，则作如下修改：
```
Acquire::http::proxy "http://yourUsr:yourPwd@yourServer:yourPort/";
Acquire::ftp::proxy "ftp://yourUsr:yourPwd@yourServer:yourPort/";
Acquire::https::proxy "https://yourUsr:yourPwd@yourServer:yourPort/";
```

最好将上述配置也存入`/etc/apt/apt.conf.d/80proxy`中，这样版本升级后这些变更也不会丢。
