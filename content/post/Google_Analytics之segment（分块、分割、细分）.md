---
title: 'Google Analytics之segment（分块、分割、细分）'
date: 2015-09-22 06:44:04
categories: 
- DataBuilder
tags: 
- google
- analytics
- segment
- socialmedia
---
Segment是指你的GoogleAnalytics（分析）数据子集。例如，在你的整个用户群中，你可使用一个segment指定来自特定国家或城市的用户，使用另一个segment指定购买特定产品系列或访问网站上特定部分的用户。
Segment可让你隔离出这些数据子集并进行分析，从而检查并响应业务中的各个子趋势。例如，如果你发现特定地理区域的用户所购买的特定产品系列的数量低于正常水平，就可以查看是不是因为竞争对手在以更低的价格销售同类型的产品。如果是这样，你可以通过向那些用户提供忠诚度折扣来弱化竞争对手在价格方面的优势。
你还可以使用segment作为再营销受众群体的基础。例如，您可针对男装页面的访问者创建一个用户细分，然后利用重点宣传您添加到这些页面上的新产品的再营销广告系列来专门定位这些用户（再营销受众群体）。

### Segment类型

Segment代表会话子集或用户子集：
- 会话子集：例如，源自广告系列 A 的所有会话；发生购买行为的所有会话
- 用户子集：例如，之前有过购买行为的用户；向其购物车添加了商品，但未完成购买的用户

先了解一下 Google Analytics（分析）用户模型有助于了解segment的工作原理。 
GoogleAnalytics（分析）用户模型由三大要素构成：
- 用户
- 会话 - 用户到达您的网站资源并与之互动。所有这些用户互动都会被划组到所谓的会话中。
- 点击（Hit）-在会话中，用户会与您的网站资源互动。每次互动都被称为一次点击。这些点击包括网页浏览、事件、交易等等。

一个用户可以有多个会话，每个会话可以有多次点击。下图直观显示了这一关系：
![Google Analytics之segment（分块、分割、细分）](/images/2015/9/0026uWfMgy6Wj8J6lnL75.png)_Google Analytics（分析）用户模型_

### 使用Segment

Segment是非破坏性的过滤器，不会更改您的基础数据。应用segment之后，它会在您浏览报告的过程中始终保持有效状态，直到您将其移除。您一次最多可以应用四个细分，并可在报告中将各个细分的结果放在一起比较。
除分析数据之外，Segment还可以用于[构建再营销受众群体](https://support.google.com/analytics/answer/6015314)。
GoogleAnalytics（分析）包含预定义segment（系统segment），您可以按原样使用这些segment，也可以通过复制并修改这些segment来创建新的自定义segment。您也可以从头开始构建自己的segment。另外，您可以从 [Google Analytics（分析）解决方案库](https://www.google.com/analytics/gallery/#landing/start/)导入segment，这是一个免费的市场，GoogleAnalytics（用户）可在其中分享各种segment以及开发的其他解决方案。

### Segment的定义和范围

在 Google Analytics（分析）报告中，您可以通过创建基于[维度和指标](https://support.google.com/analytics/answer/1033861)的过滤器来定义segment：
- 用户类型完全匹配“回访用户”
- 国家/地区完全匹配“美国”
- 电子商务转化率>“0.2%”

除了您在过滤器中使用的维度和指标之外，您还可以为过滤器设置数据范围。您可以使用三种范围：
- 点击：单次操作中的行为，例如查看网页或播放视频。
- 会话：单次会话中的行为；例如在会话过程中用户完成的目标或产生的收入。
- 用户：在所用日期范围（最多 90天）内所有会话中的行为；例如，在日期范围内的所有会话中用户完成的所有目标或产生的所有收入。

你可以使用[segment生成工具](https://support.google.com/analytics/answer/3124493)定义组成segment的过滤器。

### Segment限制

Segment需要遵守以下限制：

#### Segment总数上限

- 每个帐户 1000个segment
- 每个数据视图中，每位用户 100个segment
- 每个数据视图，所有用户共享100个segment
这些限制适用于系统segment以及您创建或导入的所有segment。达到这些数量上限后，你就无法创建或导入更多segment。

#### 应用于报告的segment

你一次最多可以在报告中应用4个segment。

#### 日期范围

使用基于用户的segment时，您在报告中应用的日期范围不能超过90天。如果您已将日期范围设置为90天以上，那么当您创建基于用户的segment时，GoogleAnalytics（分析）会从开始日期算起，将该日期范围重置为90天。
基于“第一次会话的日期”的segment的最大范围是31天。

#### 多渠道路径

请不要在多渠道路径报告中使用segment，你可以使用[转化segment](https://support.google.com/analytics/answer/1329505)。

### Segment与filter的区别

在Googleanalytics中，Segment与filter都侧重于对数据的切片。在很多情况下，应用这两者返回的结果是相同的，但其本质是不同的。那么，何时应该使用segment，何时应该使用filter呢？
如果你想选择整个访问则使用segment，如果想查找所有访问中的特定事件、pageviews等则使用filter。
**Segment**：对于segment，每个访问都检查是否符合segment条件。对于满足条件的会话，所有行都会被获得。对于不满足条件的会话，不会获得任何行。
**Filter**：对于filter，所有访问的所有行都会检查是否满足条件，**仅满足过滤器条件的行**会被获得。
个人感受：Google analytics中的filter就像SQL中的where语句，而segment就像SQL中groupby相应的having语句。

### 参考

[About Segments](https://support.google.com/analytics/answer/3123951?hl=en)  
[The key difference between segments and filters](http://www.analyticscanvas.com/segments-vs-filters-in-google-analytics/)  