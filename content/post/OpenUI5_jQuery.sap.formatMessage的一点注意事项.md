---
title: '[OpenUI5] jQuery.sap.formatMessage的一点注意事项'
date: 2016-12-19 05:34:50
categories: 
- 前端
tags: 
- openui5
- jquery
- formatmessage
- i18n
---

今天偶然发现I18N properties文件中有字符串包含替换符，可是没起作用，还是明晃晃输出了{0}。![jQuery.sap.formatMessage test](/images/2016/12/jQuery.sap.formatMessage_test.png)
仔细研究一下，才发现原因在于字符串中包含单个'，OpenUI5使用jQuery.sap.formatMessage替换I18N字符串，如果仅含有一个'字符的话，其`/('')|'([^']+(?:''[^']*)*)(?:'|$)|\{([0-9]+(?:\s*,[^{}]*)?)\}|[{}]/g` 就只触发第二组替换了。如果想显示单个字符'，需要用两个字符'转义。
不过问题来了，负责翻译I18N的同事是否清楚jQuery.sap.formatMessage关于字符'的限制呢？