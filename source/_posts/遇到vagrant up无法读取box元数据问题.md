---
title: '遇到"vagrant up"无法读取box元数据问题'
date: 2016-03-18 06:46:16
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- version
- constraint
- box_url
- issue
---
昨天在某个Windows Server2008上升级了Vagrant (1.8.1)和VitualBox(5.0.16)，然后`vagrant up`就开始出问题了。
```
C:\foo>vagrant up
Bringing machine 'xfoo' up with 'virtualbox' provider...
==> xfoo: Box ‘foo-ubuntu‘ could not be found. Attempting to find and install...
    xfoo: Box Provider: virtualbox
    xfoo: Box Version: >= 0.12.0, < 1.0.0
==> xfoo: Box file was not detected as metadata. Adding it directly...
You specified a box version constraint with a direct box file
path. Box version constraints only work with boxes from Vagrant
Cloud or a custom box host. Please remove the version constraint
and try again.
```

打开调试信息，发现：
```
C:\foo>vagrant up --debug
INFO global: Vagrant version: 1.8.1
INFO global: Ruby version: 2.2.3
INFO global: RubyGems version: 2.4.5.1
......
INFO box_add: Downloading box: http://vagrant.xxx.com/xxx/foo-ubuntu.json => C:/Users/xxx/.vagrant.d/tmp/box23c35c4058493b8228b6114d4cfdbbc0a5b597c2
```

这个问题跟下列已知问题类似，都是curl获取不到box的元数据。
- [error: You specified a box version constraint with a direct box file path #165](https://github.com/coreos/coreos-vagrant/issues/165)
- [Vagrant cannot fetch coreos_production_vagrant.json #236](https://github.com/coreos/coreos-vagrant/issues/236)
- [Issue downloading json file from box_url #4647](https://github.com/mitchellh/vagrant/issues/4647)
- [vagrant box add should handle 404 errors when downloading a remote box or box.json file #5332](https://github.com/mitchellh/vagrant/issues/5332)

最后，我把Vagrant降级到1.7.4，这个问题不再复现！
