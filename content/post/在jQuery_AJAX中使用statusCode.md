---
title: '在jQuery AJAX中使用statusCode'
date: 2015-08-05 05:49:50
categories: 
- 前端
tags: 
- jquery
- ajax
- statuscode
- javascript
- html5
---
[jQuery.ajax](https://api.jquery.com/jQuery.ajax/)中提供了statusCode设置，以便根据响应状态值进行相应处理。
```
var data = JSON.stringify({
    name: "mryqu",
    count: 123
});

$.ajax({
    //cache: false,
    url: "/test",
    type: "post",
    contentType: "application/json",
    dataType: "json",
    data: data,
    beforeSend: function (xhr) {
        console.log("beforeSend called");
    },
    statusCode: {
        401: function() {
            console.log("statusCode 401 called");
        },
        449: function() {
            console.log("statusCode 449 called");
        }
    },
    error: function (oResult, textStatus, errorThrown) {
        if (oResult.status !==401 && oResult.status !==449) {
            console.log("error called");
        }
    },
    success: function (oResult) {
        console.log("success called");
    }
});
```

有时候发现statusCode不被调用，所以我更喜欢用下面这种更保险的方式。
```
var data = JSON.stringify({
    name: "mryqu",
    count: 123
});

$.ajax({
    //cache: false,
    url: "/test",
    type: "post",
    contentType: "application/json",
    dataType: "json",
    data: data,
    beforeSend: function (xhr) {
        console.log("beforeSend called");
    },
    error: function (oResult, textStatus, errorThrown) {
        if (oResult.status ===401) {
            console.log("statusCode 401 called");
        } else if (oResult.status ===449) {
            console.log("statusCode 449 called");
        } else {
            console.log("error called");
        }
    },
    success: function (oResult) {
        console.log("success called");
    }
});
```

### 参考

[jQuery.ajax()](http://api.jquery.com/jquery.ajax/)  
[jQuery ajax - avoiding error() callback when statusCode() callback invoked](http://stackoverflow.com/questions/9465067/jquery-ajax-avoiding-error-callback-when-statuscode-callback-invoked)  