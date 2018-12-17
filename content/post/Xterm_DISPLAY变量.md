---
title: 'Xterm DISPLAY变量'
date: 2013-10-21 20:49:10
categories: 
- Tool
tags: 
- xterm
- display
---
DISPLAY变量的格式为`[host]:<display>[.screen]`
`host` 指网络主机名，空缺则指本机。
每个主机可以有多个显示，每个显示可以有多个屏幕。因此，DISPLAY=:0通常指本机内的所有GPU，DISPLAY=:0.0指本机内的第一个配置屏幕/GPU，DISPLAY=:0.1指本机内的第二个配置屏幕/GPU。