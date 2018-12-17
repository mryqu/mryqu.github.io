---
title: '又被Mining Massive Datasets的老师伤了！'
date: 2014-11-07 20:42:31
categories: 
- DataScience
tags: 
- 大数据挖掘
- kmeans
- 作业
---
Mining Massive Datasets这周的课讲聚类和计算广告学：二分图匹配。课后的作业好几个都是一眼看不出来，只好写程序算。

其中有一道题是这个样子：
We wish to cluster the following set of points:
![又被Mining Massive Datasets的老师伤了！](/images/2014/11/0026uWfMgy6Nsr7vVg864.png)
into 10 clusters. We initially choose each of the green points(25,125), (44,105), (29,97), (35,63), (55,63), (42,57), (23,40),(64,37), (33,22), and (55,20) as a centroid. Assign each of thegold points to their nearest centroid. (Note: the scales of thehorizontal and vertical axes differ, so you really need to applythe formula for distance of points; you can't just "eyeball" it.)Then, recompute the centroids of each of the clusters. Do any ofthe points then get reassigned to a new cluster on the next round?Identify the true statement in the list below. Each statementrefers either to a centroid AFTER recomputation of centroids(precise to one decimal place) or to a point that getsreclassified.

第一个念头就是用R捯饬：
```
points <- matrix(c(28, 65, 50, 25, 55, 38, 44, 29, 50, 63, 43, 35, 55, 50, 42, 
    23, 64, 50, 33, 55, 145, 140, 130, 125, 118, 115, 105, 97, 90, 88, 83, 63, 
    63, 60, 57, 40, 37, 30, 22, 20), ncol = 2)
colnames(points) <- c("x", "y")

centroids <- matrix(c(25, 44, 29, 35, 55, 42, 23, 64, 33, 55, 125, 105, 97, 
    63, 63, 57, 40, 37, 22, 20), ncol = 2)
dimnames(centroids)[[2]] <- c("x", "y")

cl <- kmeans(points, centroids, trace = TRUE)
```

```
## KMNS(*, k=10): iter=  1, indx=10
##  QTRAN(): istep=20, icoun=13
##  QTRAN(): istep=40, icoun=14
## KMNS(*, k=10): iter=  2, indx=20
```

```
plot(points, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8, cex = 2)
```
![plot of chunk unnamed-chunk-1](/images/2014/11/0026uWfMgy6NsstDrYYc8.jpg)
```
cl
```

```
## K-means clustering with 10 clusters of sizes 3, 3, 5, 1, 2, 1, 1, 1, 1, 2
## 
## Cluster means:
##        x     y
## 1  30.33 128.3
## 2  56.67 129.3
## 3  45.80  92.6
## 4  35.00  63.0
## 5  52.50  61.5
## 6  42.00  57.0
## 7  23.00  40.0
## 8  64.00  37.0
## 9  33.00  22.0
## 10 52.50  25.0
## 
## Clustering vector:
##  [1]  1  2  2  1  2  1  3  3  3  3  3  4  5  5  6  7  8 10  9 10
## 
## Within cluster sum of squares by cluster:
##  [1] 559.3 359.3 900.0   0.0  17.0   0.0   0.0   0.0   0.0  62.5
##  (between_SS / total_SS =  94.4 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"         "iter"        
## [9] "ifault"
```
运行结果和问题的四个选择项都配不上。kmeans做了两轮计算，返回的是最终结果，而第一轮结果即使加了trace参数也弄不出来。最后只好默默抄起了Java，很受伤:(
