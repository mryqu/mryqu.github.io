---
title: 'Hello Google Sheets API'
date: 2016-09-28 06:00:05
categories: 
- DataBuilder
tags: 
- google
- sheets
- api
- crawler
- storage
---
### 准备环境

首先在Google Sheets创建了SpreadSheetTest1和To-do list两个电子表格，以备使用。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75LGFfmkk5c.jpg)![Hello Google Sheets API](/images/2016/9/0026uWfMzy75M2vtY5Wa8.jpg)
### API测试

#### 方法spreadsheets.get测试
方法spreadsheets.get可以获得一个电子表格中所有表单的内容和元数据。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75LHT3Wzjad.jpg)
下面是用Postman进行同样操作：
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75LIAEVtqc4.jpg)
#### 方法spreadsheets.values.get测试
方法spreadsheets.values.get可以获得一个电子表格中所有表单的内容。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75LIX1E0T3f.jpg)
#### 方法spreadsheets.create测试
方法spreadsheets.create可以创建一个新的电子表格。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75M2LkUE828.jpg)
查看GoogleSheets，也可以看到新创建的电子表格SpreadSheetCreate1。由于我的请求里没有数据，因此下图中数据区也是空空。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75M2M3Aiv33.jpg)
#### 方法spreadsheets.values.append测试
方法spreadsheets.values.append可以向电子表格中添加内容。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75M44XNV2fc.jpg)
查看Google Sheets，也可以看到刚才创建的电子表格SpreadSheetCreate1有了九个单元格新数据。
![Hello Google Sheets API](/images/2016/9/0026uWfMzy75M4613UJ21.jpg)

### 学习结论

Google Sheets API可以创建、读取和修改电子表格，但是没有找到删除电子表格的方法。
Google SheetsAPI可以创建、读取、修改和删除一个电子表格内容，例如方法spreadsheets.batchUpdate中deleteSheet就可以删除一个表单，而deleteDimension就可以删除一个表单中的行/列。

### 参考

[Google Sheets](https://docs.google.com/spreadsheets/)    
[Google Sheets API](https://developers.google.com/sheets/)    
[Google API Explorer: Sheets](https://developers.google.com/apis-explorer/#p/sheets/v4/)    