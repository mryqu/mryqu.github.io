---
title: '[Vagrant]学习VBoxManage定制'
date: 2018-07-26 05:56:21
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- virtualbox
- vboxmanage
- nat
- cpu
---

[Vagrant Configuration - VBoxManage Customizations](https://www.vagrantup.com/docs/virtualbox/configuration.html#vboxmanage-customizations)里面有讲到通过VBoxManage修改VirtualBox虚拟机。而[VBoxManage modifyvm](https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm)里面细致的介绍了所有设置。
# VBoxManage modifyvm设置

## 接触过的VBoxManage modifyvm设置
下面就仔细研究一下我看到过的modifyvm设置：
```
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.3"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    # --memory设置用来指定分配的内存，单位为MB
    # 可简写为vb.memory=8192
    vb.customize ['modifyvm', :id, '--memory', '8192']
    
    # --cpus设置用来指定虚拟机的虚拟CPU个数
    # 可简写为vb.cpus=3
    vb.customize ['modifyvm', :id, '--cpus', '3']
    
    # --cpuexecutioncap <1-100>设置用来指定虚拟CPU可用的CPU时间比例。
    # 值50意味无论VM使用多少个虚拟虚拟CPU，都不会超过宿主机CPU时间的一半。
    vb.customize ['modifyvm', :id, '--cpuexecutioncap', '75']
        
    # --natdnshostresolver<1-N> on|off用来指定NAT使用宿主机的解析机制处理DNS请求。
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    
    # --natdnsproxy<1-N> on|off用来指定NAT将所有客户机DNS请求代理到宿主机的DNS服务器。
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    
    # --ostype设置指定客户机OS类型
    # 可用值详见下面的modifyvm --ostype选项
    vb.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
    
    # --acpi on|off设置VM是否支持ACPI
    # --ioapic on|off设置VM是否支持I/O ACPI
    vb.customize ['modifyvm', :id, '--ioapic', 'on']  # Bug 51473|
    
    # --cableconnected<1-N> on|off设置可用于临时断开虚拟网接口，效果类似于从网卡上拔出
    # 网线。该设置有可能用于复位VM内的某些软件模块。
    # VirtualBox的某些版本 (5.1.x)似乎将NAT接口启动为断开状态，因此需要显性连接上。
    # 见https://github.com/mitchellh/vagrant/issues/7648
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']

    # 防止时钟偏移，例如Vagrant box停止15分钟后重启，VM内部时间为15分钟。
    # 见http://stackoverflow.com/a/19492466/323407
    vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 10000]
    
    # 预以图形模式启动VM，则去掉下一行的注释：
    # vb.gui = true
  end
  ......
end
```

## modifyvm --ostype选项

```
C:>\quTools\oracle\VirtualBox\VBoxManage list ostypes
ID:          Other
Description: Other/Unknown
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          Other_64
Description: Other/Unknown (64-bit)
Family ID:   Other
Family Desc: Other
64 bit:      true

ID:          Windows31
Description: Windows 3.1
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows95
Description: Windows 95
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows98
Description: Windows 98
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsMe
Description: Windows ME
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsNT4
Description: Windows NT 4
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows2000
Description: Windows 2000
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsXP
Description: Windows XP (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsXP_64
Description: Windows XP (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows2003
Description: Windows 2003 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows2003_64
Description: Windows 2003 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          WindowsVista
Description: Windows Vista (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsVista_64
Description: Windows Vista (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows2008
Description: Windows 2008 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows2008_64
Description: Windows 2008 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows7
Description: Windows 7 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows7_64
Description: Windows 7 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows8
Description: Windows 8 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows8_64
Description: Windows 8 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows81
Description: Windows 8.1 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows81_64
Description: Windows 8.1 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows2012_64
Description: Windows 2012 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows10
Description: Windows 10 (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          Windows10_64
Description: Windows 10 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Windows2016_64
Description: Windows 2016 (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          WindowsNT
Description: Other Windows (32-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      false

ID:          WindowsNT_64
Description: Other Windows (64-bit)
Family ID:   Windows
Family Desc: Microsoft Windows
64 bit:      true

ID:          Linux22
Description: Linux 2.2
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Linux24
Description: Linux 2.4 (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Linux24_64
Description: Linux 2.4 (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Linux26
Description: Linux 2.6 / 3.x / 4.x (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Linux26_64
Description: Linux 2.6 / 3.x / 4.x (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          ArchLinux
Description: Arch Linux (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          ArchLinux_64
Description: Arch Linux (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Debian
Description: Debian (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Debian_64
Description: Debian (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          OpenSUSE
Description: openSUSE (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          OpenSUSE_64
Description: openSUSE (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Fedora
Description: Fedora (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Fedora_64
Description: Fedora (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Gentoo
Description: Gentoo (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Gentoo_64
Description: Gentoo (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Mandriva
Description: Mandriva (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Mandriva_64
Description: Mandriva (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          RedHat
Description: Red Hat (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          RedHat_64
Description: Red Hat (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Turbolinux
Description: Turbolinux (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Turbolinux_64
Description: Turbolinux (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Ubuntu
Description: Ubuntu (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Ubuntu_64
Description: Ubuntu (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Xandros
Description: Xandros (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Xandros_64
Description: Xandros (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Oracle
Description: Oracle (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Oracle_64
Description: Oracle (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Linux
Description: Other Linux (32-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      false

ID:          Linux_64
Description: Other Linux (64-bit)
Family ID:   Linux
Family Desc: Linux
64 bit:      true

ID:          Solaris
Description: Oracle Solaris 10 5/09 and earlier (32-bit)
Family ID:   Solaris
Family Desc: Solaris
64 bit:      false

ID:          Solaris_64
Description: Oracle Solaris 10 5/09 and earlier (64-bit)
Family ID:   Solaris
Family Desc: Solaris
64 bit:      true

ID:          OpenSolaris
Description: Oracle Solaris 10 10/09 and later (32-bit)
Family ID:   Solaris
Family Desc: Solaris
64 bit:      false

ID:          OpenSolaris_64
Description: Oracle Solaris 10 10/09 and later (64-bit)
Family ID:   Solaris
Family Desc: Solaris
64 bit:      true

ID:          Solaris11_64
Description: Oracle Solaris 11 (64-bit)
Family ID:   Solaris
Family Desc: Solaris
64 bit:      true

ID:          FreeBSD
Description: FreeBSD (32-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      false

ID:          FreeBSD_64
Description: FreeBSD (64-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      true

ID:          OpenBSD
Description: OpenBSD (32-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      false

ID:          OpenBSD_64
Description: OpenBSD (64-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      true

ID:          NetBSD
Description: NetBSD (32-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      false

ID:          NetBSD_64
Description: NetBSD (64-bit)
Family ID:   BSD
Family Desc: BSD
64 bit:      true

ID:          OS2Warp3
Description: OS/2 Warp 3
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          OS2Warp4
Description: OS/2 Warp 4
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          OS2Warp45
Description: OS/2 Warp 4.5
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          OS2eCS
Description: eComStation
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          OS21x
Description: OS/2 1.x
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          OS2
Description: Other OS/2
Family ID:   OS2
Family Desc: IBM OS/2
64 bit:      false

ID:          MacOS
Description: Mac OS X (32-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      false

ID:          MacOS_64
Description: Mac OS X (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS106
Description: Mac OS X 10.6 Snow Leopard (32-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      false

ID:          MacOS106_64
Description: Mac OS X 10.6 Snow Leopard (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS107_64
Description: Mac OS X 10.7 Lion (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS108_64
Description: Mac OS X 10.8 Mountain Lion (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS109_64
Description: Mac OS X 10.9 Mavericks (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS1010_64
Description: Mac OS X 10.10 Yosemite (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS1011_64
Description: Mac OS X 10.11 El Capitan (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS1012_64
Description: macOS 10.12 Sierra (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          MacOS1013_64
Description: macOS 10.13 High Sierra (64-bit)
Family ID:   MacOS
Family Desc: Mac OS X
64 bit:      true

ID:          DOS
Description: DOS
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          Netware
Description: Netware
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          L4
Description: L4
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          QNX
Description: QNX
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          JRockitVE
Description: JRockitVE
Family ID:   Other
Family Desc: Other
64 bit:      false

ID:          VBoxBS_64
Description: VirtualBox Bootsector Test (64-bit)
Family ID:   Other
Family Desc: Other
64 bit:      true
```
