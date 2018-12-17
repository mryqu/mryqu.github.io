---
title: '了解OSM和Esri'
date: 2015-04-22 00:15:13
categories: 
- Tech
tags: 
- geographic
- mapping
- openstreatmap
- esri
---
学习SAS Visual Analytics Explorer时看到了地图提供程序模式竟然没有GoogleMap，而是OpenStreetMap和Esri。对没接触过的东东还比较好奇，搜了一下。

### OpenStreetMap

开放街道地图（OpenStreetMap，简称OSM）是一个由地图制作爱好者组成的社区。这些爱好者提供并维护世界各地关于道路、小道、咖啡馆、铁路车站等各种各样的数据，目标是创造一个内容自由且能让所有人编辑的世界地图，并且让一般便宜的移动设备有方便的导航方案。OSM项目由英国人SteveCoast创立，概念启发自维基百科网站，以及英国以及其他地区私有地图数据占尽优势。一如维基百科等网站，OSM网站地图页有“编辑”按钮，亦有纪录修订历史。经注册的用户可上传GPS路径，及可编辑地图的矢量数据，包括使用OSM网站的编辑器或其他自由地理信息系统软件，如JOSM。OSM的地图由用户根据手持GPS设备、航空摄影照片、卫星视频、其他自由内容以至单靠用户由于对有关区域的熟悉而具有的本地知识绘制。地图的矢量数据以开放数据库授权方式授权。OSM网站由英国非营利组织OpenStreetMap基金会赞助维运。

既然有Google和Nokia这样的公司提供很好的地图商业产品，那为什么还需要一个像OpenStreetMap项目了？答案是简单的，作为一个社会，不应当有一家或几家公司在地理信息上进行垄断。地理信息是分享资源，当你将所有的这些权力给予一个单独的实体，你给予他们的权力就不止是告诉他们你的地理位置，更是在塑造它，从自己商业利益的角度显示地图上的内容。而在地图内容方面，OpenStreetMap即是中立的又是透明的。

### Esri

美国环境系统研究所公司（Environmental Systems Research Institute,Inc.，简称Esri），是目前世界最大的地理信息系统技术供应商，其地理信息系统软件目前的全球市场占有率最高，公司最知名产品为ArcGIS。ArcGISOnline是一个面向全球用户的公有云GIS平台，是一种全新的GIS软件应用模式。ArcGISOnline包含了全球范围内的底图、地图数据、应用程序，以及可配置的应用模板和开发人员使用的 GIS 工具和 API，可用于创建Web 地图、发布GIS服务、共享地图、数据和应用程序等，以及管理组织的内容和多个用户。

SAS Visual Analysis Explorer里面在Esri模式下还需要选择ArcGISOnline的数据源（例如World Cities、World Street Map）。

### 参考

[OpenStreetMap网站](https://www.openstreetmap.org)    
[Esri公司](http://www.esri.com/)    
[Wiki: 开放街图](http://zh.wikipedia.org/wiki/%E9%96%8B%E6%94%BE%E8%A1%97%E5%9C%96)    
[为什么世界需要 OpenStreetMap 开源道路地图](http://www.oschina.net/news/47621/why-we-need-openstreetmap)    
[Wiki: 美国环境系统研究所公司](http://zh.wikipedia.org/wiki/%E7%BE%8E%E5%9C%8B%E7%92%B0%E5%A2%83%E7%B3%BB%E7%B5%B1%E7%A0%94%E7%A9%B6%E6%89%80%E5%85%AC%E5%8F%B8)    