---
title: '数据源/Hibernate配置明文密码加密思考'
date: 2014-01-01 17:48:44
categories: 
- Service+JavaEE
tags: 
- hibernate
- spring
- 数据源
- 明文密码
- 加密
---
无论是Web应用服务器数据源配置还是Hibernate配置，一般数据库用户和密码都是明文的，感觉很不安全。上网搜了一圈，博客帖子还不少，不过都跟Web应用服务器官方文档差不太多。
Tomcat坚持明文，理由是最终需要用原始用户名和密码去连接数据库，而Tomcat是开源的，攻击者很容易找到加密/解密方法，所以也得不到真正的保护。
另一方就是用AES/DES/3DES等密钥算法对明文密码进行加密，然后在程序某处进行解密，例如使用Tomcat连接池时用org.apache.tomcat.jdbc.pool.DataSourceFactory继承子类实现自己的数据源工厂时进行解密，使用Srping时用LocalSessionFactoryBean继承子类读取配置进行解密然后将其写回运行态的配置。这种方式说白了，如果程序不是很大，使用JAD等工具对程序进行反编译，找到如何加解密的算法还是不难的。
我个人认为，真正的Web应用实施肯定是要设置服务器访问权限及服务器内目录的访问权限的，一般人不应该能访问到Web服务器程序及配置，这样即使使用明文密码也能保证相同的安全等级。当然，如果开发一个不严肃的小项目，并且部署在一个公共访问机器上，做做障眼法瞒瞒那些不是码农的人也是可以的。

Web应用服务器文档：
- [Tomcat Wiki：FAQ/Password](http://wiki.apache.org/tomcat/FAQ/Password)
- [ JBoss：Encrypting Data Source Passwords](http://docs.jboss.org/jbosssecurity/docs/6.0/security_guide/html/Encrypting_Data_Source_Passwords.html)
- [ JBoss EAP：Encrypting Data Source Passwords](https://access.redhat.com/documentation/en-US/JBoss_Enterprise_Application_Platform/5/html/Security_Guide/Encrypting_Data_Source_Passwords.html)
- [TomEE：DataSource Password Encryption](http://tomee.apache.org/datasource-password-encryption.html)博客：
- [Encrypting passwords in Tomcat](http://www.jdev.it/encrypting-passwords-in-tomcat/)
- [Hibernate的配置文件中用户和密码的加密](http://hi.baidu.com/xhz12345/item/9f7996fe527d2e743c198b64)
- [hibernate配置文件中数据库密码加密,该如何解决](http://www.myexception.cn/j2ee/1715.html)
- [ Hibernate的验证，而不存储在纯文本密码](http://www.freeshow.net.cn/questions/b2a209d546066bf76d81383e41e4223793380de145a138aff0d12744e8cf3801/)
- [如何给工程中的配置文件加密 解密](http://www.iteye.com/topic/70663)
- [通过spring对hibernate/ibatis的配置文件加密](http://magintursh.blog.51cto.com/1502203/559355)
- [jndi 数据源配置密码加密](http://www.xuebuyuan.com/1141874.html)
- [spring 属性文件加密码及解密](http://www.blogjava.net/hwpok/archive/2010/07/19/326537.html)
- [怎么实现数据库连接的密码加密](http://2.soadmin.com/shujuku/database/292591.htm)
- [Jboss数据源密码加密](http://www.fengfly.com/plus/view-169050-1.html)
- [Tomcat数据源连接池加密](http://my.oschina.net/cimu/blog/164757)
- [使用 Jasypt 保护数据库配置](http://www.cnblogs.com/javalouvre/p/3746397.html)
- [spring datasource 密码加密后运行时解密的解决办法](http://www.yihaomen.com/article/java/420.htm)