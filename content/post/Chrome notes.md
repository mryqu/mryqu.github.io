---
title: 'Chrome使用笔记'
date: 2013-10-19 21:15:28
categories: 
- Tool
tags: 
- chrome
---

### 清除Chrome中特定网站的所有历史记录 （2013-10-19）

想要Chrome中特定网站的所有历史记录，可是搜出特定网站的所有历史记录后必须对每一项进行选择，然后才能删除。终于在网上搜出一个妙招来：
- 进入Chrome历史记录页面；
- 搜索想要删除的URL；
- 为了删除所搜结果的所有记录，将第一个待删项的checkbox勾选上，接着滚动页面到最后一个待删项，按住SHIFT键将最后一个待删项的checkbox勾选上，这样所有待删项都会被勾选上；
- 点击"Remove selected items"按钮即可。

### Chrome浏览器离线安装包下载地址 （2013-12-12）

[http://www.google.com/chrome/eula.html?standalone=1&hl=zh-CN](http://www.google.com/chrome/eula.html?standalone=1&hl=zh-CN)

### 一键保存当前打开的所有标签页 （2014-01-22）

经常是用Chrome打开一堆网页，但是由于某种原因必须重启机器，不想将这些页面存入书签，但是又想保存下来开机后继续浏览。  
在网上搜了一下，下列Chrome插件可以满足这个需求：  

- [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall)  
- [Session Buddy](https://chrome.google.com/webstore/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko)  
- [PanicButton](https://chrome.google.com/webstore/detail/panicbutton/faminaibgiklngmfpfbhmokfmnglamcm)  
- [Stash](https://chrome.google.com/webstore/detail/stash/bnhjedgfogckebfhnlicnkbdjlmpibck)  
- [Read Later](https://chrome.google.com/webstore/detail/read-later/nplngmgdacdfncdkpdomipkehfnbinfa)  
- [VIEW LATER](https://chrome.google.com/webstore/detail/view-later-save-links-in/hnolaplfoobcmgfmjphkmbjolinelpkb)  
- [Save For Later](https://chrome.google.com/webstore/detail/save-for-later-bookmark-m/kfokknghaopioakjibdkmjoaghcileob)  

其中[OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall) 和[Session Buddy](https://chrome.google.com/webstore/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko) 都是五星插件，并且用户众多，最终我选择了 [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall) 。

### 在chrome控制台中加载Javascript文件 （2014-02-02）

[Include javascript file in chrome console](http://stackoverflow.com/questions/5282228/include-javascript-file-in-chrome-console) 里面介绍了几种在Chrome控制台加载Javascript文件的方法，对我来说使用JQuery是最方便的做法。
```
$.getScript('script.js');
```

### 手工修改Chrome配置文件 （2014-03-02）

当初装Chrome，g.cn上死活下载不了，随便装了一个澳洲版的。结果访问taobao、weibo被认成了澳洲用户，都被推到了海外入口。  
一开始折腾Chrome的配置菜单，没找到。后来直接修改C:\Users\\AppData\Local\Google\Chrome\UserData\Default\Preferences搞定了。  
原始值：  
```
      "last_known_google_url": "https://www.google.com.au/",
      "last_prompted_google_url": "https://www.google.com.au/",
```
修改后：  
```
      "last_known_google_url": "https://www.google.com.hk/",
      "last_prompted_google_url": "https://www.google.com.hk/",
```

### Chrome Extension记录 （2019-01-23）

重装机器后发现Chrome扩展工具需要重装，现搜了事。为了便于以后重装，特此记录。  

- [LinkedIn Extension](https://chrome.google.com/webstore/detail/linkedin-extension/meajfmicibjppdgbjfkpdikfjcflabpk/related?hl=en)  
- [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall/related?hl=en)  
- [网页截图 - Screenshot Extension](https://chrome.google.com/webstore/detail/1-click-webpage-screensho/akgpcdalpfphjmfifkmfbpdmgdmeeaeo/related?hl=zh-CN)  

- [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)  
- [HTTP Archive Viewer](https://chrome.google.com/webstore/detail/http-archive-viewer/ebbdbdmhegaoooipfnjikefdpeoaidml?hl=en)  

另：[CrxDL](https://crxdl.com) 是一个不错下载Chrome扩展插件的网站，在墙内用很给力。  

### Resize Extension bar （2020-08-05）

新版Chrome里面扩展插件有个单独工具栏，可是不能resize了，这样就没办法隐藏了。  
解决办法是进入`chrome://flags/#extensions-toolbar-menu`，禁止Extensions Toolbar Menu即可。  

