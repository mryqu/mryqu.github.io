---
title: '[CSS] 判断一条CSS样式规则的覆盖者'
date: 2016-01-14 05:48:14
categories: 
- FrontEnd
tags: 
- css
- rule
- override
- chrome
- elementinspector
---
最近项目中有个OpenUI5控件显示缺少左填充，可它在公司的演示项目中却是正常的。接着发现.sasUiWndSectionCont是决定进行填充CSS规则。可是怎么在我的项目中就不成了呢？
调试过程如下：
- 打开Chrome开发者工具，选择元素检测器（ElementInspector），选择计算后样式（Computed）标签页，鼠标移动到感兴趣的左填充上（padding-left），点击圆圈图标查看详细内容![[CSS] 判断一条CSS样式规则的覆盖者](/images/2016/1/0026uWfMzy73f2e61uZ35.png)
- 跳到样式标签页后发现VDB项目下的.sasUiWndSectionCont定义覆盖了htmlcommons的。![[CSS] 判断一条CSS样式规则的覆盖者](/images/2016/1/0026uWfMzy73f2btinoba.jpg)

**定位成功!**
