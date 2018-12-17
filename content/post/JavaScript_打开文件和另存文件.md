---
title: '[JavaScript] Open/SaveAs File'
date: 2015-01-31 12:42:22
categories: 
- 前端
tags: 
- web
- html5
- javascript
- file
- save
---
看了一下HTML5应用中如何打开文件或另存文件。与Swing/EclipseRCP应用不同，有些操作由于安全的原因无法在HTML5应用内使用，而是浏览器与客户交互。例如HTML5应用往本地写文件。下面的显示了在新窗口打开文件、在当前窗口打开文件以及a标签的download属性。 ![Javascript：Open/SaveAs File](/images/2015/1/0026uWfMgy6PEVvTIER2d.jpg)学习了下面链接中的代码和文章，其中FileSaver.js是一个跨浏览器的JS库，但是在各个浏览器上保存文件的用户体验却不相同。目前为止，我还没发现更好的跨浏览器/设备的另存文件解决方案。
[Google HTML5 Download Demo](http://html5-demos.appspot.com/static/a.download.html)  
[An HTML5 saveAs() FileSaver implementation](https://github.com/eligrey/FileSaver.js)  
[New HTML5 Attributes for Hyperlinks: download, media, and ping](http://www.sitepoint.com/new-html5-attributes-hyperlinks-download-media-ping/)  
[Save files on disk using JavaScript or JQuery!](http://muaz-khan.blogspot.com.au/2012/10/save-files-on-disk-using-javascript-or.html)  
[JavaScript Question:Opening Save As Dialog](http://www.experts-exchange.com/Programming/Languages/Scripting/JavaScript/Q_21262729.html)  
[Internet media type](http://en.wikipedia.org/wiki/Internet_media_type)  