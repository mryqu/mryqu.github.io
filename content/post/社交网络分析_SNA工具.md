---
title: '[社交网络分析课] SNA工具'
date: 2014-10-08 20:57:50
categories: 
- DataScience
tags: 
- 社交网络分析
- sna
- 工具
- gephi_netlogo_igraph
- r_python_java_js
---
本文为Social NetworkAnalysis学习笔记，课程地址为https://www.coursera.org/course/sna。

### Gephi

![Gephi - The Open Graph Viz Platform](/images/2014/10/0026uWfMzy6NZW4NjNR97.jpg)
- [https://gephi.github.io/](https://gephi.github.io/)
- 用于网络、复杂系统和动态封层图形的交互式可视化及研究平台，支持度、介数、紧密性等网络中心性指标以及密度、路径长度、网络直径、模块度、集聚系数等指标，支持GDF(GUESS)、GraphML (NodeXL)、GML、NET (Pajek)、GEXF等文件格式。
- 开源，支持Windows、Linux和Mac OS X平台
- [Gephi指南](https://gephi.org/users/)
- [ 使用Gephi可视化twitter网络](http://blog.ouseful.info/2011/07/07/visualising-twitter-friend-connections-using-gephi-an-example-using-wireduk-friends-network/)
- [Twitter上的埃及革命](https://blog.gephi.org/2011/the-egyptian-revolution-on-twitter/)

### NetLogo

![社交网络分析：SNA工具](/images/2014/10/0026uWfMgy6Ptz1NVMq86.jpg)
- [https://ccl.northwestern.edu/netlogo/index.shtml](https://ccl.northwestern.edu/netlogo/index.shtml)
- 多主体仿真建模工具。可用于模拟各种社会现象和自然现象，通过设置个体行为并使多个个体自由运行来研究个体行为对于复杂系统的影响和变化。
- 开源，支持Windows、Linux和Mac平台
- [NetLogo帮助文档](https://ccl.northwestern.edu/netlogo/docs/)
- [Lada的多个特定网络属性演示](http://www.ladamic.com/netlearn/)

### iGraph

![社交网络分析：SNA工具](/images/2014/10/0026uWfMgy6PtAGwRG6e6.png)
- [http://igraph.org/](http://igraph.org/)
- 网络分析工具库，侧重于执行效率、可移植性和易用性，可被R、Python和C/C++调用。
- 开源，支持Windows、Linux和Mac OS X平台
- [R iGraph帮助文档](http://igraph.org/r/)
- [Python iGraph帮助文档](http://igraph.org/python/)
- [C iGraph帮助文档](http://igraph.org/c/)

### Pajek

![社交网络分析：SNA工具](/images/2014/10/0026uWfMgy6PtE18Cty50.png) 
-  [http://pajek.imfm.si/doku.php](http://pajek.imfm.si/doku.php)
- 网络分析和可视化工具，功能丰富，通过下拉菜单进行各种操作。
- 免费，支持Windows平台，也可以在Linux（64）和Mac平台上仿真（Wine）运行
- [Pajek参考手册](http://mrvar.fdv.uni-lj.si/pajek/pajekman.pdf)

### UCINet

![社交网络分析：SNA工具](/images/2014/10/0026uWfMgy6PtNcAyUE80.png)
- [https://sites.google.com/site/ucinetsoftware/](https://sites.google.com/site/ucinetsoftware/home)
- 社交网络数据分析软件包，功能丰富。
- 商业软件，支持Windows平台
- [UCINet文档](https://sites.google.com/site/ucinetsoftware/document)

### NodeXL

![社交网络分析：SNA工具](/images/2014/10/0026uWfMgy6PtNQy3Wifa.png)
- [http://nodexl.codeplex.com/](http://nodexl.codeplex.com/)
- 交互式网络可视化和分析工具，以MS Excel模板的形式利用MSExcel作为数据展示和分析平台。可以定制图像外观、无损缩放、移动图像，动态过滤顶点和边，提供多种布局方式，查找群和相关边，支持多种数据格式输入和输出。
- 开源，支持Windows Excel 2007/2010/2013
- [NodeXL文档](http://nodexl.codeplex.com/documentation)

### 其他


#### R

- [R的SNA库](http://cran.r-project.org/web/packages/sna/index.html)(见[统计软件杂志上关于sna包的文章](http://www.jstatsoft.org/v24/i06/paper))：功能丰富，偏于统计
- 如果使用Gephi的话，可以看一下用于读写Gephi gexf图形文件的[rgexf](http://cran.r-project.org/web/packages/rgexf/index.html)库。

#### Python

- [NetworkX](http://networkx.lanl.gov/)：开源Python包，用于复杂网络的创建、操作和复杂网络的结构、动力学和功能方面的研究。
- [Sage](http://www.sagemath.org/)：开源基于Web的数学计算环境，包含NetworkX以及自己的图形库。这里有三篇重要文档，[通用图参考文档](http://www.sagemath.org/doc/reference/sage/graphs/generic_graph.html)、 [无向图参考文档](http://www.sagemath.org/doc/reference/sage/graphs/graph.html) 和 [有向图参考文档](http://www.sagemath.org/doc/reference/sage/graphs/digraph.html)。
- [graph-tool](http://projects.skewed.de/graph-tool/)：高效python模块，用于图/网络的操作和统计分析。
- [Newt](https://github.com/psychemedia/newt)

#### Java

- [Jung（Java Universal Network/Graph Framework）](http://jung.sourceforge.net/)：Java平台网络/图应用开发的一种通用基础架构。其目的在于为开发关于图或网络结构的应用程序提供一个易用、通用的基础架构。使用JUNG功能调用，可以方便的构造图或网络的数据结构，应用经典算法（如聚类、最短路径，最大流量等），编写和测试用户自己的算法，以及可视化的显示数据的网络图。
- [Neo4j](http://neo4j.org/)：图数据库
- [Blueprints](https://github.com/tinkerpop/blueprints/wiki)：类似于JDBC，但是用于图数据库
- [SoNIA（Social Network Image Animator）](http://www.stanford.edu/group/sonia/):用于动态或纵向数据的可视化。

#### JavaScript

- [D3.js](http://d3js.org/)： 数据驱动的文档（Data DrivenDocuments）
- [JSNetworkX](http://felix-kling.de/JSNetworkX/)：NetworkX图形库在JavaScript上的移植版本。
- [arbor.js](http://arborjs.org/)：使用webworkers和jQuery的图形可视化库。

#### 社交网挖掘

- [社交网挖掘 GitHub](https://github.com/ptwobrussell/Mining-the-Social-Web)
- [社交网挖掘 (第2版) GitHub](https://github.com/ptwobrussell/Mining-the-Social-Web-2nd-Edition)

#### Talend

- [Talend: 构建GML图形](http://gabrielebaldassarre.com/build-graphs-for-social-network-analysis/)

#### Twitter

- [Twitter4j](http://twitter4j.org/en/index.html)
- [Twitter4j Dev Forum](https://groups.google.com/forum/?fromgroups#!forum/twitter4j)
- [TwitterAPI](https://dev.twitter.com/)
- [Python, Twitter and the 2012 French Presidential Election](http://www.laurentluce.com/posts/python-twitter-statistics-and-the-2012-french-presidential-election/)
- [Mentionmapp](http://mentionmapp.com/#)
- [Twiangulate](http://twiangulate.com/search/)
- [Iteractive](http://iteractive.ca/sna/connect.php)：适用于关注人数在340人以内

#### LinkedIn

- [LinkedIn Maps](http://inmaps.linkedinlabs.com/)