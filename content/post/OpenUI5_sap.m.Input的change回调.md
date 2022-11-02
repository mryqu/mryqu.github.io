---
title: '[OpenUI5] sap.m.Input的change回调'
date: 2015-05-26 05:27:41
categories: 
- FrontEnd
tags: 
- openui5
- input
- change
- manual
- javascript
---
用sap.m.Input的change回调，当值在输入界面被修改后就会调用。今天试了一下，如果通过Model设置改变值的话，其change回调不会被调用。

这种特性正好用于判断是否为界面手工修改。在我的用例中，有一个表名和一个表表述。如果改动表名，表描述跟着相应更新；但是一旦用户手工输入表描述后，上述规则不再生效。
