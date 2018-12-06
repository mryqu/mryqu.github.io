---
title: '在Ubuntu Linux上安装netstat'
date: 2014-01-01 13:52:23
categories: 
- Tool
- Linux
tags: 
- apt-get
- ubuntu
- linux
- netstat
- install
---
在UbuntuLinux上安装netstat，apt-get其实是找不到netstat包的，需要用apt-get安装[net-tools](http://sourceforge.net/projects/net-tools/)。[net-tools](http://sourceforge.net/projects/net-tools/)是Linux平台NET-3网络分发包，包括arp、hostname、ifconfig、netstat、rarp、route、plipconfig、slattach、mii-tool、iptunnel和ipmaddr工具。
```
apt-get install net-tools
```
