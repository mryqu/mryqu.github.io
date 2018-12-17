---
title: '[社交网络分析课] 数据集预处理及Gephi导入'
date: 2014-11-23 23:24:33
categories: 
- DataScience
tags: 
- 社交网络分析
- 经验性网络分析
- r
- gephi
- 数据预处理
---
紧赶慢赶忙完了社交网络分析课的编程大作业，选择的是经验性网络分析。


这次的大作业没有指定数据集，自己找数据集做分析。我在网上搜到以前一个同学做的移民分析，感觉很不错。然后，就茫然了。最怕这种自己找数据集的，以前有的课程介绍了一些比较好的开放数据集，可惜当时没觉得有什么太大的价值，没记呀！！！



费了半天，找了一个大不列颠的公路流量数据集，公路就是edge了，每个公路的两端就是node了，感觉还可以。数据集在线地址: [http://data.dft.gov.uk/gb-traffic-matrix/Traffic-major-roads-miles.csv](http://data.dft.gov.uk/gb-traffic-matrix/Traffic-major-roads-miles.csv).数据集手册在线地址: [http://data.dft.gov.uk/gb-traffic-matrix/all-traffic-data-metadata.pdf](http://data.dft.gov.uk/gb-traffic-matrix/all-traffic-data-metadata.pdf)



这次作业主要使用Gephi对数据集进行分析，所以我先使用R语言对原始数据集进行预处理，然后使用Gephi导入生成的nodes.csv和edges.csv。



```
if (!file.exists("./Traffic-major-roads-miles.csv")) {
    download.file("http://data.dft.gov.uk/gb-traffic-matrix/Traffic-major-roads-miles.csv", 
        destfile = "./Traffic-major-roads-miles.csv")
}
data <- read.csv("Traffic-major-roads-miles.csv", sep = ",")
data2013 <- subset(data, Year == 2013 & AllMV > 0, select = c(A.Junction, B.Junction, 
    AllMV))
data2013 <- data.frame(A.Junction = toupper(data2013$A.Junction), B.Junction = toupper(data2013$B.Junction), 
    Weight = data2013$AllMV, stringsAsFactors = FALSE)

A.junctions <- as.vector(data2013[, 1])
B.junctions <- as.vector(data2013[, 2])
junctions <- sort(unique(c(A.junctions, B.junctions)))

# write nodes.csv
nodes_print <- cbind(c("Nodes", junctions), c("Id", 1:length(junctions)), c("Label", 
    junctions))
nodes_print <- t(nodes_print)
write(nodes_print, file = "nodes.csv", ncolumns = 3, sep = ";")

# edges <- data.frame(Source=c('Source'), Target=c('Target'),
# Weight=c('Weight'), Id=c('Id')) for(i in 1:nrow(data2013)) { edges <-
# rbind(edges,
# data.frame(Source=as.character(which(junctions==data2013[i,1])),
# Target=as.character(which(junctions==data2013[i,2])),
# Weight=data2013[i,3], Id = as.character(i) ) ) }
edges <- data.frame(Source = c("Source", match(data2013[, 1], junctions)), Target = c("Target", 
    match(data2013[, 2], junctions)), Weight = c("Weight", data2013[, 3]), Id = c("Id", 
    1:nrow(data2013)), stringsAsFactors = FALSE)

# write edges.csv
edges_print <- as.matrix(edges)
edges_print <- t(edges_print)
write(edges_print, file = "edges.csv", ncolumns = 4, sep = ";")

```

代码里首先将所有公路起始和终止端点合并、去冗余、排序，用于生成nodes.csv。然后搜索每个公路端点在公路端点集合的下标，用于生成edges.csv。第一版的代码被迫使用了一次for循环，主要是只对which函数印象很深刻。在R语言里使用for循环慢的要死，感觉那是相当的屌丝。后来找到了match函数，感觉非常好。

![社交网络分析课：数据集预处理及Gephi导入](/images/2014/11/0026uWfMgy6NSI41N3I62.jpg)



