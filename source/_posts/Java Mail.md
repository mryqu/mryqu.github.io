---
title: 'Java Mail'
date: 2015-08-02 09:22:37
categories: 
- Java
tags: 
- java
- mail
- sun
- apache
- spring
---
### JavaMail API

JavaMail最新版本为1.5.4。 支持的邮件协议有：
- SMTP：简单邮件传输协议（Simple Mail Transfer Protocol），由[RFC 821](http://www.imc.org/rfc821) 定义，定义了发送电子邮件的机制。在JavaMailAPI环境中，基于JavaMail的程序将和公司或因特网服务供应商的SMTP服务器通信。SMTP 服务器会中转消息给接收方 SMTP服务器以便最终让用户经由 POP 或 IMAP 获得。这不是要求SMTP服务器成为开放的中继，尽管SMTP服务器支持身份验证，不过还是得确保它的配置正确。JavaMailAPI不支持像配置服务器来中继消息或添加/删除邮件账号这类任务的实现。
- POP：邮局协议（Post Office Protocol）。目前用的是版本 3，也称POP3，由[RFC 1939](http://www.imc.org/rfc1939)定义。本协议主要用于支持使用客户端远程管理在服务器上的电子邮件。POP协议支持“离线”邮件处理。其具体过程是：邮件发送到服务器上，电子邮件客户端调用邮件客户机程序以连接服务器，并下载所有未阅读的电子邮件。使用POP时，用户熟悉的许多性能并不是由POP协议支持的，如查看有几封新邮件消息这一性能。这些性能内建于如Eudora或Microsoft Outlook之类的程序中，它们能记住一些事，诸如最近一次收到的邮件，还能计算出有多少是新的。所以当使用JavaMailAPI时，如果您想要这类信息，您就必须自己算。
- IMAP： 因特网消息访问协议（Internet Message Access Protocol）。目前用的是版本 4，也称IMAP4。由[RFC 2060](http://www.imc.org/rfc2060)定义，是更高级的用于接收消息的协议。它与POP3协议的主要区别是用户可以不用把所有的邮件全部下载，可以通过客户端直接对服务器上的邮件进行操作。IMAP4改进了POP3的不足，用户可以通过浏览信件头来决定是否收取、删除和检索邮件的特定部分，还可以在服务器上创建或更改文件夹或邮箱。它除了支持POP3协议的脱机操作模式外，还支持联机操作和断连接操作。它为用户提供了有选择的从邮件服务器接收邮件的功能、基于服务器的信息处理功能和共享信箱功能。IMAP4的脱机模式不同于POP3，它不会自动删除在邮件服务器上已取出的邮件，其联机模式和断连接模式也是将邮件服务器作为“远程文件服务器”进行访问，更加灵活方便。IMAP4支持多个邮箱。

MIME：多用途因特网邮件扩展标准（Multipurpose Internet MailExtensions）。它不是邮件传输协议。但对传输内容的消息、附件及其它的内容定义了格式。这里有很多不同的有效文档：[RFC 822](http://www.imc.org/rfc822)、[RFC 2045](http://www.imc.org/rfc2045)、[RFC 2046](http://www.imc.org/rfc2046) 和 [RFC 2047](http://www.imc.org/rfc2047)。作为一个 JavaMailAPI的用户，您通常不必对这些格式操心。无论如何，一定存在这些格式而且程序会用到它。

JavaMail API不在Java JDK中，[javax.mail.jar](https://maven.java.net/content/repositories/releases/com/sun/mail/javax.mail/1.5.4/javax.mail-1.5.4.jar)包含了JavaMailAPI及Sun的参考设计，其中包括SMTP、IMAP和POP3协议提供者。
JavaMail API 类包:
- [javax.mail](https://javamail.java.net/nonav/docs/api/javax/mail/package-summary.html)： The JavaMailTM API提供为邮件系统建模的类。
- [javax.mail.event](https://javamail.java.net/nonav/docs/api/javax/mail/event/package-summary.html)： 用于JavaMail API的监听器和事件。
- [javax.mail.internet](https://javamail.java.net/nonav/docs/api/javax/mail/internet/package-summary.html)：特定互联网邮件系统的类。
- [javax.mail.search](https://javamail.java.net/nonav/docs/api/javax/mail/search/package-summary.html)：用于JavaMail API的消息搜索术语。
- [javax.mail.util](https://javamail.java.net/nonav/docs/api/javax/mail/util/package-summary.html)： JavaMail API工具类。Sun参考设计的类包:
- [com.sun.mail.dsn](https://javamail.java.net/nonav/docs/api/com/sun/mail/dsn/package-summary.html)：支持创建和解析传递状态通知。
- [com.sun.mail.gimap](https://javamail.java.net/nonav/docs/api/com/sun/mail/gimap/package-summary.html)： 支持[Gmail特定IMAP协议扩展](https://developers.google.com/google-apps/gmail/imap_extensions)的实验性IMAP协议提供者。
- [com.sun.mail.imap](https://javamail.java.net/nonav/docs/api/com/sun/mail/imap/package-summary.html)：用于访问IMAP消息存储的IMAP协议提供者。
- [com.sun.mail.pop3](https://javamail.java.net/nonav/docs/api/com/sun/mail/pop3/package-summary.html)：用于访问POP3消息存储的POP3协议提供者。
- [com.sun.mail.smtp](https://javamail.java.net/nonav/docs/api/com/sun/mail/smtp/package-summary.html)：用于访问SMTP服务器的SMTP协议提供者。
- [com.sun.mail.util](https://javamail.java.net/nonav/docs/api/com/sun/mail/util/package-summary.html)： 用于JavaMail API的工具类。
- [com.sun.mail.util.logging](https://javamail.java.net/nonav/docs/api/com/sun/mail/util/logging/package-summary.html)： 包含用于JavaTM平台核心日志功能的JavaMailTM扩展。

### Apache Commons Email

Apache Commons Email是构建在JavaMail API之上的工具库，旨在简化设计，当前版本1.4。主要的一些类:
- SimpleEmail - 用于发送简单的文本邮件。
- MultiPartEmail - 用于发送多部分消息（multipartmessages）。允许带有（内联或附加的）附件的文本邮件。
- HtmlEmail -用于发送HTML格式邮件。具有MultiPartEmail所有的功能，可以更容易添加附件，并支持内嵌的图像。
- ImageHtmlEmail - 用于发送带内联图像的HTML格式邮件。具有HtmlEmail所有的功能，但将所有图像引用转成内联图像。
- EmailAttachment -可用于轻松处理附件的简单容器类，用于MultiPartEmail和HtmlEmail实例。

在我学习Activiti的过程了解到：Activiti的BPMN引擎对MAIL任务的实现就采用的是Apache CommonsEmail，详见[MailActivityBehavior.java](https://github.com/Activiti/Activiti/blob/master/modules/activiti-engine/src/main/java/org/activiti/engine/impl/bpmn/behavior/MailActivityBehavior.java)。

### Spring与Mail的集成

Spring框架为邮件发送提供了一个有用的工具库，可为用户屏蔽底层邮件系统细节，并负责代表客户端负责低层资源处理。
`org.springframework.mail`包是Spring框架邮件支持的根级包。发送邮件的核心接口是`MailSender`接口；封装了简单邮件_from_和_to_等属性的简单对象类是`SimpleMailMessage`。该包也包含对底层邮件系统进行更高级抽象的分层检查异常，其根异常为`MailException`。
`org.springframework.mail.javamail.JavaMailSender` 接口`MailSender`为添加了专业的_JavaMail_ 功能，例如MIME消息支持。`JavaMailSender` 也为JavaMailMIME消息提供了回调接口`org.springframework.mail.javamail.MimeMessagePreparator`。

### 参考

[JavaMail API](https://java.net/projects/javamail/pages/Home)  
[JavaMail JavaDoc](https://javamail.java.net/nonav/docs/api/)  
[Apache Commons Email](https://commons.apache.org/proper/commons-email/)  
[Spring Reference：Mail Integration](http://docs.spring.io/spring/docs/current/spring-framework-reference/html/mail.html)  
[](http://spring.io/guides/gs/rest-hateoas/)  