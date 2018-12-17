---
title: '为cURL库设置HTTP代理的代码片段'
date: 2016-01-06 06:01:08
categories: 
- DataBuilder
- C++
tags: 
- curl
- library
- http
- proxy
- C++
---
在[twitcurl](https://github.com/swatkat/twitcurl)看到cURL库设置http代理的方法，记录一下。
```
void twitCurl::prepareCurlProxy()
{
  if( m_curlProxyParamsSet )
  {
    return;
  }

  curl_easy_setopt( m_curlHandle, CURLOPT_PROXY, NULL );
  curl_easy_setopt( m_curlHandle, CURLOPT_PROXYUSERPWD, NULL );
  curl_easy_setopt( m_curlHandle, CURLOPT_PROXYAUTH, (long)CURLAUTH_ANY );
  
  std::string proxyIpPort("");
  if( getProxyServerIp().size() )
  {
    utilMakeCurlParams( proxyIpPort, getProxyServerIp(), getProxyServerPort() );
  }
  curl_easy_setopt( m_curlHandle, CURLOPT_PROXY, proxyIpPort.c_str() );

  
  if( m_proxyUserName.length() &amp;&amp; m_proxyPassword.length() )
  {
    std::string proxyUserPass;
    utilMakeCurlParams( proxyUserPass,getProxyUserName(),getProxyPassword() );
    curl_easy_setopt( m_curlHandle,CURLOPT_PROXYUSERPWD,proxyUserPass.c_str() );
  }
  
  m_curlProxyParamsSet = true;
}
```