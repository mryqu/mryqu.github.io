---
title: '玩玩ArcGIS REST API'
date: 2017-05-19 05:49:55
categories: 
- DataBuilder
tags: 
- esri
- arcgis
- rest
- api
- geocode
- geoenrichment
---
### 了解Esri和ArcGIS

美国环境系统研究所公司（Environmental Systems Research Institute, Inc. 简称Esri公司）成立于1969年，总部设在美国加利福利亚州雷德兰兹市，是世界最大的地理信息系统技术提供商。
ArcGIS是Esri公司集40余年地理信息系统（GIS）咨询和研发经验，奉献给用户的一套完整的GIS平台产品，具有强大的地图制作、空间数据管理、空间分析、空间信息整合、发布与共享的能力。

### ArcGIS REST API

[ArcGIS REST API](http://resources.arcgis.com/en/help/arcgis-rest-api/)可用于包括ArcGIS Online在内的ArcGIS平台，包括：
*   [Maps](http://resources.arcgis.com/en/help/arcgis-rest-api/02r3/02r3000001mt000000.htm)—随时可用的底图、参考层等。可用于快速为您的本地或全球数据添加上下文或背景。一些ArcGIS Online地图有页面主题，可以提供出你的应用所需的全部信息。
*   [World Geocoding Service](https://developers.arcgis.com/rest/geocode/)—通过文本地址、商业名等查找位置，该服务也提供反向服务：通过地理坐标查找最近的地址。
*   [Directions and Routing Service (Network Analysis Service)](http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Overview_of_network_analysis_services/02r30000001s000000/)—解决各种路线规划问题，例如简单的点到点路由、复杂的船舶航线规划、及行驶时间分析。
*   [GeoEnrichment Service](https://developers.arcgis.com/rest/geoenrichment/)—GeoEnrichment 服务借助本地化的人口、场所以及商业信息丰富了用户的地理数据。提交某个点、面、地址或地名后，可通过该服务了解该地区居民的生活习惯和生活方式、附近的商业类型以及区域邮政编码等信息。
*   [Spatial Analysis Service](https://developers.arcgis.com/rest/analysis/)—各种可用于执行通用GIS分析的任务。传统上，包括查找热点和对周边汇总在内的许多任务都需要深度学习和专业知识才能运行。而这些空间分析任务仅包含少量需要研究的参数，也能获得相当不错的结果。
*   [Elevation Analysis service](https://developers.arcgis.com/rest/elevation/)—高程分析服务允许您执行高程分析（轮廓，视角，总结高程）和水文分析（流域和跟踪下游）的各种操作。这些服务参考的数据由Esri托管和策划。

ArcGIS REST API有些是免费的，有些是付费。付费操作需要[订阅ArcGIS Online](http://www.arcgis.com/features/plans/pricing.html)，并减扣账户[积分](http://links.esri.com/service-credits-overview)。
![ArcGIS Dev Dashboard](/images/2017/05/ArcGISDevDashboard.png)使用需付费API时，需要在请求中通过token参数指定访问令牌。获取ArcGIS REST API所需访问令牌的方法，请参见前一博文[ArcGIS认证和登录](/post/arcgis认证和登录)。

#### 响应数据格式

对于ArcGIS REST API，有些响应支持JSON、PJSON（个人理解就是完美打印版的JSON）、XML和BIN格式中的一种或多种。可在请求时通过f参数指定。

### 使用GeoEnrichment API

GeoEnrichment服务能力、属性和限制可以通过下列请求获得：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/geoenrichmentserver/GeoEnrichment/?f=pjson
```
![GeoEnrichment Test](/images/2017/05/GeoEnrichmentTest.png)  
由响应可知，GeoEnrichment端点支持Enrich、CreateReport、Reports、Countries、DataCollections、StandardGeographyLevels这几种操作。

#### Countries操作
首先试一下国家列表：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/GeoenrichmentServer/Geoenrichment/Countries?f=pjson
```
![Geoenrichment/Countries Test](/images/2017/05/Geoenrichment_Countries_Test.png)  
当然Countries操作也可用于获取单个国家信息：
![Geoenrichment/Countries/US Test](/images/2017/05/Geoenrichment_Countris_US_Test.png)  
#### [StandardGeographyLevels](https://developers.arcgis.com/rest/geoenrichment/api-reference/standard-geography-query.htm)操作
StandardGeographyLevels服务返回有效地理数据层列表。服务结果是BAIDNamePairs数组，包含数据层ID及相应名称。这些ID可被用于在其他分析中指定数据层。
下面的请求示例列举CN的有效地理数据层列表：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/GeoenrichmentServer/Geoenrichment/StandardGeographyLevels/CN?f=pjson
```
![Geoenrichment/StandardGeographyLevels/CN Test](/images/2017/05/Geoenrichment_StandardGeographyLevels_CN_Test.png)  
#### [DataCollections](https://developers.arcgis.com/rest/geoenrichment/api-reference/data-collections.htm)操作
GeoEnrichment服务使用数据集合的概念定义服务返回的属性。更具体地说，数据集合是用于丰富输入特性的预先组合的属性列表。作为输入特性，集合属性可以描述所提交位置或区域的各种类型信息，例如人口特征和地理上下文。
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/geoenrichmentserver/Geoenrichment/dataCollections?f=pjson
```
![Geoenrichment/dataCollections Test](/images/2017/05/Geoenrichment_dataCollections_Test.png)  
#### [Reports和CreateReport](https://developers.arcgis.com/rest/geoenrichment/api-reference/create-report.htm)操作
创建报告操作可为描述输入区域的各种用例创建各种高质量报告。如果使用一个点作为研究区域，该服务将围绕该点创建1英里的环形缓冲区以收集和附加丰富数据。或者，您可以围绕该点创建环形缓冲区或特定驾驶时间可达区域，生成包含有关人口特征、消费者支出、业务或市场潜力等相关信息的PDF或Excel报告。
报告选项可用于描述和更好地了解市场，顾客/客户以及特定领域商业竞争。
下面的请求示例列举US数据集中有效报告列表：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/geoenrichmentserver/Geoenrichment/Reports/US?f=pjson
```
下面的请求示例生成以坐标-117.1956、34.0572为中心一英里区域的人口和收入概况报告(report指定为dandi，从上一示例结果中可知为人口和收入概况报告)：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/geoenrichmentserver/GeoEnrichment/CreateReport?studyAreas=[{"geometry":{"x":-117.1956,"y":34.0572}}]&report=dandi&f=bin&format=PDF&token={YOUR_TOKEN}
```
![GeoEnrichment/CreateReport Test](/images/2017/05/GeoEnrichment_CreateReport_Test.png)  
#### [Enrich](https://developers.arcgis.com/rest/geoenrichment/api-reference/geoenrichment-service-overview.htm)操作
提供地点或区域的事实数据。输入可为：
*   XY左边：例如studyAreas=[{"geometry":{"x":-117.1956,"y":34.0572}}]
*   多边形：例如[{"geometry":{"rings":[[[-117.185412,34.063170],[-122.81,37.81],[-117.200570,34.057196],[-117.185412,34.063170]]],"spatialReference":{"wkid":4326}},"attributes":{"id":"1","name":"optional polygon area name"}}]
*   命名统计区域：例如studyAreas=[{"sourceCountry":"US","layer":"US.ZIP5","ids":["92373","92129"]}]
*   网络服务区域：  
    例如studyAreas=[{"geometry":{"x": -122.435, "y": 37.785},"areaType": "NetworkServiceArea","bufferUnits": "Hours","bufferRadii": [1],"travel_mode":"Driving"}]  
    例如studyAreas=[{"geometry":{"x": -122.435, "y": 37.785},"areaType": "NetworkServiceArea","bufferUnits": "Minutes","bufferRadii": [10],"travel_mode":"Walking"}]
*   街道名称定位：例如studyAreas=[{"address":{"text":"380 New York St. Redlands, CA 92373"}}]

下面的请求示例请求坐标-117.1956、34.0572的事实数据：
```
http://geoenrich.arcgis.com/arcgis/rest/services/World/geoenrichmentserver/GeoEnrichment/enrich?studyareas=[{"geometry":{"x":-117.1956,"y":34.0572}}]&f=pjson&token={YOUR_TOKEN}
```
![GeoEnrichment/enrich Test](/images/2017/05/GeoEnrichment_enrich_Test.png)  

### 使用Geocoding API

Geocoding国家列表、属性和服务能力可以通过下列请求获得：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/?f=pjson
```
![GeocodeServer Test](/images/2017/05/GeocodeServer_Test.png)  
由[Free vs. paid operations](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-free-vs-paid.htm)可知，Geocoding API支持suggest（免费）、findAddressCandidates和reverseGeocode（免费或付费）、geocodeAddresses（付费）这几种操作。
#### [suggest](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-suggest.htm)操作
Geocoding服务的suggest操作可为客户端应用提供输入自动完成建议。当我们不知道恰当目标名或地址时，可以通过suggest操作进行查找。findAddressCandidates操作的大部分请求也可以用suggest操作完成。
下面的请求示例查找坐标（-78.765460000000004、35.829056999999999）20公里内的宾馆，从中可以发现我住过的Embassy Suites-Raleigh Durham：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/suggest?text=hotel&location=-78.765460000000004,35.829056999999999&distance=20000&f=pjson
```
![GeocodeServer/suggest Test](/images/2017/05/GeocodeServer_suggest_Test.png)  
#### [findAddressCandidates](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-find-address-candidates.htm)操作
findAddressCandidates用于在一个请求中查找一个地址的Geo代码。地址可为街道名、名胜、官方地名、邮编或X/Y坐标。
下面的请求示例查找Cary市内的SAS，返回SAS园区信息：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/findAddressCandidates?Address=SAS&City=Cary&outFields=*&forStorage=false&f=pjson
```
![GeocodeServer/findAddressCandidates Test](/images/2017/05/GeocodeServer_findAddressCandidates_Test.png)  
下面的示例先通过suggest获取中国的国际机场，然后显示北京首都国际机场的Geo代码：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/suggest?text=国际机场&countryCode=CHN&f=pjson
```
![GeocodeServer/suggest Test2](/images/2017/05/GeocodeServer_suggest_Test2.png)  
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/findAddressCandidates?&singleLine=Airport&magicKey=GST7YMc0AM9UOsE9HhFtGTyVGST7YMc0AM9UOsE9DbTVHgA9HhB0Zcp0OhNtGMytaikZUsoAMsxGUoc4Hhp0OSTaSsEqAZ43AP9zJikuGPAmIYxQGPT-CZc0YiD7DsK7CZyAOh5-Dn47Z57ZJsF1&maxLocations=10&outFields=Match_addr,Place_addr,Type&f=pjson
```
![GeocodeServer/findAddressCandidates Test2](/images/2017/05/GeocodeServer_findAddressCandidates_Test2.png)  
#### [reverseGeocode](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-reverse-geocode.htm)操作
reverseGeocode通过X/Y坐标判断地址信息。下面的请求示例返回坐标（-78.765460000000004、35.829056999999999）的地址信息，即SAS园区：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/reverseGeocode?location=-78.765460000000004,35.829056999999999&distance=200&outSR=&f=pjson
```
![GeocodeServer/reverseGeocode Test](/images/2017/05/GeocodeServer_reverseGeocode_Test.png)  
#### [geocodeAddresses](https://developers.arcgis.com/rest/geocode/api-reference/geocoding-geocode-addresses.htm)操作
geocodeAddresses用于在一个请求中返回一列地址的Geo代码。下面的请求示例查找SAS园区和杜克大学的Geo代码：
```
http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/geocodeAddresses?addresses={"records":[{"attributes":{"OBJECTID":1,"Address":"100 SAS Campus Dr","City":"Cary","Region":"NC","Postal":"27513"}},{"attributes":{"OBJECTID":2,"Address":"Duke university","City":"Durham","Region":"NC","Postal":"27705"}}]}&sourceCountry=USA&token={YOUR_TOKEN}&f=pjson
```
![GeocodeServer/geocodeAddresses Test](/images/2017/05/GeocodeServer_geocodeAddresses_Test.png)  

### 参考
* * *
[Esri公司官网](http://www.esri.com/)  
[ArcGIS产品](http://www.arcgis.com/features/index.html)  
[ArcGIS功能](https://developers.arcgis.com/features/)  
[GitHub: Esri/geoenrichment-samples](https://github.com/Esri/geoenrichment-samples)  