---
title: '在Ubuntu中安装rpm包'
date: 2015-08-07 05:46:42
categories: 
- Tool
- Linux
tags: 
- ubuntu
- rpm
- alien
- apt
---
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
