---
title: "Spring3 REST can't solve list of object generated by Javascript"
date: 2015-01-16 21:21:44
categories: 
- Service+JavaEE
- Spring
tags: 
- spring
- rest
- json
- javascript
- 解析
---
最近遭遇Spring3REST无法解析对象数组这么一个问题。为了排除客户端Javascript代码嫌疑，我通过GET操作从Spring RestfulWeb服务获取一个复杂对象，然后通过POST操作将其原封不动返给Spring Restful Web服务，问题依旧重现。

### 客户端代码

```
var meatadata='[{"varName":"id","varTitle":"The Id","varIndex":1},{"varName":"name","varTitle":"The Name","varIndex":2},{"varName":"age","varTitle":"The Age","varIndex":3}]';
$.ajax({
 url: "configure",
 type: "POST",
 data: metadata,
 dataType: "json",
 contentType: "application/json",
 success: function (res) {
  $('#cfgContent').text(JSON.stringify(res));
  $('#cfgError').text("");
 },
 error: function (res) {
  $('#cfgContent').text("");
  $('#cfgError').text(res.responseText);    
 }
});
```

### 中间层代码

```
package com.yqu.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@RestController
public class ConfigurationController {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  public ModelAndView home(Model m){
    System.out.println("home");
    return new ModelAndView("index");
  }

  @RequestMapping(value = "/configure", method = RequestMethod.GET)
  public @ResponseBody
  List getConfiguration() {
    List columns = new ArrayList();

    columns.add(new ColumnVO("id","The Id",1));
    columns.add(new ColumnVO("name","The Name",2));
    columns.add(new ColumnVO("age","The Age",3));

    System.out.println("getConfiguration:"+columns);
    return columns;
  }

  @RequestMapping(value = "/configure", method = RequestMethod.POST)
  public @ResponseBody
  List setConfiguration(@RequestBody List columns) {
    System.out.println(columns);
    return columns;
  }
}
```

### 中间层异常

```
java.lang.ClassCastException: java.util.LinkedHashMap cannot be cast to com.yqu.rest.ColumnVO
```

### 问题原因

通过阅读参考帖子，可知：public @ResponseBody List setConfiguration(@RequestBody List columns)在编译后经过泛型擦除就变成了public @ResponseBody List setConfiguration(@RequestBody List columns)而Jackson为List解编的默认类型是LinkedHashMap。

### 解决方案

Spring4已经解决了这一问题。在Spring3中，需要增加一个封装类**<font color="#FF0000">class ColumnVOList extends ArrayList {}</font>**

### 参考

[receiving json and deserializing as List of object at spring mvc controller](http://stackoverflow.com/questions/23012841/receiving-json-and-deserializing-as-list-of-object-at-spring-mvc-controller)  