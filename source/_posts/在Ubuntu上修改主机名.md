---
title: '在Ubuntu上修改主机名'
date: 2013-08-05 22:49:19
categories: 
- Tool
- Linux
tags: 
- ubuntu
- hostname
---
### 显示主机名
```
hostname -s
```
更多细节见[hostname](http://manpages.ubuntu.com/manpages/xenial/en/man1/hostname.1.html)帮助文档。

### 修改主机名

```
sudo hostname your-new-name
# Ubuntu专有
hostnamectl set-hostname new-hostname
```
更多细节见[hostnamectl](http://manpages.ubuntu.com/manpages/xenial/en/man1/hostnamectl.1.html)帮助文档。
上述命令重启服务器后失效。

### 修改主机名配置

```
sudo -H vi /etc/hostname
sudo -H vi /etc/hosts
```