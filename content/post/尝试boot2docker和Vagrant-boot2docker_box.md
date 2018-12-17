---
title: '尝试boot2docker和Vagrant-boot2docker box'
date: 2015-05-17 20:40:31
categories: 
- Tool
- Vagrant
tags: 
- boot2docker
- vagrant
- docker
---
### boot2docker

boot2docker是基于[Tiny Core Linux](http://tinycorelinux.net/)的轻量级Linux发布版本虚拟机，专用于运行[Docker](https://www.docker.io/)容器。
功能如下：
- 3.18.5内核及AUFS文件系统、Docker 1.5.0
- 容器通过磁盘自动加载在/var/lib/docker目录持久化
- SSH密钥通过磁盘自动加载进行持久化
- 容易访问Docker映射端口的主机模式（Host-only）

![尝试boot2docker和Vagrant-boot2docker box](/images/2015/5/0026uWfMgy6Ta8Br9YK52.jpg)

### Vagrant兼容的boot2docker box

Vagrant创始人Mitchell Hashimoto使用boot2docker虚拟机创建了一个可被VirtualBox和VMware提供者支持的Vagrant box。当Vagrant被运行于Linux之外的操作系统时，Vagrant的Docker提供者默认使用boot2dockerbox提供Docker功能。
![尝试boot2docker和Vagrant-boot2docker box](/images/2015/5/0026uWfMgy6T05DEUFI0a.jpg)

### 参考

[boot2docker官网](http://boot2docker.io/)    
[GitHub:boot2docker](https://github.com/boot2docker)    
[GitHub:boot2docker-cli](https://github.com/boot2docker/boot2docker-cli)    
[GitHub:mitchellh/boot2docker-vagrant-box](https://github.com/mitchellh/boot2docker-vagrant-box)    
[yungsang/boot2docker](https://vagrantcloud.com/yungsang/boxes/boot2docker)    
[GitHub:yungsang/boot2docker](https://github.com/YungSang/boot2docker-vagrant-box)    
[Using Docker with Vagrant](http://blog.scottlowe.org/2015/02/10/using-docker-with-vagrant/)    
[Setting up a development environment using Docker and Vagrant](http://blog.zenika.com/index.php?post/2014/10/07/Setting-up-a-development-environment-using-Docker-and-Vagrant)    
[Docker in OSX via boot2docker or Vagrant: getting over the hump](https://macyves.wordpress.com/2014/05/31/docker-in-osx-via-boot2docker-or-vagrant-getting-over-the-hump/)    