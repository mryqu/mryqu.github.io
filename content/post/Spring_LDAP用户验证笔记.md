---
title: '[Spring] LDAP用户验证笔记'
date: 2018-08-13 10:25:53
categories: 
- Service及JavaEE
- Spring
tags: 
- JavaEE
- spring
- security
- ldap
- Authentication
---

对Spring LDAP用户验证进行了学习，制作了时序图：
![Spring LDAP Authorization sequence diagram](/images/2018/08/SpringLdapAuth.png)

LDAP身份验证的步骤为：
- 从客户端登录页面获得用户名和密码。
- 匿名或使用管理DN/密码绑定到LDAP服务器，通过登录用户名查询用户DN，如失败则报用户不存在。
- 使用用户DN和密码再次绑定到LDAP服务器，如果能成功绑定则验证成功，否则报用户密码错误。

# 参考
****
[Spring Security Architecture](https://spring.io/guides/topicals/spring-security-architecture/)
[Spring Security Reference](https://docs.spring.io/spring-security/site/docs/current/reference/htmlsingle/)
[Spring Security Project](https://spring.io/projects/spring-security)
[GETTING STARTED: Authenticating a User with LDAP](https://spring.io/guides/gs/authenticating-ldap/)
[GitHub: spring-guides/gs-authenticating-ldap](https://github.com/spring-guides/gs-authenticating-ldap)