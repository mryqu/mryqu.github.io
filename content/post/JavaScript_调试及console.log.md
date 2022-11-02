---
title: '[JavaScript] 调试及console.log'
date: 2013-12-21 11:49:44
categories: 
- FrontEnd
tags: 
- javascript
- console
- log
- 调试
---
最近玩一下javascipt，在回调里碰到一个问题，需要调试。加入了console.log函数打印日志，在我的chrome浏览器按Ctrl+Shift+J快捷键调出DevTool并显示控制台来查找问题。![javascript: 调试及console.log](/images/2013/12/0026uWfMgy6K0PpadIqd6.jpg)
结合Wireshark，最后才发现对Json数据解析错误。![javascript: 调试及console.log](/images/2013/12/0026uWfMgy6K0Tsvyifdb.jpg)

下面介绍一下console.log的使用。javascript的代码示例如下：
```
$(function () {
    $('#fileupload').fileupload({
        url: url,
        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('').text(file.name).appendTo('#files');
            });
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            console.log("complete:"+progress);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});
```

## 浏览器控制台使用

### Firefox

[http://getfirebug.com/](http://getfirebug.com/) (可以使用Firefox内建的开发工具Ctrl+Shift+J (Tools > Web Developer >Error Console)，但是Firebug更出色；建议使用Firebug)

### Safari和Chrome

使用方法基本相同。
[https://developer.chrome.com/devtools/index](https://developer.chrome.com/devtools/index)
[ https://developer.apple.com/technologies/safari/developer-tools.html](https://developer.apple.com/technologies/safari/developer-tools.html)

### Internet Explorer

不要忘了在IE9或IE10中调试IE7和IE8时使用兼容模式。
[ http://msdn.microsoft.com/en-us/library/ie/gg589507(v=vs.85).aspx](http://msdn.microsoft.com/en-us/library/ie/gg589507(v=vs.85).aspx)
[http://msdn.microsoft.com/en-us/library/dd565628(v=vs.85).aspx](http://msdn.microsoft.com/en-us/library/dd565628(v=vs.85).aspx)
如果必须访问IE6或IE7的控制台时使用Firebug Lite功能性书签
[http://getfirebug.com/firebuglite/](http://getfirebug.com/firebuglite/) 查找稳定版功能性书签
[http://en.wikipedia.org/wiki/Bookmarklet](http://en.wikipedia.org/wiki/Bookmarklet)

### Opera

[http://www.opera.com/dragonfly/](http://www.opera.com/dragonfly/)

### iOS

对所有iPhones、iPod touch和iPads适用。
[http://developer.apple.com/library/ios/ipad/#DOCUMENTATION/AppleApplications/Reference/SafariWebContent/DebuggingSafarioniPhoneContent/DebuggingSafarioniPhoneContent.html](http://developer.apple.com/library/ios/ipad/#DOCUMENTATION/AppleApplications/Reference/SafariWebContent/DebuggingSafarioniPhoneContent/DebuggingSafarioniPhoneContent.html)
使用iOS 6，如果将设备插入OS X时，可以通过OSX的Safari浏览器看到控制台。或者可以通过仿真器，打开Safari浏览器窗口并点击"Develop"标签，之后设置选项获得与设备通信的Safari的诊断工具。

### Windows Phone、Android

这两类设备都没有内建控制台，也没有功能性书签。可以使用[http://jsconsole.com/](http://jsconsole.com/) type:listen，它会提供植入你HTML代码的脚本标签，之后就可以在jsconsole网站看到你的控制台了。 

### iOS和Android

可以通过[http://html.adobe.com/edge/inspect/](http://html.adobe.com/edge/inspect/)访问Web诊断工具及其在设备上安装的浏览器插件的控制台。

## 老浏览器问题

如果在代码中使用console.log但没有打开开发者工具时，一些老的浏览器(如微软的老版本IE)会崩溃。可以通过下面的代码避免这一问题:
```
 if(!window.console){ window.console = {log: function(){} }; }
```

## 参考

http://stackoverflow.com/questions/4539253/what-is-console-log  
[#javascript: console lesser known features.](https://medium.com/@c2c/javascript-console-lesser-known-features-9fe3852ce48b)  