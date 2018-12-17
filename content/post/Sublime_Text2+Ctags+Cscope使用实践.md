---
title: 'Sublime Text2+Ctags+Cscope使用实践'
date: 2015-12-09 07:07:45
categories: 
- Tool
- C++
tags: 
- sublime
- ctags
- cscope
- C++
---
### 安装

#### 安装Package Control
步骤见[https://packagecontrol.io/installation#st2](https://packagecontrol.io/installation#st2)

#### 安装CTags插件
- 通过 Preference -> Package Control -> InstallPackage安装Ctags插件（快捷键Ctrl+Shift+P，输入install）![Sublime Text2+Ctags+Cscope使用实践](/images/2015/12/0026uWfMgy71ddMtNSZ4d.jpg)
- 打开Preference -> Package Settings -> Ctags ->Settings-Default和Setting-User，将Settings-Default中的内容拷贝到Setting-User中，将"command": "" 中的 "" 填入Ctags.exe的路径位置
- 打开C工程根目录，在上点击右键，选择Ctags:Rebuild tags![Sublime Text2+Ctags+Cscope使用实践](/images/2015/12/0026uWfMgy71dei8odx87.png)

#### 安装Cscope插件
- 同样通过 Preference -> Package Control -> InstallPackage安装Cscope插件（快捷键Ctrl+Shift+P，输入install）
- 通过cscope –Rb在C工程根目录创建cscope.out文件
- Cscope在ST2上没有包配置菜单，需要打开CscopeSublime.sublime-settings文件(我的机器在C:/Users/yqu/AppData/Roaming/SublimeText 2/Packages/Cscope目录下)，将 "executable": "" 中的 ""填入Cscope.exe的路径位置,将 "database_location": "" 中的""填入cscope.out的路径位置。

### 使用

#### [CTags命令](https://github.com/SublimeText/CTags#commands-listing)

|Command|Key Binding|Alt Binding|Mouse Binding
|-----
|rebuild_ctags|ctrl+t, ctrl+r| &nbsp; | &nbsp;
|navigate_to_definition|ctrl+t, ctrl+t|ctrl+>|ctrl+shift+left_click
|jump_prev|ctrl+t, ctrl+b|ctrl+<|ctrl+shift+right_click
|show_symbols|alt+s| &nbsp;| &nbsp;
|show_symbols (all files)|alt+shift+s| &nbsp;| &nbsp;
|show_symbols (suffix)|ctrl+alt+shift+s| &nbsp;| &nbsp;

#### Cscope命令

- Ctrl + \ - Show Cscope options![Sublime Text2+Ctags+Cscope使用实践](/images/2015/12/0026uWfMgy71dj5dhrB3b.png)
- Ctrl + L , Ctrl + S - Look up symbol undercursor
- Ctrl + L , Ctrl + D - Look up definition undercursor
- Ctrl + L , Ctrl + E - Look up functions calledby the function under the cursor
- Ctrl + L , Ctrl + R - Look up functionscalling the function under the cursor
- Ctrl + Shift + [ - Jump back
- Ctrl + Shift + ] - Jump forward

#### 其他快捷键

- Ctrl + p - 快速定位项目中的文件
- Ctrl + R - 获取当前文件中的函数列表（# 和 @分别为变量和函数），这个功能也使得ST2不需要taglist插件了。

### 参考

[使用Sublime Text3+Ctags+Cscope替代Source Insight](https://www.zybuluo.com/lanxinyuchs/note/33551)    
[Exuberant Ctags笔记](/post/exuberant_ctags笔记)    
[Cscope笔记](/post/cscope笔记)    