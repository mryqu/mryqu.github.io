---
title: 'Linux包管理速查表'
date: 2013-10-18 20:14:05
categories: 
- Tool
- Linux
tags: 
- linux
- apt
- yum
- zypper
- package
---
### 管理软件包

|**任务**|apt (deb)|yum (rpm)|zypper (rpm)
|-----
|**通过仓库安装软件包**|apt-get install {pkg}|yum install {pkg}|zypper install {pkg}
|**更新软件包**|apt-get install {pkg}|yum update {pkg}|zypper update -t package {pkg}
|**移除软件包**|apt-get remove {pkg}|yum erase {pkg}|zypper remove {pkg}
|**通过文件安装软件包**|dpkg -i {pkg}|yum localinstall {pkg}|zypper install {pkg}


### 搜索软件包

|**任务**|**apt (deb)**|**yum (rpm)**|**zypper (rpm)**
|-----
|**通过包名搜索**|apt-cache search {pkg}|yum list {pkg}|zypper search {pkg}
|**通过模式搜索**|apt-cache search pattern|yum search pattern|zypper search -t pattern pattern
|**通过文件名搜索**|apt-file search path|yum provides file|zypper wp file
|**列举已安装软件包**|dpkg -l|rpm -qa|zypper search -is
|**显示软件包信息**|apt-cache show pgk-name|yum info {pkg}|zypper info {pkg}


### 更新系统

|**任务**|**apt (deb)**|**yum (rpm)**|**zypper (rpm)**
|-----
|**更新软件包列表**|apt-get update|yum check-update|zypper refresh
|**更新系统**|apt-get upgrade|yum update|zypper update


### 软件仓库

|**任务**|**apt (deb)**|**yum (rpm)**|**zypper (rpm)**
|-----
|**列举仓库**|cat /etc/apt/sources.list|yum repolist|zypper repos
|**添加仓库**|_edit_ /etc/apt/sources.list|_add to_ /etc/yum.repos.d/|zypper addrepo URI name
|**移除仓库**|_edit_ /etc/apt/sources.list|_remove from_ /etc/yum.repos.d/|zypper removerepo name

英文原文：[Linux Package Management Cheatsheet](http://danilodellaquila.com/blog/linux-package-management-cheatsheet)