---
title: 'Web安全'
date: 2014-11-11 21:11:16
categories: 
- Service+JavaEE
tags: 
- web安全
- xss
- clickjacking
- csrf
- session_fixation
---
学习OpenUI5程序员指南里关于Web安全的章节，在网上也搜了一下资料，下面是这次的学习笔记。

## 浏览器安全

### [跨站脚本攻击（Cross-Site Scripting， XSS）](http://en.wikipedia.org/wiki/Cross-site_scripting)

XSS指的是恶意攻击者往Web页面里插入恶意html代码，当用户浏览该页之时，嵌入其中Web里面的html代码会被执行，从而达到恶意用户的特殊目的。例如，如果某些无需登录即可访问的公共页面区域有提交表单，攻击者可以在提交内容里面注入恶意javascript脚本（原理类似与SQL注入攻击），提交后的页面内容可能就含有这样的可执行恶意脚本。当其他登录用户访问这个页面后，就有可能泄漏自己的会话cookie信息。一般的防御手段是使用HTMLSanitization工具对用户输入信息做检查，过滤其提交内容；或者cookie记录登录ip，仅允许该ip使用此cookie。

### [点击劫持（clickjacking）](http://en.wikipedia.org/wiki/Clickjacking)

点击劫持指的是通过欺骗用户点击看似正常的恶意网页来获得机密信息或远程控制其电脑。例如，攻击者想要攻击某网页，可以发布一个网址与原网址及其近似的恶意网页，恶意网页通过iframe嵌入原网页。当用户被欺骗到恶意网页，界面和操作都与原网页一模一样，但操作实际上是与恶意网页交互。另外一个例子是攻击者发布一个恶意flash游戏，当用户玩游戏时，点击会被引导到恶意链接上，进而控制用户的摄像头和麦克风，用户的个人隐私遭到泄漏。一般的防御手段是Framebusting：正常网页中添加X-FRAME-OPTIONS=DENY(拒绝任何域加载)的http头，以及通过javascript脚本判别顶级frame是否被修改并将覆盖在自身上面的"恶意"frame重新定向会self.location。

### HTML5

#### localStorage

所有浏览器都提供本地存储API，可用于存储有限数量的数据。仅运行在与存储数据相同域上的JavaScript代码可被执行进行数据访问。浏览器的本地存储不是安全存储，所以仅能用于存储静态数据，不应该存储应用数据。

#### WEBGL

越来越多的浏览器默认支持WEBG，WEBG允许访问计算机的底层图形API，这可能导致底层漏洞。

#### WebSockets

WebSockets为web应用的客户端/服务器通信提供了新的方式，但很多浏览器厂商的第一版WebSockets实现就暴露了很多安全问题。RGC6455中的WebSockets标准化已经稳定，并且Chrome16、Firefox 11和IE10都实现了WebSockets。即使浏览器自身的WebSockets实现被证明是安全的，使用WebSockets时客户端仍需要额外的安全措施。

#### Postmessage/Onmessage

postMessage允许浏览器窗口之间的跨域通信，这可能会导致安全问题。应用程序应该检查消息的发送域并仅处理来自受信域的消息。

## 会话安全

HTTP通信是无状态的和非加密的，客户端和服务器之间的数据传输是不安全的，因此有必要使用SSL进行加密，并使用cookie或URL地址重写进行会话处理。即使使用SSL对数据传输进行加密，仍有可能发生会话劫持。跨域请求伪造和会话固定攻击就是这类攻击中突出的两个例子。

### WEB认证基础知识

- 用户访问需要认证的网站。
- 用户提供一个用户名和口令进行验证。
- 网站验证用户口令，如果通过，则准许用户登录进入，并将一个cookie提供给用户的浏览器。此cookie用于唯一的标识会话。
- 用户继续访问网站。在用户请求一个新网页时，浏览器都会发送cookie和用户请求，提醒Web服务器：该请求是前面的认证连接的一部分。在多数情况下，Web开发人员和网站管理员都会使用HTTPS加密来保护这个过程的第二步，他们都知道如果其它人员能够访问其他用户的用户名和口令，就可以轻易地获得访问权。在许多情况下，他们会转而使用一个不加密的HTTP连接，以便于实现Web通信的其余部分，其中也包括cookie的交换。

### [火羊（Firesheep）](http://en.wikipedia.org/wiki/Firesheep)

Firesheep是一个火狐（Firefox）插件，它在不安全的无线网络中自动操作会话劫持攻击。这个插件（plug-in）本质上是一个数据包嗅探器，它监测并分析Wi-Fi上终端用户之间的流量，并获取正在交换的cookie。西雅图的软件开发工程师EricButler研发了Firesheep并在2010年10月的ToorCon黑客会议上宣布了它的发行。Firesheep非常容易使用，下载插件，登陆公用的WIFI点，按一下按钮就可以获取网络中各种人的用户名和图像（例如：Facebook、Twitter、Flickr、bit.ly、Google和Amazon），双击图像攻击者就可以用受害人的身份登陆了。一般的防御手段是仅允许通过SSL来发送cookie；要限制能够利用cookie的应用程序；限制cookies仅能使用HTTPS。

### [跨域请求伪造(Cross-site request forgery, CSRF或XSRF)](http://en.wikipedia.org/wiki/Cross-site_request_forgery)

跨域请求伪造指的是恶意攻击者往Web页面里插入恶意html代码，当用户浏览该页之时，在用户毫不知情的情况下以用户名义伪造请求发送给受攻击站点，从而在并未授权的情况下执行在权限保护之下的操作。例如，恶意网页中有转账请求的恶意链接，当有用户被骗访问网站并点击了带有恶意链接的图片或广告，该请求会附带用户浏览器的cookie一起发往银行。大多数情况下，该请求会失败，因为它要求用户的认证信息。但是如果用户当时恰巧刚访问他的银行后不久，他的浏览器与银行网站之间的会话尚未过期，浏览器的cookie之中含有用户的认证信息。这时，转账请求就被处理。一般的防御手段是验证HTTP的Referer字段；在所有页面加入同步令牌模式(Synchronizer tokenpattern)并要求在请求地址中添加令牌并验证；在强调安全的操作前重复用户认证。

### [会话固定攻击(session fixation)](http://en.wikipedia.org/wiki/Session_fixation)

会话固定攻击是利用服务器的session不变机制，借他人之手获得认证和授权，然后冒充他人。例如，攻击者访问http://vulnerable.example.com/ ，并从服务器响应(Set-Cookie:SID=0D6441FEA4496C2)获得会话ID，他发送给受害者一个链接http://vulnerable.example.com/?SID=0D6441FEA4496C2。受害者登录的话，会使用这个固定会话标识符SID=0D6441FEA4496C2。攻击者这时访问http://vulnerable.example.com/?SID=0D6441FEA4496C2就可以不受限地访问受害者的账户了。一般的防御手段是用户登录后更改会话ID；仅接受服务器生成的会话ID；超时或退出登录后删除会话；强调安全的操作使用SSL会话ID；每次请求更新会话ID。

## 参考

- [Busting Frame Busting: a Study of Clickjacking Vulnerabilities on Popular Sites](http://www.cnblogs.com/LittleHann/p/3386055.html)  
- [使用 HTML5 WebSocket 构建实时 Web 应用](http://www.ibm.com/developerworks/cn/web/1112_huangxa_websocket/)  
- [应用 HTML5 的 WebSocket 实现 BiDirection 数据交换](http://www.ibm.com/developerworks/cn/web/1112_weijf_websocket/)  
- [HTML5 postMessage 和 onmessage API 详细应用](http://www.ibm.com/developerworks/cn/web/1301_jiangjj_html5message/index.html)  
- [urlrewrite使用小结](http://beyondlovew.iteye.com/blog/432642)  
- [怎样应对会话劫持：以Firesheep为例](http://zhidao.baidu.com/question/623963464128251604.html)  
- [CSRF 攻击的应对之道](http://www.ibm.com/developerworks/cn/web/1102_niugang_csrf/)  
- [Spring Security如何防止会话固定攻击(session fixation attack)](http://www.cnblogs.com/makemelaugh/archive/2013/05/12/3074486.html)  
- [黑客攻防技术宝典: Web实战篇](http://www1.huachu.com.cn/read/readbook.asp?bookid=10107753)  
