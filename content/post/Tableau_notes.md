---
title: '安装Tableau Public'
date: 2016-08-30 06:18:43
categories: 
- DataBuilder
tags: 
- tableau
- installation
- import
- google sheets
- onedrive
- google analytics
---

### 安装Tableau Public

Tableau Public的安装文件可在[http://public.tableau.com/s/](http://public.tableau.com/s/) 下载。
![安装Tableau Public](/images/2016/8/0026uWfMzy751b5pdoP1f.jpg) 安装后创建Tableau Public账户，并进入注册所用信箱激活账户即可。

Tableau Public可导入的服务器很有限，Tableau Desktop就丰富多了。![安装Tableau Public](/images/2016/8/0026uWfMzy754gKF6Dfb1.jpg)

### 使用Tableau导入Google Sheets

尝试一下用Tableau导入Google Sheets，操作过程中没看到配置项，比较简洁。

#### 用Google账户授权Tableau

![使用Tableau导入Google Sheets](/images/2016/10/0026uWfMzy75MW4Pvy3a3.jpg)![使用Tableau导入Google Sheets](/images/2016/10/0026uWfMzy75MVC2vpy5c.jpg)

#### 显示所有电子表格

![使用Tableau导入Google Sheets](/images/2016/10/0026uWfMzy75MW8RHWN01.jpg)

#### 选择一个电子表格

![使用Tableau导入Google Sheets](/images/2016/10/0026uWfMzy75MVD5WPkfe.jpg)

#### 导入一个电子表格

![使用Tableau导入Google Sheets](/images/2016/10/0026uWfMzy75MWHayLAae.jpg)

#### 参考

[Connect Directly to Google Sheets in Tableau 10](http://www.tableau.com/about/blog/2016/5/connect-directly-your-google-sheets-tableau-10-53954)    
[Tableau connector examples](http://onlinehelp.tableau.com/v10.0/pro/desktop/en-us/help.html#exampleconnections_overview.html)    

### Tableau不支持导入OneDrive文件？

没有发现Tableau的Microsoft OneDrive连接器，OData连接器和WebData连接器都不成。查了一下[Tableau社区](https://community.tableau.com)，就寥寥无几的几个帖子提到OneDrive。其中一个帖子提到了[Using OneDrive as a Tableau Data Source](http://www.biheroes.com/using-onedrive-as-a-tableau-data-source/)。这个博文在2015年5月提到Tableau还不支持直连OneDrive上的文件，建议用OneDrive SyncApp同步到Tableau服务器上再导入。
貌似现在还是如此！！

### 使用Tableau导入Google Analytics

#### 配置界面

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681s6dYg3c.jpg)

#### Date Range配置选项

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681tszW870.jpg)

#### Segment配置选项

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681urv8o6c.jpg)

#### Dimension配置选项

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681vhBVXe5.jpg)

#### Measure Group配置选项

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681uTPnI92.jpg)

#### Measure配置选项

![使用Tableau导入Google Analytics](/images/2016/10/0026uWfMzy7681vzAbN23.jpg)

### Tableau课程

今天在赤兔数据挖掘群里看到有人说Coursera上有Tableau课程，有机会学习一下我司竞争对手的课程，也是不错的。

有五门课程属于加州大学的[使用Tableau可视化商业数据](https://www.coursera.org/specializations/data-visualization) 专业课系列：
- [Fundamentals of Visualization with Tableau](https://www.coursera.org/learn/data-visualization-tableau)
- [Essential Design Principles for Tableau](https://www.coursera.org/learn/dataviz-design)
- [Explaining Your Data Using Tableau](https://www.coursera.org/learn/dataviz-explain)
- [Creating Dashboards and Storytelling with Tableau](https://www.coursera.org/learn/dataviz-dashboards)
- [Data Visualization with Tableau Project](https://www.coursera.org/learn/dataviz-project)

有一门课程属于杜克大学的[Excel到MySQL: 用于商业的分析技术](https://www.coursera.org/specializations/excel-mysql) 专业课系列：
- [Data Visualization and Communication with Tableau](https://www.coursera.org/learn/analytics-tableau)

当然现在这些课只能听一听，不掏钱是没有分数的