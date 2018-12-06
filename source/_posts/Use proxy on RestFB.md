---
title: 'Use proxy on RestFB'
date: 2016-04-04 06:18:35
categories: 
- DataBuilder
tags: 
- restfb
- proxy
- facebook
- defaultfacebookclien
- defaultwebrequestor
---
曾经有人向RestFB开过issue（[https://github.com/restfb/restfb/issues/116](https://github.com/restfb/restfb/issues/116)）询问如何给其设置代理，issue里回复扩展DefaultWebRequestor。下面的代码基于该方案并测试通过。
```
package com.yqu.restfb;

import com.restfb.DefaultFacebookClient;
import com.restfb.DefaultJsonMapper;
import com.restfb.FacebookClient;
import com.restfb.Version;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;

public class HelloRestFBWithProxy {
  private static class DefaultWebRequestor extends com.restfb.DefaultWebRequestor {

    protected HttpURLConnection openConnection(URL url) throws IOException {
      HttpURLConnection httpURLConnection = null;
      if (useProxyFlag.booleanValue()) {
        InetSocketAddress proxyLocation = new InetSocketAddress(
            hostName, port);
        Proxy proxy = new Proxy(Proxy.Type.HTTP, proxyLocation);
        try {
          httpURLConnection = (HttpURLConnection) url
              .openConnection(proxy);
          return httpURLConnection;
        } catch (Exception e) {
          return (HttpURLConnection) url.openConnection();
        }
      } else {
        return (HttpURLConnection) url.openConnection();
      }
    }

    private Boolean useProxyFlag;
    private String hostName;
    private int port;

    protected DefaultWebRequestor(Boolean useProxyFlagIn, 
                                            String hostNameIn, int portIn) {
      useProxyFlag = useProxyFlagIn;
      hostName = hostNameIn;
      port = portIn;
    }
  }

  public static void main(String[] args) {
    String accessToken = "XXXX";
    String appSecret = "XXXX";
    String proxyHost = "XXXX";
    int proxyPort = 80;

    FacebookClient facebookClient = new DefaultFacebookClient(accessToken,
        appSecret, new DefaultWebRequestor(
        true, proxyHost, proxyPort),
        new DefaultJsonMapper(), Version.UNVERSIONED);
  }
}
```
