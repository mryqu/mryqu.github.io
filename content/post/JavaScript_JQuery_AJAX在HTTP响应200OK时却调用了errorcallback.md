---
title: '[JavaScript] JQuery AJAX在HTTP响应200OK时却调用了errorcallback'
date: 2014-05-25 08:02:32
categories: 
- FrontEnd
tags: 
- javascript
- jquery
- ajax
- 200ok
- errorcallback
---
运行如下代码时，从结果看操作成功，但是总是调用错误处理回调。
```
myTest = function(server, lib, table, reqParam, 
            reqInfo, successCallback, errorCallback) {
  var url = "http://localhost/mytest/" + 
            encodeURIComponent(server) + 
            "/libs/" +
            encodeURIComponent(lib) + 
            "/tables/" + 
            encodeURIComponent(table);
  
  if (reqParam!=undefined && reqParam) {
    url += "?reqParam=" + encodeURIComponent(reqParam);
  }
  
  $.ajax({
    cache: false,
    url: url,
    type: "PUT",
    data: JSON.stringify(reqInfo),
    contentType: "application/json",
    success: function (data) {
      if (successCallback!==undefined && successCallback) {
        successCallback(data);
      } else {
        console.log("success:"+JSON.stringify(data));
      }
    },
    error: function (xhr, status, error) {
      if (errorCallback!==undefined && errorCallback) {
        errorCallback(xhr, status, error);
      } else {
        console.log("error:"+JSON.stringify(xhr));
      }
    }
  });
};
```
![JavaScript: JQuery AJAX在HTTP响应200OK时却调用了errorcallback](/images/2014/5/0026uWfMzy72OzRdsOja7.jpg)
响应码为200OK，表明操作成功，此外也没见到`"timeout"`、`"error"`、`"abort"`和`"parsererror"` 这些错误。但是消息体内仅为一个字符串，而不是json数据。尝试设置dataType:"text"，结果调用了successCallback，成功！
```
myTest = function(server, lib, table, reqParam, 
            reqInfo, successCallback, errorCallback) {
  var url = "http://localhost/mytest/" + 
            encodeURIComponent(server) + 
            "/libs/" +
            encodeURIComponent(lib) + 
            "/tables/" + 
            encodeURIComponent(table);
  
  if (reqParam!=undefined && reqParam) {
    url += "?reqParam=" + encodeURIComponent(reqParam);
  }
  
  sas.ajax({
    cache: false,
    url: url,
    type: "PUT",
    data: JSON.stringify(reqInfo),
    dataType: "text",
    contentType: "application/application/json",
    success: function (data) {
      if (successCallback!==undefined && successCallback) {
        successCallback(data);
      } else {
        console.log("success:"+JSON.stringify(data));
      }
    },
    error: function (xhr, status, error) {
      if (errorCallback!==undefined && errorCallback) {
        errorCallback(xhr, status, error);
      } else {
        console.log("error:"+JSON.stringify(xhr));
      }
    }
  });
};
```
