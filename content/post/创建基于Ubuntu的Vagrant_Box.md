---
title: '创建基于Ubuntu的Vagrant Box'
date: 2019-01-02 06:07:31
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- box
- create
- ubuntu
---
学习一下创建Ubuntu基于VirtualBox provider的Vagrant Box。

### 准备环境

1. Vagrant
2. VirtualBox
3. 下载[Ubuntu 14.04.5 LTS (Trusty Tahr)服务器版ISO文件](http://releases.ubuntu.com/14.04/ubuntu-14.04.5-server-amd64.iso)

### 创建虚拟机

创建VirtualBox VM mryqu-ubuntu ![/images/2019/1/vagrantbox-newVM](vagrantbox-newVM.png)
内存1024MB ![vagrantbox-VM-memory1024MB](/images/2019/1/vagrantbox-VM-memory1024MB.png)
创建VMDK类型、自动分配的虚拟硬盘 ![vagrantbox-VM-disk20GB](/images/2019/1/vagrantbox-VM-disk20GB.png) 

### 安装Ubuntu

点击Setting，在Storage配置页的Controller:IDE中增加CD，选择所下载的Ubuntu ISO文件。然后启动虚拟机。
![vagrantbox-VM-addUbuntuCD](/images/2019/1/vagrantbox-VM-addUbuntuCD.png)
安装过程除了下列项之外使用默认选择：  
- Configure the network - Hostname: vagrant  
- Set up users and passwords: vagrant/vagrant  
- Encrypt your home directory? Select No  
- Select your time zone: UTC  
- Partitioning method: Guided – use entire disk and set up LVM  
- When prompted which software to install, select OpenSSH server

安装成功后，会提示进行登陆。
使用vagrant用户登陆后，使用`sudo su -`切到root账号，重新同步安装包索引并更新安装包。
```
apt-get update
apt-get upgrade
```

#### 为vagrant用户设置无密码sudo 

vagrant用户每次执行sudo命令会要求输入密码。通过`visudo`命令在配置文件末增加`vagrant ALL=(ALL) NOPASSWD:ALL`并保存即可实现无密码sudo。

#### 为vagrant用户设置无密码ssh

为了让Vagrant可以通过SSH登入虚拟机，需要使用公开密钥认证。仍旧以root账户身份执行下列操作：
```
cd /home/vagrant
mkdir .ssh
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
chown -R vagrant:vagrant .ssh
```
为了加速与虚拟机的SSH连接，可在`/etc/ssh`文件增加`UseDNS no`。
通过`service ssh restart`重启SSH服务器，通过`exit`命令推出root账户。

### 安装VirtualBox guest additions

为了让Vagrant可在客户机和宿主机操作系统之间共享目录，需要安装VirtualBox guest additions。
首先安装必须的包：
```
sudo apt-get install linux-headers-generic build-essential dkms -y
```
在虚拟机窗口，选择Devices菜单的Insert Guest Additions CD Image。!(vagrantbox-installGuestAdditions)(/images/2019/1/vagrantbox-installGuestAdditions.png)
安装VirtualBox guest additions：
```
sudo mount /dev/cdrom /media/cdrom
cd /media/cdrom
sudo ./VBoxLinuxAdditions.run
```
操作完成后，通过`sudo reboot`命令重启以使设置生效。

设置宿主机与客户机之间SSH端口转发。![vagrantbox-sshPortForwarding](/images/2019/1/vagrantbox-sshPortForwarding.png)
然后可在宿主机通过`ssh -p2222 vagrant@127.0.0.1`登陆客户机。

### 清理并优化Box体积

#### 删除Ubuntu MOTD、Landscape服务和软件更新管理器
Landscape服务可在Ubuntu MOTD（message of the day）欢迎信息中显示服务器性能信息，会增加启动时间，没有太多意义。
软件更新管理器对于Box来说也没什么用。
可以通过下列命令删除：`sudo apt-get remove landscape-client landscape-common update-notifier-common update-manager-core`

#### 删除不需要的包
使用`sudo apt-get -y autoremove`删除为了满足其他软件包的依赖而安装的、但现在不再需要的安装包
使用`sudo apt-get clean`删除包缓存中的所有安装包。

#### 删除临时文件、登陆信息和命令历史
通过last或lastb可以看到以往的登陆历史，通过history可以看到命令历史。
以root账户登录，执行清除：
```
rm -rf /tmp/*
echo >/var/log/wtmp
echo >/var/log/btmp
history -c
```

### 创建Vagrant Box包

创建Vagrant Box包为：`vagrant package --base <virtual machine name>`，其中虚拟机名为最开始设置的虚拟机名，也可以通过`VBoxManage list vms`命令查询。![vagrantbox-listVMs](/images/2019/1/vagrantbox-listVMs.png)
在宿主机执行下列命令创建Box包：`vagrant package --base "mryqu-ubuntu" --output mryqu-ubuntu_0.1.0.box` 
![vagrantbox-createBox](/images/2019/1/vagrantbox-createBox.png)

### 测试

通过`vagrant box add 'mryqu-ubuntu' /c/quTemp/mryqu-ubuntu_0.1.0.box`添加Box：![vagrantbox-addBox](/images/2019/1/vagrantbox-addBox.png)
通过`vagrant init`创建vagrantfile，然后将vagrantfile中的config.vm.box改为'mryqu-ubuntu'，最后通过`vagrant up`启动Box：![vagrantbox-addBox](/images/2019/1/vagrantbox-upBox.png)

### 参考

[Vagrant Boxes: Creating a Base Box](https://www.vagrantup.com/docs/boxes/base.html)  
[Vagrant Provider VirtualBox: Creating a Base Box](https://www.vagrantup.com/docs/virtualbox/boxes.html)  
[How to Create and Share a Vagrant Base Box](https://www.sitepoint.com/create-share-vagrant-base-box/)  
