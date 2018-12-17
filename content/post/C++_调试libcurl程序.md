---
title: '[C++] 调试libcurl程序'
date: 2016-12-25 21:22:31
categories: 
- C++
tags: 
- C++
- libcurl
- debug
- dump
---
最近在调试通过libcurl发送GoogleSheets API POST请求时，增加了一点经验，特此总结。

### GoogleSheets API 请求

```
POST /v4/spreadsheets?access_token={YOUR_ACCESSTOKEN}&fields=spreadsheetId HTTP/1.1
Host: sheets.googleapis.com
Content-Type: application/json;charset=UTF-8
Accept: application/json
Cache-Control: no-cache

{"properties":{"title":"newhaha"},"sheets":[{"properties":{"title":"Sheet1"}}]}
```

### libcurl调试

当GoogleSheets API 请求失败时，仅能获得返回的状态码和消息。感觉没有更多信息可以研究！后来通过CURLOPT_VERBOSE和CURLOPT_DEBUGFUNCTION获得了更多调试信息。
#### 使用CURLOPT_VERBOSE
```
curl_easy_setopt(m_curl, CURLOPT_VERBOSE, 1L);
```
![libcurl: CURLOPT_VERBOSE](/images/2016/12/libcurl-CURLOPT_VERBOSE.png)这样就可以看到请求报头、响应报头和消息体了。
#### 使用CURLOPT_DEBUGFUNCTION
使用libcurl API指南中[CURLOPT_DEBUGFUNCTION](https://curl.haxx.se/libcurl/c/CURLOPT_DEBUGFUNCTION.html)示例代码即可。![libcurl: CURLOPT_DEBUGFUNCTION](/images/2016/12/libcurl-CURLOPT_DEBUGFUNCTION.png)这样就可以看到完整的请求和响应内容了。



