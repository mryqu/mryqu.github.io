---
title: '[C++] Building twitcurl Library in Unix platform'
date: 2015-12-19 05:47:33
categories: 
- DataBuilder
- C++
tags: 
- build
- twitcuil
- library
- unix
- C++
---
- Download twitcurl source from [https://github.com/swatkat/twitcurl](https://github.com/swatkat/twitcurl) using Git client.
  ```
  git clone https://github.com/swatkat/twitcurl.git
  ```
- In Unix shell, cd into libtwitcurl directory.
- Compile all of the twitcurlsource files into object files.
  ```
  g++ -Wall -fPIC -c -I. twitcurl.cpp oauthlib.cpp urlencode.cpp base64.cpp HMAC_SHA1.cpp SHA1.cpp
  ```
- **Building twitcurl asstatic library:** Use the archive commandto build twitcurl library from object files.
  ```
  ar rvs libtwitcurl.a *.o
  ```