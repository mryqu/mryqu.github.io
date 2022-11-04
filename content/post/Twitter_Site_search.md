---
title: 'Twitter网站的高级搜索和过滤功能'
date: 2015-10-20 06:08:31
categories: 
- DataBuilder
tags: 
- twitter
- search
- query
- filter
- crawler
---
刚接触Twitter的搜索功能，以为仅能用关键字搜索推文。后来才知道，Twitter搜索不仅支持关键字的与或非逻辑处理，还能根据日期、地理位置、推文是否有链接、图像、视频、转推、回复等条件进行过滤。例如：

- 即包含"andrew"又包含"2015"的推文 `https://twitter.com/search?q=andrew 2015&src=typd`
- 完全匹配"andrew 2015"的推文 `https://twitter.com/search?q="andew 2015"&src=typd`
- 包含"andrew"或"2015"的中文推文 `https://twitter.com/search?q=andew OR 2015 lang:zh&src=typd`
- 包含"andrew"的推文（包括转推）`https://twitter.com/search?q=andrew include:retweets&src=typd`
- 包含"andrew"的推文（不包括转推）`https://twitter.com/search?q=andrew exclude:retweets&src=typd`
- 包含"andrew"且有URL链接的推文 `https://twitter.com/search?q=andrew filter:links&src=typd`
- 包含"andrew"且没有URL链接的推文 `https://twitter.com/search?q=andrew -filter:links&src=typd`

参考
- [Twitter Advanced Search](https://twitter.com/search-advanced)  
- [Using Twitter Advanced Search](https://support.twitter.com/articles/71577)  
- [How to Master Twitter Search: Basic Boolean Operators and Filters](http://thesocialchic.com/2013/04/26/how-to-master-twitter-search/)  