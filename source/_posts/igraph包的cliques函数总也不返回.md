---
title: 'igraph包的cliques函数总也不返回'
date: 2014-10-29 20:14:57
categories: 
- DataScience
tags: 
- 社交网络分析
- igraph
- cliques
- hang
- R语言
---
做社交网络分析课的作业时碰到一个小麻烦，igraph包的cliques函数总也不返回，最后只能强行终止但是数据量也不大，而且largest.cliques和clique.number都是立刻返回，不解呀！
```
> library(igraph)
> g = read.graph("wikipedia.gml",format="gml")
> cliques(as.undirected(g))

> largest.cliques(as.undirected(g))
[[1]]
 [1] 26526   247   370  2119  6625  7826  8277 10019 11773 11801 13289 15758
[13] 16845 16885 16937 18925 22144 22644 23318 24585 24654 25487

> clique.number(as.undirected(g))
[1] 22
```
