---
title: 'HTML Busy Indicator'
date: 2015-01-04 20:13:28
categories: 
- 前端
tags: 
- busy.indicator
- html
- openui5
- bootstrap
- jquery
---
看了一下OpenUI5的LocalBusyIndicator效果，感觉跟自己想的转圈圈的那种spinner不一样:https://sapui5.hana.ondemand.com/sdk/test-resources/sap/ui/core/demokit/LocalBusyIndicator.html
![HTML Busy Indicator](/images/2015/1/0026uWfMgy6OWyrH1J789.jpg)
想看看bootstrap的busy indicator，竟然没有，不过找到了开发组的讨论：https://github.com/twbs/bootstrap/issues/12598 不止一次有人建议开发busy indicator，不过Mark Otto（Bootstrap是Mark Otto和JacobThornton共同开发的）没同意。因为满足不了下列条件：
- It needs to be retina-ready
- Needs to work in IE8+
- Needs to work on light backgrounds and dark—alphatransparencywould be bomb
- Would be cool if it was a font, but PNG or GIF is fine,too
- Available in multiple sizes

开发一款满意的控件容易吗！！！还好我就用用而已
下面是我找到的一些Busy Indicator资源：
http://fgnass.github.io/spin.js/  
http://semantic-ui.com/elements/loader.html  
http://w3lessons.info/2014/01/26/showing-busy-loading-indicator-during-an-ajax-request-using-jquery/  