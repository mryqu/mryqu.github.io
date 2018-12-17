---
title: '定制Vagrant box主机'
date: 2015-05-07 21:34:40
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- box
- host
---
做个笔记，记录一下如何定制Vagrant box主机。
- 在Vagrantfile中通过一个Vagrant基础box定制box。
- 启动该定制box后，通过Vagrant package命令输出box文件
- 编写JSON格式的box元数据文件
- 将定制box文件及其元数据文件放到web服务器中
- 将此定制box作为基础box的Vagrantfile中，设置如下
  - config.vm.box用于匹配上述定制box的名称
  - config.vm.box_url为box文件的URL或box元数据文件的URL当config.vm.box_url为box文件的URL，该box文件即为基础box；当config.vm.box_url为box元数据文件的URL，可以使用config.vm.box指定名称的某一版本box文件（有config.vm.box_version参数，即使用其约束的特定版本；否则，使用最新版本box文件）作为基础box。
  - config.vm.box_version指定box的特定版本。
  
### 参考

[Custom Vagrant Cloud Versioned Box Host](http://blog.el-chavez.me/2015/01/31/custom-vagrant-cloud-host/)    
[Vagrant: CREATING A BASE BOX](https://www.vagrantup.com/docs/boxes/base.html)    
[Vagrant: MACHINE SETTINGS](https://www.vagrantup.com/docs/vagrantfile/machine_settings.html)    