---
title: '社交媒体API访问频次限制'
date: 2015-11-07 05:38:39
categories: 
- DataBuilder
tags: 
- socialmedia
- api
- rate
- limit
- quota
---

### Facebook API访问频次限制
- [Facebook Graph API访问频次限制](https://developers.facebook.com/docs/graph-api/advanced/rate-limiting)
- [Facebook Marketing API访问频次限制](https://developers.facebook.com/docs/marketing-api/api-rate-limiting)

FAcebook Graph API允许每用户每60分钟200次API调用。Facebook MarketingAPI随广告用户级别变化。

### [Twitter API访问频次限制](https://dev.twitter.com/rest/public/rate-limiting)

TwitterAPI访问频次按15分钟为间隔。有两类桶：15分钟内允许15次调用，及15分钟内允许180次调用。Twitter搜索属于后者，在15分钟内允许180次调用。

### Google Analytics API Limits and Quotas

- [Google Analytics Core Reporting API - API Limits and Quotas](https://developers.google.com/analytics/devguides/reporting/core/v3/limits-quotas)
- [Google Analytics Real Time Reporting API - API Limits and Quotas](https://developers.google.com/analytics/devguides/reporting/realtime/v3/limits-quotas)
- [ Google Analytics Multi-Channel Funnels Reporting API - API Limits and Quotas](https://developers.google.com/analytics/devguides/reporting/mcf/v3/limits-quotas)


- 每个项目每天50000个请求，可增加。
- 每个IP 10 QPS（query per second）。
  - 在[Developers Console](https://console.developers.google.com/)上，该配额是指**per-userlimit**。默认设置为1秒1个查询，可被调整为最大值10。
  - 如果你的应用从单个IP地址发出所有API请求，你需要考虑在每个请求中使用`userIP`或`quotaUser`参数以获取对每个用户QPS的满配额。
    
### [Understand YouTube Analytics API Quota Usage](https://developers.google.com/youtube/analytics/v1/quota)

暂时没有查到Youtube Analytics API固定配额，不过看起来查询维度对配额使用的影响更大。

### [LinkedIn Company Pages API](https://developer.linkedin.com/docs/company-pages)

配额随API变化。配额以天为间隔，按整个应用、每用户、每开发者进行配置。

### [ 微博接口访问频次限制](http://open.weibo.com/wiki/%E6%8E%A5%E5%8F%A3%E8%AE%BF%E9%97%AE%E9%A2%91%E6%AC%A1%E6%9D%83%E9%99%90)

微博开放接口限制每段时间只能请求一定的次数。限制的单位时间有每小时、每天；限制的维度有单授权用户和单IP；部分特殊接口有单独的请求次数限制。例如：
  - 一个应用内单授权用户每小时只能请求微博开放接口n次；
  - 一个应用内单授权用户每天累计只能请求微博开放接口m次；
  - 一个IP地址每小时只能请求微博开放接口x次；
  - 发微博接口单授权用户每小时只能请求y次；

其中n、m、x、y的具体数值，微博开放平台将采用应用质量评估系统，实现智能评估应用质量，质量高的应用相应的这些数值就高，也就是请求限制小。因此限制值不固定，不同的应用有不同的限制，取决于应用自身的质量。

### [ 微信公众平台接口频率限制](http://mp.weixin.qq.com/wiki/7/85eff372c164ddc66c47777dc972279f.html)

#### 新注册帐号各接口调用频率限制如下：

|接口|每日限额
|-----
|获取access_token|2000
|自定义菜单创建|1000
|自定义菜单查询|10000
|自定义菜单删除|1000
|创建分组|1000
|获取分组|1000
|修改分组名|1000
|移动用户分组|100000
|上传多媒体文件|5000
|下载多媒体文件|10000
|发送客服消息|500000
|高级群发接口|100
|上传图文消息接口|10
|删除图文消息接口|10
|获取带参数的二维码|100000
|获取关注者列表|500
|获取用户基本信息|5000000
|获取网页授权access_token|无
|刷新网页授权access_token|无
|网页授权获取用户信息|无
|设置用户备注名|10000

#### 请注意，在测试号申请页中申请的测试号，接口调用频率限制如下：

|接口|每日限额
|-----
|获取access_token|200
|自定义菜单创建|100
|自定义菜单查询|1000
|自定义菜单删除|100
|创建分组|100
|获取分组|100
|修改分组名|100
|移动用户分组|1000
|素材管理-临时素材上传|500
|素材管理-临时素材下载|1000
|发送客服消息|50000
|获取带参数的二维码|10000
|获取关注者列表|100
|获取用户基本信息|500000
|获取网页授权access_token|无
|刷新网页授权access_token|无
|网页授权获取用户信息|无
