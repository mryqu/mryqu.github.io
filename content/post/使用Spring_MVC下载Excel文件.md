---
title: '使用Spring MVC下载Excel文件'
date: 2014-01-20 21:29:48
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- mvc
- excel
- download
- rest
---
想使用Spring MVC下载Excel文件，照着下面的样例，很容易就实现了。
[ Spring MVC with Excel View Example (Apache POI and JExcelApi)](http://www.codejava.net/frameworks/spring/spring-mvc-with-excel-view-example-apache-poi-and-jexcelapi)  
[ Spring MVC and Excel file via AbstractExcelView](http://www.mkyong.com/spring-mvc/spring-mvc-export-data-to-excel-file-via-abstractexcelview/)  

### 问题一：数据仅能生成xls，不能生成xlsx
通过[org.springframework.web.servlet.view.document.AbstractExcelView源代码](http://grepcode.com/file/repository.springsource.com/org.springframework/org.springframework.web.servlet/3.2.5/org/springframework/web/servlet/view/AbstractView.java)可知，Spring的AbstractExcelView仅支持HSSFWorkbook，不支持XSSFWorkbook。这一问题可以通过Github上的hmkcode/Spring-Framework来解决。
[ com.hmkcode.view.abstractview.AbstractExcelView](https://github.com/hmkcode/Spring-Framework/blob/master/spring-mvc-json-pdf-xls-excel/src/main/java/com/hmkcode/view/abstractview/AbstractExcelView.java)  
[ com.hmkcode.view.ExcelView](https://github.com/hmkcode/Spring-Framework/blob/master/spring-mvc-json-pdf-xls-excel/src/main/java/com/hmkcode/view/ExcelView.java)  

### 问题二：下载的文件是我配置的视图路径export.do，而不是Excel后缀
通过在Rest Controller里添加如下代码解决：
```
SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd_HHmmss"); 
response.setHeader("Pragma", "public");
response.setHeader("Cache-Control", "max-age=0");

if(excelVersion.equals("xlsx")){
  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
  response.setHeader("Content-Disposition", "attachment; filename=test"+myFmt.format(new Date())+".xlsx");
}else{
  response.setContentType("application/vnd.ms-excel");
  response.setHeader("Content-Disposition", "attachment; filename=\"test"+myFmt.format(new Date())+".xls\"");
}
```
