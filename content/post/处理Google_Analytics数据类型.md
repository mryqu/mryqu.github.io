---
title: '处理Google Analytics数据类型'
date: 2017-04-17 05:50:50
categories: 
- DataBuilder
tags: 
- google analytics
- api
- column
- data type
- format
---

### 发送一个Google Analytics请求

![GA Query For Data Type](/images/2017/04/GaQueryForDataType.png)

### 分析响应中的columnHeaders

响应中每一列头都包含数据类型信息，大致包含STRING、INTEGER、FLOAT、DATE、TIME、PERCENT、CURRENCY等。
```
{
  "kind": "analytics#gaData",
  "id": "https://www.googleapis.com/analytics/v3/data/ga?ids=ga:1XXXXX0&dimensions=ga:campaign,ga:source,ga:medium,ga:date&metrics=ga:users,ga:newUsers,ga:percentNewSessions,ga:sessions,ga:bounceRate,ga:avgSessionDuration,ga:pageviewsPerSession&start-date=30daysAgo&end-date=yesterday&max-results=0",
  "query": {
    "start-date": "30daysAgo",
    "end-date": "yesterday",
    "ids": "ga:1XXXXX0",
    "dimensions": "ga:campaign,ga:source,ga:medium,ga:date",
    "metrics": [
      "ga:users",
      "ga:newUsers",
      "ga:percentNewSessions",
      "ga:sessions",
      "ga:bounceRate",
      "ga:avgSessionDuration",
      "ga:pageviewsPerSession"
    ],
    "start-index": 1,
    "max-results": 0
  },
  "itemsPerPage": 0,
  "totalResults": 27400,
  "selfLink": "https://www.googleapis.com/analytics/v3/data/ga?ids=ga:1XXXXX0&dimensions=ga:campaign,ga:source,ga:medium,ga:date&metrics=ga:users,ga:newUsers,ga:percentNewSessions,ga:sessions,ga:bounceRate,ga:avgSessionDuration,ga:pageviewsPerSession&start-date=30daysAgo&end-date=yesterday&max-results=0",
  "nextLink": "https://www.googleapis.com/analytics/v3/data/ga?ids=ga:1XXXXX0&dimensions=ga:campaign,ga:source,ga:medium,ga:date&metrics=ga:users,ga:newUsers,ga:percentNewSessions,ga:sessions,ga:bounceRate,ga:avgSessionDuration,ga:pageviewsPerSession&start-date=30daysAgo&end-date=yesterday&start-index=1&max-results=0",
  "profileInfo": {
    "profileId": "1XXXXX0",
    "accountId": "1XXXXX8",
    "webPropertyId": "UA-XXXXXXX-1",
    "internalWebPropertyId": "1XXXX1",
    "profileName": "Corporate Site (Master Profile)",
    "tableId": "ga:1XXXXX0"
  },
  "containsSampledData": true,
  "sampleSize": "999951",
  "sampleSpace": "3174334", 
  "columnHeaders": [
    {
      "name": "ga:campaign",
      "columnType": "DIMENSION",
      "dataType": "STRING"
    },
    {
      "name": "ga:source",
      "columnType": "DIMENSION",
      "dataType": "STRING"
    },
    {
      "name": "ga:medium",
      "columnType": "DIMENSION",
      "dataType": "STRING"
    },
    {
      "name": "ga:date",
      "columnType": "DIMENSION",
      "dataType": "STRING"
    },
    {
      "name": "ga:users",
      "columnType": "METRIC",
      "dataType": "INTEGER"
    },
    {
      "name": "ga:newUsers",
      "columnType": "METRIC",
      "dataType": "INTEGER"
    },
    {
      "name": "ga:percentNewSessions",
      "columnType": "METRIC",
      "dataType": "PERCENT"
    },
    {
      "name": "ga:sessions",
      "columnType": "METRIC",
      "dataType": "INTEGER"
    },
    {
      "name": "ga:bounceRate",
      "columnType": "METRIC",
      "dataType": "PERCENT"
    },
    {
      "name": "ga:avgSessionDuration",
      "columnType": "METRIC",
      "dataType": "TIME"
    },
    {
      "name": "ga:pageviewsPerSession",
      "columnType": "METRIC",
      "dataType": "FLOAT"
    }
  ],
  "totalsForAllResults": {
    "ga:users": "2648520",
    "ga:newUsers": "1488536",
    "ga:percentNewSessions": "46.962349316341275",
    "ga:sessions": "3169637",
    "ga:bounceRate": "64.97214034288469",
    "ga:avgSessionDuration": "152.49400514948556",
    "ga:pageviewsPerSession": "2.0496252409976283"
  }
}
```

### 处理

根据Google Analytics数据类型，我们可以做相应的处理，例如设置SAS format和informat。

| GA DataType | SAS FORMAT | SAS INFORMAT | 
| - | - | - | 
| STRING | $ |   | 
| DATE | NLDATE20. | YYMMDD8. | 
| TIME | TIME20.0 |   |
| PERCENT | PERCENT32.2 |   | 
| CURRENCY | 32.2 |         | 

