---
title: '在Ubuntu中强制Apt-get使用IPv4或IPv6'
date: 2015-05-18 06:14:43
categories: 
- Tool
- Linux
tags: 
- ubuntu
- debian
- apt-get
- ipv4
- ipv6
---
### 快速命令行选项

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

### 持久化的选项

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
