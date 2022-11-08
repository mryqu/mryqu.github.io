---
title: 'Ubuntu操作笔记'
date: 2013-08-05 22:49:19
categories: 
- Tool
- Linux
tags: 
- ubuntu
- linux
- hostname
- netstat
- ip
- ipv4
- ipv6
- rpm
---

### 在Ubuntu上修改主机名 (2013-08-05)

#### 显示主机名
```
hostname -s
```
更多细节见[hostname](http://manpages.ubuntu.com/manpages/xenial/en/man1/hostname.1.html)帮助文档。

#### 修改主机名

```
sudo hostname your-new-name
# Ubuntu专有
hostnamectl set-hostname new-hostname
```
更多细节见[hostnamectl](http://manpages.ubuntu.com/manpages/xenial/en/man1/hostnamectl.1.html)帮助文档。
上述命令重启服务器后失效。

#### 修改主机名配置

```
sudo -H vi /etc/hostname
sudo -H vi /etc/hosts
```

### Ubuntu下显示本机IP (2013-10-20)

命令为：ip addr show
感觉比ifconfig eth0更通用些！

### 在Ubuntu Linux上安装netstat (2014-01-01)

在UbuntuLinux上安装netstat，apt-get其实是找不到netstat包的，需要用apt-get安装[net-tools](http://sourceforge.net/projects/net-tools/) 。[net-tools](http://sourceforge.net/projects/net-tools/) 是Linux平台NET-3网络分发包，包括arp、hostname、ifconfig、netstat、rarp、route、plipconfig、slattach、mii-tool、iptunnel和ipmaddr工具。
```
apt-get install net-tools
```

### 在Ubuntu中禁掉IPv6 (2015-03-20)

为了禁止掉IPv6，需要在/etc/sysctl.conf做如下修改：
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

如果IPv6仍没有禁掉，是由于sysctl.conf没有激活造成的。为了解决上述问题，执行下面的命令：
```
sudo sysctl -p
```

之后，运行:
```
$ cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

它将返回1，这表示IPv6被成功禁止掉。
![在Ubuntu中禁掉IPv6](/images/2015/3/0026uWfMzy77TWiBwcr7b.png)  

### 在Ubuntu中强制Apt-get使用IPv4或IPv6 (2015-05-18)

#### 快速命令行选项

如果只想一次使apt-get使用IPv4或IPv6，使用下列步骤。该功能尽在`apt-get`的`0.9.7.9~exp1`版本后可用。首先，通过如下命令确认`apt-get`版本高于`0.9.7.9~exp1`：
```
apt-get --version
```

结果近似于:
```
apt 1.0.1ubuntu2 for amd64 compiled on Oct 28 2014 20:55:14
```

版本核实后，可以通过如下命令强制使用IPv4:
```
apt-get -o Acquire::ForceIPv4=true update
```

或IPv6:
```
apt-get -o Acquire::ForceIPv6=true update
```

这会将_sources.list_中的URL仅解析成IPv4并更新仓库。

#### 持久化的选项

为了让设置持久化，在`/etc/apt/apt.conf.d/`下创建`99force-ipv4`文件。
```
sudoedit /etc/apt/apt.conf.d/99force-ipv4
```

在该文件放入如下内容：
```
Acquire::ForceIPv4 "true";
```

保存文件即可。如果相反想强制使用IPv6，将文件名及其内容中的**4**改成**6**即可。  
原文: https://www.vultr.com/docs/force-apt-get-to-ipv4-or-ipv6-on-ubuntu-or-debian  

### 在Ubuntu中安装rpm包 (2015-08-07)

RPM(RPM Package Manager，原Red Hat PackageManager)是基于RedHat的Linux分发版的包管理系统，用于rpm包的管理（诸如安装、卸载、升级等），其原始设计理念是开放式的，现在包括OpenLinux、Mandrake、SuSE以及TurboLinux等Linux分发版都有采用。
APT软件管理系统是Debian 系统(包含Debian和 Ubuntu)的包管理系统，用于deb包的的管理（诸如安装、卸载、升级等）。deb格式是Debian系统专属安装包格式，进入2.x时代之后由Cydia作者JayFreeman（saurik）将其与APT软件管理系统一起移植到iPhone平台上。
Alien是一个将不同Linux包分发文件转换成deb的程序，支持Linux标准规范, RPM、deb、Stampede(.slp)和Slackware (tgz)包之间的转换。
Alien工具安装： 在Ubuntu下，alien已经添加在源中,可以使用`sudo apt-get install alien`命令进行安装。

Alien使用：  

- **rpm转deb**：`sudo alien --script (filename).rpm`  
- **Debian系统直接安装rpm**：`sudo alien -i --script(filename).rpm`  
- **deb转rpm**：`sudo alien --to-rpm (filename).deb`  
- **tar.gz转deb**：`sudo alien -k (filename).tar.gz`  
- **tar.bz2转deb**：`sudo alien -d (filename).tar.bz2`  
- **tgz转deb**：`sudo alien --to-deb ~/(filename).tgz`  

由于Teradata数据库的安装文件仅支持Redhat、SUSE和IBM s390xLinux，而我的docker容器是基于Debian系统的，所以今天尝试了一下Alien。但是效果不佳：ttu14中的rpm可以转换成deb，但是直接安装失败；ttu15中的rpm直接安装失败，但是转换deb失败。

### 在Ubuntu中识别当前Init系统 (2016-08-05)  

#### Ubuntu 14.04

首先用uname命令查看一下系统信息：
```
ubuntu@node50069:~$ uname -a
Linux node50069 3.19.0-25-generic #26~14.04.1-Ubuntu SMP Fri Jul 24 21:16:20 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
```

用pstree命令查看一下ID为1的进程，原来是init：
![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy759cAy8UU58.png) 

可以下面几个命令查看init进程所用的命令信息：
- ps -efa|grep init
- type init
- sudo stat /proc/1/exe

最终通过"sudo init --version"可知当前的Init系统为upstart：
![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy759d8PJcKd2.jpg)

#### Ubuntu 15.04

首先查看一下系统信息：
```
vagrant@vagrant-ubuntu-trusty:~$ uname -a
Linux vagrant-ubuntu-trusty 3.19.0-15-generic #15-Ubuntu SMP Thu Apr 16 23:32:37 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
```
用pstree命令查看一下ID为1的进程，原来是systemd：
![在Ubuntu中识别当前Init系统](/images/2016/8/0026uWfMzy75azKHvSWf2.jpg)

#### 参考

[WIKI：init](https://zh.wikipedia.org/zh-cn/Init)    

