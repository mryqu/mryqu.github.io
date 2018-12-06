---
title: 'swirl介绍'
date: 2013-12-28 14:22:46
categories: 
- DataScience
tags: 
- swirl
- R语言
- 学习
- 交互式
---
[swirl](http://swirlstats.com/)是在R命令行使用、用于R统计编程语言交互式教学的软件包。
[swirl](http://swirlstats.com/)需要R3.0.2或更新版本。如果使用老版本R，需要更新R之后才能使用swirl。如果不清楚当前R版本，可以在R命令行敲入R.version.string获得当前的版本信息。
[swirl](http://swirlstats.com/)可以通过如下命令安装：
```
install.packages("swirl")
```
每次使用前，通过如下命令加载包并执行：
```
library(swirl)
swirl()
```