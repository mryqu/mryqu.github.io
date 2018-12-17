---
title: 'CRAN任务视图使用'
date: 2014-01-07 19:59:22
categories: 
- DataScience
tags: 
- r语言
- cran
- 任务视图
- taskviews
- install.views
---
一般都是从CRAN（Comprehensive R ArchiveNetwork）安装R的各种包（package）来满足我们的编程需求。CRAN将包按照应用范畴归类，并公布在如下链接：http://cran.r-project.org/web/views/我们可以通过安装视图的命令把所有同一应用范畴的包都安装上。

为了自动安装视图，需要安装ctv包。
```
install.packages("ctv")
library("ctv")
```

通过如下命令安装或更新视图。
```
install.views("Econometrics")
update.views("MachineLearning")
```

# CRAN任务视图

|视图|说明
|---
|[Bayesian](http://cran.r-project.org/web/views/Bayesian.html)|贝叶斯推断
|[ChemPhys](http://cran.r-project.org/web/views/ChemPhys.html)|化学计量学和计算物理学
|[ClinicalTrials](http://cran.r-project.org/web/views/ClinicalTrials.html)|临床试验设计、监控和分析
|[Cluster](http://cran.r-project.org/web/views/Cluster.html)|聚类分析和有限混合模型
|[DifferentialEquations](http://cran.r-project.org/web/views/DifferentialEquations.html)|微分方程
|[Distributions](http://cran.r-project.org/web/views/Distributions.html)|概率分布
|[Econometrics](http://cran.r-project.org/web/views/Econometrics.html)|计量经济学
|[Environmetrics](http://cran.r-project.org/web/views/Environmetrics.html)|生态与环境数据分析
|[ExperimentalDesign](http://cran.r-project.org/web/views/ExperimentalDesign.html)|实验设计和数据分析
|[Finance](http://cran.r-project.org/web/views/Finance.html)|实证金融
|[Genetics](http://cran.r-project.org/web/views/Genetics.html)|统计遗传学
|[Graphics](http://cran.r-project.org/web/views/Graphics.html)|图形显示 & 动态图 & 图形设备 & 可视化
|[ HighPerformanceComputing](http://cran.r-project.org/web/views/HighPerformanceComputing.html)|高性能计算和并行计算
|[MachineLearning](http://cran.r-project.org/web/views/MachineLearning.html)|机器学习与统计学习
|[MedicalImaging](http://cran.r-project.org/web/views/MedicalImaging.html)|医学图像分析
|[MetaAnalysis](http://cran.r-project.org/web/views/MetaAnalysis.html)|元分析
|[Multivariate](http://cran.r-project.org/web/views/Multivariate.html)|多元统计
|[ NaturalLanguageProcessing](http://cran.r-project.org/web/views/NaturalLanguageProcessing.html)|自然语言处理
|[NumericalMathematics](http://cran.r-project.org/web/views/NumericalMathematics.html)|数值数学
|[OfficialStatistics](http://cran.r-project.org/web/views/OfficialStatistics.html)|官方统计和调查方法
|[Optimization](http://cran.r-project.org/web/views/Optimization.html)|优化和数学规划
|[Pharmacokinetics](http://cran.r-project.org/web/views/Pharmacokinetics.html)|药物动力学数据分析
|[Phylogenetics](http://cran.r-project.org/web/views/Phylogenetics.html)|系统发育、进化和遗传学分析
|[Psychometrics](http://cran.r-project.org/web/views/Psychometrics.html)|心理测量模型和方法
|[ReproducibleResearch](http://cran.r-project.org/web/views/ReproducibleResearch.html)|可重复性研究
|[Robust](http://cran.r-project.org/web/views/Robust.html)|稳健统计方法
|[SocialSciences](http://cran.r-project.org/web/views/SocialSciences.html)|社会科学统计
|[Spatial](http://cran.r-project.org/web/views/Spatial.html)|空间数据分析
|[SpatioTemporal](http://cran.r-project.org/web/views/SpatioTemporal.html)|时空数据处理和分析
|[Survival](http://cran.r-project.org/web/views/Survival.html)|存活分析
|[TimeSeries](http://cran.r-project.org/web/views/TimeSeries.html)|时间序列分析
|[WebC++nologies](http://cran.r-project.org/web/views/WebC++nologies.html)|Web技术与服务
|[gR](http://cran.r-project.org/web/views/gR.html)|图模型
