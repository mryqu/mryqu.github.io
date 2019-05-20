---
title: '初探Salesforce API'
date: 2019-05-17 06:00:05
categories: 
- DataBuilder
tags: 
- salesforce
- api
- soap
- rest
---
最近研究一下如何从[Salesforce](https://www.salesforce.com/)抓取数据，首先看了一下几个ODBC driver。  
* [DataDirect](https://www.progress.com/connectors/salesforce)   [文档](http://media.datadirect.com/download/docs/odbc/allodbc/index.html#page/odbc%2Fwelcome-to-datadirect-connect-for-odbc.html%23)   
* [easysoft](https://www.easysoft.com/products/data_access/odbc-salesforce-driver/index.html)  
* [devart](https://www.devart.com/odbc/salesforce/download.html)  
* [cdata](https://www.cdata.com/drivers/salesforce/odbc/)  

怎么没有[Salesforce](https://www.salesforce.com/)自家的驱动，都是第三方的。  
再找找看，找到了Salesforce [SOAP API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.218.0.api.meta/api/sforce_api_quickstart_intro.htm)和[REST API Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_what_is_rest_api.htm)。  
既然有了SOAP/REST API，何必再看ODBC driver了。  

