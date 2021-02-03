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

### 软件差异  

#### sed不支持\s  

解决方法：使用空格和Tab代替。  

#### find不支持maxdepth

解决方法：通过find {dir} ! -path {dir} -prune -type f -name {filemask}不进行递归遍历。  
```
$ find . -name "*.ksh"
./codecheck.ksh
./inventory.ksh
./lib/logging.ksh
./lib/utility.ksh
./lib/validation.ksh
./lib/versioninfo.ksh
./profile.ksh
./publish.ksh
$ find . ! -path . -prune -type f -name "*.ksh"
./codecheck.ksh
./inventory.ksh
./profile.ksh
./publish.ksh
```

#### tr在utf8环境有问题

解决办法：不适用tr进行字符串的大小写转换，改用typeset
```
$ export LANG=en_US.UTF-8
$ export LC_ALL=en_US.UTF-8
$ val=$(echo dbcs | tr '[a-z]' '[A-Z]');if [ "$val" != "DBCS" ]; then echo "$val"; fi
ⅾBⅽS
$ typeset -u val="dbcs";if [ "$val" != "DBCS" ]; then echo "$val"; fi

```
#### date跟Linux上的GNU date功能较少

* 缺少-d参数，无法通过时间字符串进行操作，仅能对当前时间进行操作；  
* 缺少-r参数，无法查看文件的修改时间；  

GNU date使用：  
```
mryquLAX> date -u -d @0
Thu Jan  1 00:00:00 UTC 1970
mryquLAX> date -u -d "Thu Jan  1 00:00:00 UTC 1970" "+%s"
0
mryquLAX> date -u -d "Jan  1 00:00:00 UTC 0001" "+%s"
-62135596800
mryquLAX> date -r codecheck.ksh
Tue Jan  5 02:16:01 EST 2021
mryquLAX> date -r codecheck.ksh "+%s"
1609830961
```