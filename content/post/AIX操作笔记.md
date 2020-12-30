---
title: 'AIX操作笔记'
date: 2020-12-23 12:31:23
categories: 
- Tool
- Linux
tags: 
- AIX

---

### 查看版本

TL（Technical Level）指 AIX 操作系统的技术版本（以前称为 ML, Maintenance Level），包括硬件、软件的新功能和传统的补丁。  
SP( Service Pack) 指服务补丁版本，包括一些不能等到下一个TL推出的关键的补丁及非常有限的新硬件驱动。  

```
$ oslevel -s
7100-04-04-1717
```

上例中oslevel -s显示结果为7100-04-04-1717，头四位系统版本，接下来两位为技术版本，之后两位为补丁版本，最后4位，前2位标识年份，后2位表示周。  
7100-04-04-1717表示AIX7.1 TL版本04，SP版本04，这个版本是在2017年第17周进行的更新。  


### 安装软件

在ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/ 查找到所需软件的链接，然后通过rpm进行安装。例如：  
```
rpm -Uvh ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/curl/curl-7.9.3-2.aix4.3.ppc.rpm
```

