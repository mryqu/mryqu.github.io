---
title: '安装Twurl并调试extended tweet mode'
date: 2018-02-08 13:55:35
categories: 
- DataBuilder
tags: 
- twurl
- extended
- tweet
- mode
---
在研究tweet字节限制由140字节变为280字节时，想要玩一玩Twitter API控制台工具([https://dev.twitter.com/rest/tools/console](https://dev.twitter.com/rest/tools/console))，结果dev.twitter.com跳到了developer.twitter.com，这才发现Twitter REST API按照Standard、Premium和Enterprise划分开始走上收费的道路。
Twitter API控制台工具已经找不到了，官方示例使用[twurl](https://github.com/twitter/twurl)命令工具完成的。

### 安装Twurl

1.  在https://rubyinstaller.org/下载并安装RubyInstaller
2.  执行gem install twurl

### 调试extended tweet mode

#### 准备环境
![Extended Tweet Mode](/images/2018/02/ExtendedTweetMode.jpg)

#### 认证

```
twurl authorize --consumer-key key --consumer-secret secret
```
#### 搜索tweet
```
twurl "/1.1/search/tweets.json?q=scnydq"

{
  "statuses": [
    {
      "created_at": "Thu Feb 08 02:22:11 +0000 2018",
      "id": 9.6142489253621e+17,
      "id_str": "961424892536205313",
      "text": "scnydq.testbody280:001002003004005006007008009010011012013014015016017018019020021022023024025026027028029030031032\u2026 https:\/\/t.co\/q9CyeceQku",
      "truncated": true,
      "entities": {
        "hashtags": [

        ],
        "symbols": [

        ],
        "user_mentions": [

        ],
        "urls": [
          {
            "url": "https:\/\/t.co\/q9CyeceQku",
            "expanded_url": "https:\/\/twitter.com\/i\/web\/status\/961424892536205313",
            "display_url": "twitter.com\/i\/web\/status\/9\u2026",
            "indices": [
              117,
              140
            ]
          }
        ]
      },
      "metadata": {
        "iso_language_code": "en",
        "result_type": "recent"
      },
      "source": "<a href=\"http:\/\/twitter.com\" rel=\"nofollow\">Twitter Web Client<\/a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 4751643594,
        "id_str": "4751643594",
        "name": "scnydq",
        "screen_name": "scnydq",
        "location": "",
        "description": "",
        "url": null,
        "entities": {
          "description": {
            "urls": [

            ]
          }
        },
        "protected": false,
        "followers_count": 0,
        "friends_count": 5,
        "listed_count": 0,
        "created_at": "Wed Jan 13 06:00:44 +0000 2016",
        "favourites_count": 1,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 4,
        "lang": "en",
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "F5F8FA",
        "profile_background_image_url": null,
        "profile_background_image_url_https": null,
        "profile_background_tile": false,
        "profile_image_url": "http:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_image_url_https": "https:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_link_color": "1DA1F2",
        "profile_sidebar_border_color": "C0DEED",
        "profile_sidebar_fill_color": "DDEEF6",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": false,
        "default_profile": true,
        "default_profile_image": false,
        "following": false,
        "follow_request_sent": false,
        "notifications": false,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 0,
      "favorite_count": 0,
      "favorited": false,
      "retweeted": false,
      "lang": "en"
    },
    {
      "created_at": "Thu Feb 08 02:18:10 +0000 2018",
      "id": 9.6142387998514e+17,
      "id_str": "961423879985139712",
      "text": "0010020030040050060070080090100110120130140150160170180190200210220230240250260270280290300310320330340350360370380\u2026 https:\/\/t.co\/m9tamSkv5U",
      "truncated": true,
      "entities": {
        "hashtags": [

        ],
        "symbols": [

        ],
        "user_mentions": [

        ],
        "urls": [
          {
            "url": "https:\/\/t.co\/m9tamSkv5U",
            "expanded_url": "https:\/\/twitter.com\/i\/web\/status\/961423879985139712",
            "display_url": "twitter.com\/i\/web\/status\/9\u2026",
            "indices": [
              117,
              140
            ]
          }
        ]
      },
      "metadata": {
        "iso_language_code": "und",
        "result_type": "recent"
      },
      "source": "<a href=\"http:\/\/twitter.com\" rel=\"nofollow\">Twitter Web Client<\/a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 4751643594,
        "id_str": "4751643594",
        "name": "scnydq",
        "screen_name": "scnydq",
        "location": "",
        "description": "",
        "url": null,
        "entities": {
          "description": {
            "urls": [

            ]
          }
        },
        "protected": false,
        "followers_count": 0,
        "friends_count": 5,
        "listed_count": 0,
        "created_at": "Wed Jan 13 06:00:44 +0000 2016",
        "favourites_count": 1,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 4,
        "lang": "en",
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "F5F8FA",
        "profile_background_image_url": null,
        "profile_background_image_url_https": null,
        "profile_background_tile": false,
        "profile_image_url": "http:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_image_url_https": "https:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_link_color": "1DA1F2",
        "profile_sidebar_border_color": "C0DEED",
        "profile_sidebar_fill_color": "DDEEF6",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": false,
        "default_profile": true,
        "default_profile_image": false,
        "following": false,
        "follow_request_sent": false,
        "notifications": false,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 0,
      "favorite_count": 0,
      "favorited": false,
      "retweeted": false,
      "lang": "und"
    }
  ],
  "search_metadata": {
    "completed_in": 0.024,
    "max_id": 9.6142489253621e+17,
    "max_id_str": "961424892536205313",
    "query": "scnydq",
    "refresh_url": "?since_id=961424892536205313&q=scnydq&include_entities=1",
    "count": 15,
    "since_id": 0,
    "since_id_str": "0"
  }
}
```
#### **以extended tweet mode搜索tweet**
```
twurl "/1.1/search/tweets.json?q=scnydq&tweet_mode=extended"

{
  "statuses": [
    {
      "created_at": "Thu Feb 08 02:22:11 +0000 2018",
      "id": 9.6142489253621e+17,
      "id_str": "961424892536205313",
      "full_text": "scnydq.testbody280:0010020030040050060070080090100110120130140150160170180190200210220230240250260270280290300310320330340350360370380390400410420430440450460470480490500510520530540550560570580590600610620630640650660670680690700710720730740750760770780790800810820830840850860xy",
      "truncated": false,
      "display_text_range": [
        0,
        280
      ],
      "entities": {
        "hashtags": [

        ],
        "symbols": [

        ],
        "user_mentions": [

        ],
        "urls": [

        ]
      },
      "metadata": {
        "iso_language_code": "en",
        "result_type": "recent"
      },
      "source": "<a href=\"http:\/\/twitter.com\" rel=\"nofollow\">Twitter Web Client<\/a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 4751643594,
        "id_str": "4751643594",
        "name": "scnydq",
        "screen_name": "scnydq",
        "location": "",
        "description": "",
        "url": null,
        "entities": {
          "description": {
            "urls": [

            ]
          }
        },
        "protected": false,
        "followers_count": 0,
        "friends_count": 5,
        "listed_count": 0,
        "created_at": "Wed Jan 13 06:00:44 +0000 2016",
        "favourites_count": 1,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 4,
        "lang": "en",
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "F5F8FA",
        "profile_background_image_url": null,
        "profile_background_image_url_https": null,
        "profile_background_tile": false,
        "profile_image_url": "http:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_image_url_https": "https:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_link_color": "1DA1F2",
        "profile_sidebar_border_color": "C0DEED",
        "profile_sidebar_fill_color": "DDEEF6",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": false,
        "default_profile": true,
        "default_profile_image": false,
        "following": false,
        "follow_request_sent": false,
        "notifications": false,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 0,
      "favorite_count": 0,
      "favorited": false,
      "retweeted": false,
      "lang": "en"
    },
    {
      "created_at": "Thu Feb 08 02:18:10 +0000 2018",
      "id": 9.6142387998514e+17,
      "id_str": "961423879985139712",
      "full_text": "0010020030040050060070080090100110120130140150160170180190200210220230240250260270280290300310320330340350360370380390400410420430440450460470480490500510520530540550560570580590600610620630640650660670680690700710720730740750760770780790800810820830840850860870880890900910920930",
      "truncated": false,
      "display_text_range": [
        0,
        280
      ],
      "entities": {
        "hashtags": [

        ],
        "symbols": [

        ],
        "user_mentions": [

        ],
        "urls": [

        ]
      },
      "metadata": {
        "iso_language_code": "und",
        "result_type": "recent"
      },
      "source": "<a href=\"http:\/\/twitter.com\" rel=\"nofollow\">Twitter Web Client<\/a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 4751643594,
        "id_str": "4751643594",
        "name": "scnydq",
        "screen_name": "scnydq",
        "location": "",
        "description": "",
        "url": null,
        "entities": {
          "description": {
            "urls": [

            ]
          }
        },
        "protected": false,
        "followers_count": 0,
        "friends_count": 5,
        "listed_count": 0,
        "created_at": "Wed Jan 13 06:00:44 +0000 2016",
        "favourites_count": 1,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 4,
        "lang": "en",
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "F5F8FA",
        "profile_background_image_url": null,
        "profile_background_image_url_https": null,
        "profile_background_tile": false,
        "profile_image_url": "http:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_image_url_https": "https:\/\/pbs.twimg.com\/profile_images\/861457044372471809\/C2gG1irn_normal.jpg",
        "profile_link_color": "1DA1F2",
        "profile_sidebar_border_color": "C0DEED",
        "profile_sidebar_fill_color": "DDEEF6",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": false,
        "default_profile": true,
        "default_profile_image": false,
        "following": false,
        "follow_request_sent": false,
        "notifications": false,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 0,
      "favorite_count": 0,
      "favorited": false,
      "retweeted": false,
      "lang": "und"
    }
  ],
  "search_metadata": {
    "completed_in": 0.026,
    "max_id": 9.6142489253621e+17,
    "max_id_str": "961424892536205313",
    "query": "scnydq",
    "refresh_url": "?since_id=961424892536205313&q=scnydq&include_entities=1",
    "count": 15,
    "since_id": 0,
    "since_id_str": "0"
  }
}
```

### 参考
*****
[Tweet updates](https://developer.twitter.com/en/docs/tweets/tweet-updates)  

