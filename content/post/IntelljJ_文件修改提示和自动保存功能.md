---
title: '[IntelljJ] 文件修改提示和自动保存功能'
date: 2014-12-14 15:22:51
categories: 
- Tool
- IntelliJ
tags: 
- intellij
- idea
- 修改提示
- 自动保存
- eclipse
---
Eclipse中文件修改后没有保存前文件都会有星号提示，IntelljJ IDEA默认没有提示，但是可以通过如下设置完成：Settings -> Editor -> General -> Editor Tabs: Check "Markmodified tabs with asterisk"![[IntelljJ] 文件修改提示和自动保存功能](/images/2014/12/0026uWfMgy6Rq6lUnLqa8.jpg)IntelljJ IDEA关于文件自动保存功能主要有两种方式：
- 切换到其他应用时保存变化（默认使能）设置路径：Settings -> Apperance & Behavior -> Save files onframe deactivation
- 如果应用空闲则自动保存变化（默认禁止）设置路径：Settings -> Apperance & Behavior -> Save filesautomatically if application is idle for ... sec.![[IntelljJ] 文件修改提示和自动保存功能](/images/2014/12/0026uWfMgy6Rq6Pzq5z19.jpg)