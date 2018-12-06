---
title: 'cURL错误处理'
date: 2016-01-07 06:08:54
categories: 
- DataBuilder
- C++
tags: 
- curl
- error
- handling
- C++
---
cURL执行错误分为两种：
- 通过curl_easy_perform函数执行请求结果，返回值不是CURLE_OK。错误信息除了可以对照CURLcode定义查看，也可以通过设置CURLOPT_ERRORBUFFER设置错误缓存区获得人类易读的错误文字信息。范例见[https://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html](https://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html)
  ```
  curl = curl_easy_init();
  if(curl) {
    CURLcode res;
    char errbuf[CURL_ERROR_SIZE];
   
    curl_easy_setopt(curl, CURLOPT_URL, "http://example.com");
    curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, errbuf);  
    errbuf[0] = 0;
    res = curl_easy_perform(curl);
    
    if(res != CURLE_OK) {
      size_t len = strlen(errbuf);
      fprintf(stderr, "\nlibcurl: (%d) ", res);
      if(len)
        fprintf(stderr, "%s%s", errbuf,
                ((errbuf[len - 1] != '\n') ? "\n" : ""));
      else
        fprintf(stderr, "%s\n", curl_easy_strerror(res));
    }
  }
  ```
- 另一种是curl_easy_perform返回CURLE_OK，但是HTTP响应代码为400及以上的整数。HTTP响应代码可以通过curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE,&amp;httpCode)获得错误消息需要通过curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION,curlCallback)获得消息体后解析而得。