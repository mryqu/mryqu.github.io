---
title: '浏览器的本地存储在GoJS BPMN样例中的使用'
date: 2015-03-02 20:06:19
categories: 
- workflow
tags: 
- localstorage
- gojs
- bpmn
- javascript
- browser
---
GoJS BPMN样例中可以存储BPMN模型，它采用的存储媒体是浏览器的本地存储。[Web Storage](http://www.w3.org/TR/webstorage/)(W3C WebApps Working Group)中定义了如下的Storage接口：
```
interface Storage {
  readonly attribute unsigned long length;
  DOMString key(unsigned long index);
  getter DOMString getItem(DOMString key);
  setter creator void setItem(DOMString key, DOMString value);
  deleter void removeItem(DOMString key);
  void clear();
};
```

GoJS BPMN样例采用的方法如下：
```
function checkLocalStorage() {
  return (typeof (Storage) !== "undefined") && (window.localStorage !== undefined);
}

window.localStorage.setItem(key, value)
window.localStorage.getItem(key)
window.localStorage.removeItem(key)
```

我的测试是存储一个名为yqu_GoJSBPMN_Samp1的模型。
![浏览器的本地存储在GoJS BPMN样例中的使用](/images/2015/3/0026uWfMgy6QnUy7gQwa0.jpg)
如果想清除我的小测试所用的本地存储，可以通过chrome://settings/cookies#cont页面来完成：
![浏览器的本地存储在GoJS BPMN样例中的使用](/images/2015/3/0026uWfMgy6QnUyls1u04.jpg)

### 参考

[MDN：DOM Storage guide](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Storage)    
[DOM Storage](http://ejohn.org/blog/dom-storage/)    