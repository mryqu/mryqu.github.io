---
title: '玩一下Quandl API'
date: 2017-05-11 06:00:43
categories: 
- DataBuilder
tags: 
- quandl
- api
- rest
---
Quandl是为投资专业人士提供财务、经济和替代数据的平台。 Quandl来源于500多家出版商的数据。所有Quandl的数据都可通过API访问，也可以通过包含R、Python、Ruby等多种编程语言及Excel、SAS等软件进行原生访问。Quandl的来源包括联合国，世行和中央银行等提供商的公开数据、来自CLS集团，Zacks和ICE等供应商的核心财务数据、Dun＆Bradstreet的其他数据、以及许多机密来源。
**什么是替代数据？**替代数据的范围非常广泛，起初主要包含了未加工的、原始的公司文件、历史市场价格、投资者表现等数据，而现在替代数据已经涵盖任何从移动手机数据到职位信息再到天气预报、交通、卫星图像等能够被采集到的数据。替代数据世界由一系列模糊的数据集组成，而这些数据集可以被转换为交易信息。Quandl提供的替代数据包括企业财务压力数据、外汇数据、电子邮件收据数据、全球石油储量数据、定量股票选择数据等。
Quandl上的数据分为免费数据和高级（Premium）数据，其中高级数据只能通过订阅访问。

### 申请Quandl账号

除了在Quandl上注册帐号外，Quandl还支持使用GitHub、Google和LinkedIn账号进行OAuth2认证登录。登录后查看账户设置信息中的API KEY，即可用于后继API访问。
![Quandl Api Key](/images/2017/05/QuandlApiKey.png)
### Quandl API

全部的Quandl数据产品，可通过[https://www.quandl.com/search](https://www.quandl.com/search)查找。Quandl的数据产品来源不同，包含时间序列和表在内的各种对象。
![Quandl interface](/images/2017/05/QuandlInf.jpg)

Guandl的大多数数据集只能以时间序列或表中的一种格式打开，其中一些则既可用时间序列格式也可用表格式访问。
*   时间序列是一段时间内观测或指标集合，以时间为索引且只包含数字数据类型字段。
*   表包含各种未排序数据类型（字符串、数字、日期等）并可用不同字段进行过滤。

Guandl可指定如下返回类型：
*   JSON
*   CSV
*   XML

#### 速率限制

认证用户限制10秒300个调用、10分钟2000调用及每天50000调用。使用免费数据集的认证用户并发限制为1，即进行一个调用的同时可以在队列中有一个额外的调用。
高级数据订阅限制10分钟5000调用及每天720000调用。

### 访问时间序列

*   获取时间序列数据集数据  
    ```
        GET https://www.quandl.com/api/v3/datasets/{database_code}/{dataset_code}/data.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDatasetData](/images/2017/05/Quandl_getDatasetData.png)
*   获取时间序列数据集元数据  
    ```
        GET https://www.quandl.com/api/v3/datasets/{database_code}/{dataset_code}/metadata.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDatasetMeta](/images/2017/05/Quandl_getDatasetMeta.png)
*   获取时间序列数据集数据及元数据  
    ```
        GET https://www.quandl.com/api/v3/datasets/{database_code}/{dataset_code}.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDataset](/images/2017/05/Quandl_getDataset.png)
*   获取时间序列数据库元数据  
    ```
        GET https://www.quandl.com/api/v3/databases/{database_code}.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDatabase](/images/2017/05/Quandl_getDatabase.png)
*   获取整个时间序列数据库(**仅能用于订阅的高级数据**)  
    ```
        GET https://www.quandl.com/api/v3/databases/{database_code}/data?download_type=full&api_key=YOURAPIKEY
    ```
#### 查询参数

| 参数 | 必需 | 类型 | 值 | 描述 |
| - | - | - | - | - |
| database_code | 是 | string |   | 数据库代码 |
| dataset_code | 是 | string |   | 数据集代码 |
| limit | 否 | int |   | 使用limit=n获得数据集的头n行。使用limit=1获取最新的一行。 |
| column_index | 否 | int |   | 指定特定列。第0列是日期列且永久返回，因此该处从第1列起。<br>（mryqu：不指定则显示全部列，指定就显示两列，为什么没有逗号分隔了？） |
| start_date | 否 | string | yyyy-mm-dd | 用于过滤的起始日期 |
| end_date | 否 | string | yyyy-mm-dd | 用于过滤的结束日期 |
| order | 否 | string | asc<br>desc | 日期排序 |
| collapse | 否 | string | none<br>daily<br>weekly<br>monthly<br>quarterly<br>annual | 改变返回数据的抽样频率。默认为none，即原始颗粒度。改变抽样频率后，Quandl返回给定时间段内最后一个观测值。 |
| transform | 否 | string | none<br>diff<br>rdiff<br>rdiff_from<br>cumul<br>normalize | 在下载前对数据执行基本计算。默认为none。|

搜索FRED数据库的GDP数据集，按年抽样，取头6行，日期升序排列，显示第0和1列：  
![Quandl queryDataset](/images/2017/05/Quandl_queryDataset.png)

### 访问表

*   获取表元数据  
    ```
        https://www.quandl.com/api/v3/datatables/{publisher_code}/{datatable_code}/metadata.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDatatableMeta](/images/2017/05/Quandl_getDatatableMeta.png)
    通过表元数据克制列名和类型，以及那些列可用作行过滤器。
*   获取表数据  
    ```
        https://www.quandl.com/api/v3/datatables/{publisher_code}/{datatable_code}.{return_format}?api_key=YOURAPIKEY
    ```
    ![Quandl getDatatable](/images/2017/05/Quandl_getDatatable.png)
    此API最多返回10000行数据，其中返回数据中的next-cursor-id用于指示下一页。可以通过下面提到的查询参数qopts.cursor_id进行分页查询，或者通过查询参数qopts.export=true将整表导出为压缩csv的zip文件。  

#### 过滤器操作符

共有五种过滤器操作符：` =` 、` .gt=` 、` .lt=` 、` .gte=` 、` .lte=` 。  

#### 查询参数

| 参数 | 必需 | 描述 |
| - | - | - |
| qopts.columns | 否 | 过滤列。如果想查询多列，列名用逗号分隔。 |
| qopts.export | 否 | 对大查询很有帮助。数据将导出为压缩csv的zip文件已用于下载。 |
| qopts.per_page | 否 | 单页显示行数，最大为10000行。 |
| qopts.cursor_id | 否 | 每个API调用将返回用于表示表下一页的游标ID。在API中包含此游标ID则可以查询表的下一页。空游标ID代码当前页为表的最后一页。 |

导出PRICES全表：  
![Quandl exportDatatable](/images/2017/05/Quandl_exportDatatable.png)
过滤mapcode为-5370、compnumber为39102且reporttype为A的行，输出表的reportdate和amount列：  
![Quandl queryDatatable](/images/2017/05/Quandl_queryDatatable.png)

### 参考
* * *
[Quandl官网](https://www.quandl.com/)  
[Quandl API文档](https://docs.quandl.com/)  
