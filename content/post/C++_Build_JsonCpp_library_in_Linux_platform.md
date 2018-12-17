---
title: '[C++] Build JsonCpp library in Linux platform'
date: 2017-03-22 05:47:27
categories: 
- C++
tags: 
- jsoncpp
- g++
- ar
- C++
---

```
wget https://github.com/open-source-parsers/jsoncpp/archive/1.8.0.tar.gz
tar xzvf 1.8.0.tar.gz
cd jsoncpp-1.8.0/src/lib_json
g++ -g -std=c++11 -Wall -fPIC -c -I../../include json_reader.cpp json_value.cpp json_writer.cpp
ar rvs libjsoncpp.a *.o
g++ -g json_reader.o json_writer.o json_value.o -shared -o libjsoncpp.so
```

