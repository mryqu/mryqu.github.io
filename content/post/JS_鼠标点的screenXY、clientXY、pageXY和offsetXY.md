---
title: '[JS] 鼠标点的screenX/Y、clientX/Y、pageX/Y和offsetX/Y'
date: 2018-01-09 05:55:33
categories: 
- 前端
tags: 
- javascript
- mousepoint
- screen
- client
- page
---

### 理解

* clientX/Y：鼠标点相对浏览器窗口内容区域（viewport）左上角的偏移量。  
  桌面浏览器基本支持，移动浏览器有可能不支持。
* pageX/Y：鼠标点相对浏览器所有渲染内容区域（viewport）左上角的偏移量。(滚动后，文档左上角有可能不在浏览器窗口中，仍旧从文档左上角算起)  
  ![MousePoint](/images/2018/01/MousePoint_PageAndClient.png)
  桌面浏览器基本支持，移动浏览器有可能不支持。
* screenX/Y：鼠标点相对物理显示器左上角的偏移量。  
  当浏览器换了位置或屏幕分辨率改了，即使clientX/Y不变，screenX/Y值都有可能变动。  
  桌面和移动浏览器都基本支持。
* offsetX/offsetY：鼠标点相对事件目标左上角的偏移量。  
  实验性质技术，桌面浏览器基本支持，移动浏览器有可能不支持。

### 代码示例

![MousePoint Code](/images/2018/01/MousePoint_code.png)

### 测试

![MousePoint Test](/images/2018/01/MousePoint_test.png)
做了两次测试：第一次测试没有滚动浏览器，第二次测试滚动了浏览器。  
两次点击的clientY都是22；  
两次点击的screenY都是225；  
两次点击的pageY分别是22和428（整个文档渲染区域左上角滚动后没有出现在浏览器内）；  
两次点击的offsetY分别是6和413（段落渲染区域左上角滚动后没有出现在浏览器内）。

### 参考
*****
[What is the difference between screenX/Y, clientX/Y and pageX/Y?](https://stackoverflow.com/questions/6073505/what-is-the-difference-between-screenx-y-clientx-y-and-pagex-y)  
[getMousePosition.js](https://gist.github.com/branneman/fc66785c082099298955)  
[MDN: MouseEvent.screenX](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX)  
[MDN: MouseEvent.clientX](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX)  
[MDN: MouseEvent.pageX](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX)  
[MDN: MouseEvent.offsetX](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX)  





