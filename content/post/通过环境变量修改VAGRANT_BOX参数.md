---
title: '通过环境变量修改VAGRANT BOX参数'
date: 2015-06-12 06:14:24
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- env
- configuraiton
---
在如下示例Vagrantfile文件片段，VAGRANTBOX的内存和CPU核数首先查询环境变量，如果没有设相关环境变量的话则使用默认值。
```
config.vm.provider "virtualbox" do |v|
  v.memory = ENV.has_key?('VAGRANTBOX_MEM') ? ENV['VAGRANTBOX_MEM'].to_i : 1024
  v.cpus = ENV.has_key?('VAGRANTBOX_CPUS') ? ENV['VAGRANTBOX_CPUS'].to_i : 2
  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  v.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
end
```

### 参考

[Vagrant VirtualBox Configuration](https://docs.vagrantup.com/v2/virtualbox/configuration.html)  