---
title: '[Vagrant] 学习一下Vagrant的Provider类型'
date: 2018-07-25 06:05:44
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- provider
---

偶尔动了心思，想自己装一个Wiki。就按照[MediaWiki-Vagrant](https://www.mediawiki.org/wiki/MediaWiki-Vagrant)，装一个Vagrant版的MediaWiki玩玩。MediaWiki全球最著名的开源wiki程序，运行于PHP+MySQL环境。MediaWiki从2002年2月25日被作为维基百科全书的系统软件，并有大量其他应用实例。
![我的WIKI](/images/2018/07/HelloWiki.jpg)
顺手研究了一下[mediawiki/vagrant项目的Vagrantfile文件](https://gerrit.wikimedia.org/r/plugins/gitiles/mediawiki/vagrant/+/master/Vagrantfile)，跟我们自己项目用的Vagrantfile仅仅配置了一个VirtualBox provider不同，它配置了[VirtualBox](https://www.virtualbox.org/)、VMWare Fusion、[Microsoft Hyper-V](https://www.microsoft.com/hyper-v)、LXC、[Parallels](http://parallels.github.io/vagrant-parallels/)和libvirt (KVM/QEMU)六种provider。
在[Vagrant的网站](https://www.vagrantup.com/docs/providers/)上仅仅提及了默认的[VirtualBox](https://www.vagrantup.com/docs/virtualbox/)、[VMware](https://www.vagrantup.com/docs/vmware/)、[Docker](https://www.vagrantup.com/docs/docker/)、[Hyper-V](https://www.vagrantup.com/docs/hyperv/)四款provider。那到底Vagrant有多少provider类型呢？
从Vagrant Cloud上可知有22种provider类型的Vagrant box镜像可供下载：
- aws
- cloudstack
- digitalocean
- docker
- google
- hyperv
- libvirt
- lxc
- openstack
- parallels
- qemu
- rackspace
- softlayer
- veertu
- virtualbox
- vmware
- vmware_desktop
- vmware_fusion
- vmware_ovf
- vmware_workstation
- vsphere
- xenserver

![Vagrant provider类型](/images/2018/07/VagrantProviders.jpg)

