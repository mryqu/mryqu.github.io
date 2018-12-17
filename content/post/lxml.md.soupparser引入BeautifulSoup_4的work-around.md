---
title: 'lxml.html.soupparser引入BeautifulSoup 4的work-around'
date: 2014-06-22 15:51:50
categories: 
- Python
tags: 
- python
- lxml
- beautifulsoup
- html
- xml
---
想用一下python的xpath功能分析一个html文件，[lxml](http://lxml.de/)是比较不错的xml/html解析库，lxml功能强大，性能也不错，此外也包含了ElementTree，html5lib ，beautfulsoup 等库。
可惜我的html文件格式不是很严谨，[lxml](http://lxml.de/)的ElementTree处理不了，就转而想用[lxml](http://lxml.de/)的beautfulsoup来处理。
结果[lxml](http://lxml.de/)找不到[BeautifulSoup](http://www.crummy.com/software/BeautifulSoup/bs4/doc/index.zh.html)库。

![lxml.html.soupparser引入BeautifulSoup 4的work-around](/images/2014/6/0026uWfMgy6NW0mZzIGd6.jpg)
查了一下Anaconda装的库里面明明有[Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/bs4/doc/index.zh.html) 4.3.1，感觉很奇怪！!
[lxml.html.soupparser引入BeautifulSoup 4的work-around](/images/2014/6/0026uWfMgy6NW0nruT96b.jpg)
原来[Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/bs4/doc/index.zh.html) 3目前已经停止开发，[Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/bs4/doc/index.zh.html) 4移植到了BS4。

下面的语句就可以引入[Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/bs4/doc/index.zh.html) 4了，可是lxml还是无法引入beautfulsoup。
```
from bs4 import BeautifulSoup
```

stackoverflow有一个帖子[import error due to bs4 vs BeautifulSoup](http://stackoverflow.com/questions/14042023/import-error-due-to-bs4-vs-beautifulsoup)讲了一个work-around，可以欺骗lxml从而引入beautfulsoup。测试一下，果然工作正常了。
```
import sys, bs4
sys.modules['BeautifulSoup'] = bs4
import lxml.html.soupparser as soupparser
```
![lxml.html.soupparser引入BeautifulSoup 4的work-around](/images/2014/6/0026uWfMgy6NW0nNsbr1d.jpg)