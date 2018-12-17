---
title: 'Xming使用笔记'
date: 2013-10-21 20:20:36
categories: 
- Tool
tags: 
- xming
---
XWindow系统里有一个统一的Server来负责各个程序与显示器、键盘和鼠标等输入输出设备的交互，每个有GUI的应用程序都通过网络协议与Server进行交互。所以对于任何一个应用程序，本地运行和远程运行的差别仅仅是XServer的地址不同，别的没有差别。所以在Windows运行一个XServer，就可以很方便的远程运行有GUI的Linux应用了。
Xming是一个在Microsoft Windows操作系统上运行XWindow系统的服务器。它非常简单易用，搭配强大。一般搭配putty的下列配置，就可以在Windows平台上远程运行有GUI的Linux应用了：
```
Connection-SSH-X11-Enable X11 forwarding
```

Xming操作笔记如下：
- **选择单词**：双击鼠标左键
- **选择一行**：三击鼠标左键
- **选择特定文本**：鼠标左键点击文本起点，然后按住鼠标右键选择。
- **复制文本**：Alt + Shift + C