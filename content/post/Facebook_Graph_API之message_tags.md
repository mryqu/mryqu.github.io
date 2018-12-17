---
title: 'Facebook Graph API之message_tags'
date: 2016-01-05 06:38:10
categories: 
- DataBuilder
tags: 
- facebook
- graph
- message_tags
- post
- comment
---
message_tag是Facebook帖子和评论中消息标记的设置档，包括标记ID、文本、类型、偏移和长度。
今天才注意到Facebook帖子（[Post](https://developers.facebook.com/docs/graph-api/reference/v2.5/post)）中message_tag是一个JSON对象，而评论（[Comment](https://developers.facebook.com/docs/graph-api/reference/v2.5/object/comments)）中message_tag是一个JSON数组。

帖子中的message_tag是这个样子的：
```
"message_tags": {
  "88": [
    {
      "id": "168597536563870",
      "name": "IBM",
      "type": "page",
      "offset": 88,
      "length": 3
    }
  ],
  "93": [
    {
      "id": "241760048297",
      "name": "Fidelity Investments",
      "type": "page",
      "offset": 93,
      "length": 20
    }
  ],
  "115": [
    {
      "id": "145619362306025",
      "name": "ABB",
      "type": "page",
      "offset": 115,
      "length": 3
    }
  ],
  "120": [
    {
      "id": "252467906271",
      "name": "Quintiles",
      "type": "page",
      "offset": 120,
      "length": 9
    }
  ],
  "131": [
    {
      "id": "193453547355388",
      "name": "SAS Software",
      "type": "page",
      "offset": 131,
      "length": 12
    }
  ],
  "161": [
    {
      "id": "702317053131576",
      "name": "Duke Energy",
      "type": "page",
      "offset": 161,
      "length": 11
    }
  ],
  "174": [
    {
      "id": "313176732094295",
      "name": "Toshiba Global Commerce Solutions",
      "type": "page",
      "offset": 174,
      "length": 33
    }
  ],
  "209": [
    {
      "id": "20531316728",
      "name": "Facebook",
      "type": "page",
      "offset": 209,
      "length": 8
    }
  ]
}
```

评论中的message_tag是这个样子的：
```
"message_tags": [
  {
    "id": "10101999889432459",
    "length": 16,
    "name": "Crystal Sullivan",
    "offset": 10,
    "type": "user"
  },
  {
    "id": "10152592598848593",
    "length": 16,
    "name": "Chris Hemedinger",
    "offset": 27,
    "type": "user"
  }
]
```
