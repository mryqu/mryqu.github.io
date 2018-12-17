---
title: '[C++] 给twitcurl添加访问频次限制信息获取功能'
date: 2016-03-24 06:05:53
categories: 
- DataBuilder
- C++
tags: 
- C++
- twitcurl
- ratelimit
- x-rate-limit-remaining
- x-rate-limit-limit
- x-rate-limit-reset
---

在我之前的博文[Twitter API访问频次限制处理](/post/twitter_api访问频次限制处理)中，描述了Twitter API访问频次限制及Twitter4J对其处理。[twitcurl](https://github.com/mryqu/twitcurl)项目并没有这样的功能，今天我将getLastRateLimitStatus功能添加到了[twitcurl](https://github.com/mryqu/twitcurl)。
通过添加如下代码，我可以获取响应头信息：
```
curl_easy_setopt( m_curlHandle, CURLOPT_HEADERFUNCTION, curlHeaderCallback );
curl_easy_setopt( m_curlHandle, CURLOPT_HEADERDATA, this );
```
输出的调试信息如下：
```
Enter string to search: va
Limit search results to: 2
twitCurl::curlHeaderCallback
headers:
HTTP/1.1 200 OK

twitCurl::curlHeaderCallback
headers:
cache-control: no-cache, no-store, must-revalidate, pre-check=0, post-check=0

twitCurl::curlHeaderCallback
headers:
content-disposition: attachment; filename=json.json

twitCurl::curlHeaderCallback
headers:
content-encoding: gzip

twitCurl::curlHeaderCallback
headers:
content-length: 1301

twitCurl::curlHeaderCallback
headers:
content-type: application/json;charset=utf-8

twitCurl::curlHeaderCallback
headers:
date: Thu, 24 Mar 2016 04:59:41 GMT

twitCurl::curlHeaderCallback
headers:
expires: Tue, 31 Mar 1981 05:00:00 GMT

twitCurl::curlHeaderCallback
headers:
last-modified: Thu, 24 Mar 2016 04:59:41 GMT

twitCurl::curlHeaderCallback
headers:
pragma: no-cache

twitCurl::curlHeaderCallback
headers:
server: tsa_b

twitCurl::curlHeaderCallback
headers:
set-cookie: guest_id=v1:145879558114535127; Domain=.twitter.com; Path=/; Expires=Sat, 24-Mar-2018 04:59:41 UTC

twitCurl::curlHeaderCallback
headers:
status: 200 OK

twitCurl::curlHeaderCallback
headers:
strict-transport-security: max-age=631138519

twitCurl::curlHeaderCallback
headers:
x-access-level: read

twitCurl::curlHeaderCallback
headers:
x-connection-hash: 3d0de7831d3affd43bd8b05ca7af554b

twitCurl::curlHeaderCallback
headers:
x-content-type-options: nosniff

twitCurl::curlHeaderCallback
headers:
x-frame-options: SAMEORIGIN

twitCurl::curlHeaderCallback
headers:
x-rate-limit-limit: 180

twitCurl::curlHeaderCallback
headers:
x-rate-limit-remaining: 178

twitCurl::curlHeaderCallback
headers:
x-rate-limit-reset: 1458796157

twitCurl::curlHeaderCallback
headers:
x-response-time: 64

twitCurl::curlHeaderCallback
headers:
x-transaction: 9a3d28454155b172

twitCurl::curlHeaderCallback
headers:
x-twitter-response-tags: BouncerCompliant

twitCurl::curlHeaderCallback
headers:
x-xss-protection: 1; mode=block

twitCurl::curlHeaderCallback
headers:


twitterClient:: twitCurl::search web response:200
{"statuses":[{"created_at":"Thu Mar 24 04:59:19 +0000 2016","id":712866360888573952,"id_str":"712866360888573952","text":"@laurie6805 @suzannecgordon The VA forces vets to the VA.No choice if less 40 miles??Many vets want outside docs,VAsaysNO!","entities":{"hashtags":[],"symbols":[],"user_mentions":[{"screen_name":"laurie6805","name":"Laurie Anne","id":3093907031,"id_str":"3093907031","indices":[0,11]},{"screen_name":"suzannecgordon","name":"Suzanne Gordon","id":41686321,"id_str":"41686321","indices":[12,27]}],"urls":[]},"truncated":false,"metadata":{"iso_language_code":"en","result_type":"recent"},"source":"\u003ca href="https:\/\/mobile.twitter.com" rel="nofollow"\u003eMobile Web (M2)\u003c\/a\u003e","in_reply_to_status_id":712842279040319489,"in_reply_to_status_id_str":"712842279040319489","in_reply_to_user_id":3093907031,"in_reply_to_user_id_str":"3093907031","in_reply_to_screen_name":"laurie6805","user":{"id":3324233309,"id_str":"3324233309","name":"VeteransStimulusAct","screen_name":"VetStimulusAct","location":"","description":"https:\/\/t.co\/MMhwMHlDdU","url":"https:\/\/t.co\/sasbgdAmi2","entities":{"url":{"urls":[{"url":"https:\/\/t.co\/sasbgdAmi2","expanded_url":"https:\/\/www.facebook.com\/decreaseVAbacklognow","display_url":"facebook.com\/decreaseVAback\u2026","indices":[0,23]}]},"description":{"urls":[{"url":"https:\/\/t.co\/MMhwMHlDdU","expanded_url":"https:\/\/www.change.org\/p\/president-obama-veterans-stimulus-act-adjusted-compensation-payment-act-ii-bonus-act-ii?just_created=true","display_url":"change.org\/p\/president-ob\u2026","indices":[0,23]}]}},"protected":false,"followers_count":1065,"friends_count":3236,"listed_count":14,"created_at":"Sun Jun 14 04:55:38 +0000 2015","favourites_count":653,"utc_offset":null,"time_zone":null,"geo_enabled":false,"verified":false,"statuses_count":3326,"lang":"en","contributors_enabled":false,"is_translator":false,"is_translation_enabled":false,"profile_background_color":"C0DEED","profile_background_image_url":"http:\/\/abs.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_image_url_https":"https:\/\/abs.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_tile":false,"profile_image_url":"http:\/\/pbs.twimg.com\/profile_images\/609994141632733184\/u3bC1h8j_normal.jpg","profile_image_url_https":"https:\/\/pbs.twimg.com\/profile_images\/609994141632733184\/u3bC1h8j_normal.jpg","profile_banner_url":"https:\/\/pbs.twimg.com\/profile_banners\/3324233309\/1434268816","profile_link_color":"0084B4","profile_sidebar_border_color":"C0DEED","profile_sidebar_fill_color":"DDEEF6","profile_text_color":"333333","profile_use_background_image":true,"has_extended_profile":false,"default_profile":true,"default_profile_image":false,"following":false,"follow_request_sent":false,"notifications":false},"geo":null,"coordinates":null,"place":null,"contributors":null,"is_quote_status":false,"retweet_count":0,"favorite_count":0,"favorited":false,"retweeted":false,"lang":"en"}],"search_metadata":{"completed_in":0.036,"max_id":712866360888573952,"max_id_str":"712866360888573952","query":"va","refresh_url":"?since_id=712866360888573952&amp;q=va&amp;lang=en&amp;include_entities=1","count":2,"since_id":0,"since_id_str":"0"}}
```
通过调试信息可知，curlHeaderCallback回调会被多次调用，每次仅处理一个响应头。
对于Twitter搜索来说，15时间窗允许180次调用（见x-rate-limit-limit），调用二次后剩余178次调用（见x-rate-limit-remaining），时间窗复位时间为Thu Mar 24 01:09:17 EDT 2016（通过x-rate-limit-reset由如下Java代码获得）。
```
long now = System.currentTimeMillis();
long reset = 1458796157*1000L;
System.out.println("reset:"+reset);
System.out.println("now  :"+now);
Date d = new Date(reset);
System.out.println("reset:"+d);
d = new Date(now);
System.out.println("now  :"+d);
```
经过调试，getLastRateLimitStatus功能得以实现，我的代码提交到了[https://github.com/mryqu/twitcurl](https://github.com/mryqu/twitcurl)上。