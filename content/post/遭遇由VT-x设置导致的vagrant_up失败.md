---
title: '遭遇由VT-x设置导致的vagrant up失败'
date: 2015-05-05 06:06:28
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- vt-x
- invalid_state
- devops
---
我在同事申请的一台机器上安装Vagrant box，结果`vagrant up`失败，报如下错误：
<pre>
The guest machine entered an invalid state while waiting for it to boot. Valid states are 'starting, running'. The machine is in the 'poweroff' state. Please verify everything is configured properly and try again.
If the provider you're using has a GUI that comes with it, it is often helpful to open that and watch the machine, since the GUI often has more helpful error messages than Vagrant can retrieve. For example, if you're using VirtualBox, run `vagrant up` while the VirtualBox GUI is open.
</pre>

打开VirtualBox界面，重新执行`vagrant up`，然后在VirtualBox里获取日志，显示如下错误：
<pre>Failed toopen a session for the virtual machine <font color="#B4B4B4">XXXXXXXXXXXXXXXX</font>.<font color="#FF0000">VT-x is not available.(VERR_VMX_NO_VMX).</font></pre>

对于64位虚拟机，没有VT扩展的话，Virtualbox不支持64位客户机。解决方案是在BIOS使能Intel虚拟技术（VT-X）。
如果宿主机不支持VT-X，网上有一个解决方案（未经本人验证）：
```
config.vm.provider :virtualbox do |vb|
  vb.customize ["modifyvm", :id, "--hwvirtex", "off"]
end
```

其作用等同于VirtualBox的vbox配置文件中的：
![遭遇由VT-x设置导致的vagrant up失败](/images/2015/5/0026uWfMgy6Vmai3r3R23.png)
此外如果vagrant内部出现问题，一个很好的调试方法是：
```
VAGRANT_LOG=debug
vagrant up
```

### 参考

[Guest Machine Entered Invalid State #220](https://github.com/cloudfoundry/bosh-lite/issues/220)    
[Vagrant Up Error In Headless Ubuntu: The guest machine entered an invalid state while waiting for it to boot](http://stackoverflow.com/questions/19419563/vagrant-up-error-in-headless-ubuntu-the-guest-machine-entered-an-invalid-state)    
[Error VT-x not available for Vagrant machine inside Virtualbox](http://stackoverflow.com/questions/24620599/error-vt-x-not-available-for-vagrant-machine-inside-virtualbox)    
[Vagrant › VT-x is not available.](https://groups.google.com/forum/#!topic/vagrant-up/4rOCCWfILYc)    
[Enabling Intel VT-x and AMD-V virtualization hardware extensions in BIOS](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Administration_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html)    
[Disable VT-X in Vagrantfile](https://gist.github.com/betweenbrain/7798873)    