---
title: '接触字体图标(Icon Font)'
date: 2014-12-09 19:47:38
categories: 
- FrontEnd
tags: 
- icon
- font
- html
- 字体图标
---
最近玩SAP的OpenUI5，碰到了sap-icon://协议，接触了字体图标。
字体图标流行了有两年了，现在已经不是什么新鲜概念啦。主要是因为 CSS3 增加了一个非常实用的属性@font-face。传统的网页中的字体设置，使用font-family属性来定义，而且受限于浏览者电脑上所安装的字体，如果浏览者电脑上没有安装对应字体，那么网页渲染起来就会使用其他字体来代替。而新增的@font-face改变了这一现状，使用该属性，可以指定服务器上的一个字体，当浏览者访问的时候，会优先下载服务器上的字体，然后再使用该字体渲染网页。这样就可以发挥设计师的想象，灵活的任意应用字体，同时不需要考虑不同平台的差异。该属性的兼容性也非常好。详细兼容性见http://caniuse.com/#feat=fontface 。
![接触字体图标(Icon Font)](/images/2014/12/0026uWfMgy6OgF72oQV71.jpg)
@font-face功能不仅仅可以用在改变文章的字体样式上，还可以来做字体图标。字体其实就是一种图标，把对应的基础的文字，渲染成有棱有角的文字。如果某个文字的字体，并不设计成那个文字的变形，而设计成截然不同的图标，那么当网页中出现这个文字，就会渲染出一个图标。

### 字体图标与像素位图的对比

优点：
- 兼容性：各个平台浏览器基本都可以使用，而且在某些老版本浏览器中，效果比图片更好。
- 轻量性：相对于同效果的位图相比，体积要小。一旦图标字体加载了，图标就会马上渲染出来，不需要下载一个图像。可以减少HTTP请求，增强前端性能，还可以配合HTML5离线存储做性能优化。
- 灵活性：图标字体可以用过font-size属性设置其任何大小，还可以加各种文字效果，包括颜色、Hover状态、透明度、阴影和翻转等效果。可以在任何背景下显示。使用位图的话，必须得为每个不同大小和不同效果的图像输出一个不同文件。

劣势：
- 图标字体只能被渲染成单色或者CSS3的渐变色。
- 免费开源的精美字体图标资源还是不够多。
- 创作自已的字体图标很费时间，重构人员后期维护的成本偏高。

### 常用字库文件格式

- TTF(TrueTypeFont)格式：TTF是Apple公司和Microsoft公司推出的字体文件格式,随着windows的流行,已经变成最常用的一种字体文件表示方式。truetype字体的最大优点是可以很方便地把字体轮廓转换成曲线，可以对曲线进行填充，制成各种颜色和效果，字款丰富。
- OTF(OpenType Font)格式：OpenType，是一种可缩放字型（scalablefont），微软公司与Adobe公司联合开发，用来替代TrueType字型的新字型。
- WOFF格式：Web开放字体格式（Web Open FontFormat，简称WOFF），是一种网页所采用的字体格式标准。此字体格式不但能够有效利用压缩来减少档案大小，并且不包含加密。WOFF得到许多主要字体制造公司的支持。
- EOT格式：EOT是一种压缩字库，目的是解决在网页中嵌入特殊字体的难题。例如：网页前端开发人员在网页中使用了很多种特殊的精美的字体，当网友浏览时，却因没有安装相应的字库，只能看到默认的宋体字，效果惨不忍睹。利用EOT字库即可解决此难题。

### 网上一些字体图标资源
[OpenUI5 Icon Explorer](https://openui5.hana.ondemand.com/test-resources/sap/m/demokit/icon-explorer/index.html)  
[confont.cn：由阿里巴巴UX部门推出的矢量图标管理网站，也是国内首家推广Webfont形式图标的平台。](http://www.iconfont.cn/)  
[Font Awesome：An iconic font and CSS framework project at GitHub](https://github.com/FortAwesome/Font-Awesome)  

### 在OpenUI5里使用字体图标
SAPUI5提供了sap.ui.core.icon控件和sap.ui.core.IconPool力提供的一套预定义图标。通过学习https://github.com/SAP/openui5/blob/master/src/sap.ui.core/src/sap/ui/core/IconPool.js ，大致可以找到OpenUI5里的字体库。
```
/resources/sap/ui/core/themes/base/fonts/SAP-icons.eot
/resources/sap/ui/core/themes/base/fonts/SAP-icons.ttf
/resources/sap/ui/core/themes/sap_bluecrystal/fonts/bluecrystal_icons.ttf
/resources/sap/ui/core/themes/sap_bluecrystal/fonts/SAP-icons.eot
/resources/sap/ui/core/themes/sap_bluecrystal/fonts/SAP-icons.ttf
/resources/sap/ui/core/themes/sap_goldreflection/fonts/SAP-icons.eot
/resources/sap/ui/core/themes/sap_goldreflection/fonts/SAP-icons.ttf
/resources/sap/ui/core/themes/sap_hcb/fonts/SAP-icons.eot
/resources/sap/ui/core/themes/sap_hcb/fonts/SAP-icons.ttf
```