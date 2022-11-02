---
title: '[AWS] 学习AWS上SAS联合账户的使用'
date: 2018-04-18 06:11:04
categories: 
- Cloud
tags: 
- aws
- ec2
---
今天顺利学完《SAS Federated Accounts on Amazon Web Services》课程，测验全都答/蒙对了。
1. 创建了EC2实例。  
   ![aws](/images/2018/04/aws.jpg)
2. 第一次用[MobaXterm](https://mobaxterm.mobatek.net/)。相对Putty，省了将.pem SSH密钥通过[PuTTYgen](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)工具转换成.ppk格式这一步操作。
   ![MobaXterm](/images/2018/04/MobaXterm.jpg)
3. 在/etc/resolv.conf文件中增加了几个nameserver以指定单位的DNS，在search项增加了多个域名以解析单位的机器名。  
4. 安装libXext.x86_64、libXp.x86_64、libXtst.x86_64、xorg-x11-xauth.x86_64、xorg-x11-apps等包以支持图形显示。

