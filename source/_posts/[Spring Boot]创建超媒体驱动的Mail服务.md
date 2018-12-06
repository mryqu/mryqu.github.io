---
title: '[Spring Boot] 创建超媒体驱动的Mail服务'
date: 2015-08-03 06:46:47
categories: 
- Service及JavaEE
- Spring
tags: 
- spring
- boot
- mail
- hateoas
- rest
---
### Spring与Mail的集成

Spring框架为邮件发送提供了一个有用的工具库，可为用户屏蔽底层邮件系统细节，并负责代表客户端负责低层资源处理。
`org.springframework.mail`包是Spring框架邮件支持的根级包。发送邮件的核心接口是`MailSender` 接口；封装了简单邮件_from_和_to_等属性的简单对象类是 `SimpleMailMessage` 。该包也包含对底层邮件系统进行更高级抽象的分层检查异常，其根异常为`MailException`。
`org.springframework.mail.javamail.JavaMailSender` 接口`MailSender`为添加了专业的_JavaMail_ 功能，例如MIME消息支持。`JavaMailSender` 也为JavaMailMIME消息提供了回调接口`org.springframework.mail.javamail.MimeMessagePreparator`。

### Spring HATEOAS

HATEOAS (Hypermedia as the Engine of ApplicationState，超媒体即应用状态引擎)是REST应用架构的一个约束。Spring HATEOAS是一个用于支持实现超媒体驱动的RESTWeb服务的开发库。它提供一些API用于同Spring特别是SpringMVC一起使用时轻松创建遵循HATEOAS原则的REST表述，其试图解决的核心问题是链接创建和表述装配。功能：
- 用于链接、资源表述模型的模型类
- 用于指向Spring MVC控制器方法的链接建造者API
- 对[HAL](https://en.wikipedia.org/wiki/Hypertext_Application_Language)之类的多媒体格式的支持

### 示例

#### Application.java

```
package com.yqu.mail;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

#### MailServerVO.java

```
package com.yqu.mail;

import org.springframework.hateoas.ResourceSupport;

import java.io.Serializable;
import java.util.Properties;

public class MailServerVO extends ResourceSupport implements Serializable {
    private String host;
    private Integer port;
    private String userName;
    private String password;
    private String defaultEncoding;
    private Properties properties;

    public MailServerVO() {}

    public MailServerVO(
            String host,
            Integer port,
            String userName,
            String password,
            String defaultEncoding,
            Properties properties) {
        this.host = host;
        this.port = port;
        this.userName = userName;
        this.password = password;
        this.defaultEncoding = defaultEncoding;
        this.properties = properties;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        this.port = port;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDefaultEncoding() {
        return defaultEncoding;
    }

    public void setDefaultEncoding(String defaultEncoding) {
        this.defaultEncoding = defaultEncoding;
    }

    public Properties getProperties() {
        return properties;
    }

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    @Override
    public String toString() {
        return "MailServerVO{" +
                "host='" + host + '\'' +
                ", port=" + port +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", defaultEncoding='" + defaultEncoding + '\'' +
                ", properties=" + properties +
                "} ";
    }
}
```

#### AddressVO.java

```
package com.yqu.mail;

public class AddressVO {
    private String address;
    private String personal;

    public AddressVO() {}

    public AddressVO(
            String address,
            String personal) {
        this.address = address;
        this.personal = personal;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPersonal() {
        return personal;
    }

    public void setPersonal(String personal) {
        this.personal = personal;
    }

    @Override
    public String toString() {
        return "AddressVO{" +
                "address='" + address + '\'' +
                ", personal='" + personal + '\'' +
                '}';
    }
}
```

#### MailVO.java

```
package com.yqu.mail;

import org.springframework.hateoas.ResourceSupport;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Map;

public class MailVO extends ResourceSupport implements Serializable {
    private String subject;
    private String plainText;
    private String htmlText;
    private String charset;
    private boolean multipart = true;
    
    private AddressVO[] to;
    private AddressVO[] cc;
    private AddressVO[] bcc;
    private AddressVO from;
    private AddressVO replyTo;

    public MailVO() {}

    public MailVO(
            String subject,
            String plainText,
            String htmlText,
            String charset,
            boolean multipart,
            AddressVO[] to,
            AddressVO[] cc,
            AddressVO[] bcc,
            AddressVO from,
            AddressVO replyTo) {
        this.subject = subject;
        this.plainText = plainText;
        this.htmlText = htmlText;
        this.charset = charset;
        this.multipart = multipart;
        this.to = to;
        this.cc = cc;
        this.bcc = bcc;
        this.from = from;
        this.replyTo = replyTo;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getPlainText() {
        return plainText;
    }

    public void setPlainText(String plainText) {
        this.plainText = plainText;
    }

    public String getHtmlText() {
        return htmlText;
    }

    public void setHtmlText(String htmlText) {
        this.htmlText = htmlText;
    }

    public String getCharset() {
        return charset;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    public boolean isMultipart() {
        return multipart;
    }

    public void setMultipart(boolean multipart) {
        this.multipart = multipart;
    }

    public AddressVO[] getTo() {
        return to;
    }

    public void setTo(AddressVO[] to) {
        this.to = to;
    }

    public AddressVO[] getCc() {
        return cc;
    }

    public void setCc(AddressVO[] cc) {
        this.cc = cc;
    }

    public AddressVO[] getBcc() {
        return bcc;
    }

    public void setBcc(AddressVO[] bcc) {
        this.bcc = bcc;
    }

    public AddressVO getFrom() {
        return from;
    }

    public void setFrom(AddressVO from) {
        this.from = from;
    }

    public AddressVO getReplyTo() {
        return replyTo;
    }

    public void setReplyTo(AddressVO replyTo) {
        this.replyTo = replyTo;
    }

    @Override
    public String toString() {
        return "MailVO{" +
                "subject='" + subject + '\'' +
                ", plainText='" + plainText + '\'' +
                ", htmlText='" + htmlText + '\'' +
                ", charset='" + charset + '\'' +
                ", multipart=" + multipart +
                ", to=" + Arrays.toString(to) +
                ", cc=" + Arrays.toString(cc) +
                ", bcc=" + Arrays.toString(bcc) +
                ", from=" + from +
                ", replyTo=" + replyTo +
                "} ";
    }
}
```

#### Util.java

```
package com.yqu.mail;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class Util {

    public static MailServerVO convert (JavaMailSenderImpl mailServer) {
        if(mailServer!=null) {
            return new MailServerVO(
                    mailServer.getHost(),
                    mailServer.getPort(),
                    mailServer.getUsername(),
                    mailServer.getPassword(),
                    mailServer.getDefaultEncoding(),
                    mailServer.getJavaMailProperties());
        }
        return null;
    }

    public static JavaMailSenderImpl update(
                        JavaMailSenderImpl sender, MailServerVO vo) {
        if(vo!=null) {
            Properties javaMailProperties = sender.getJavaMailProperties();

            String host = vo.getHost();
            Integer port = vo.getPort();
            String userName = vo.getUserName();
            String password = vo.getPassword();
            String defaultEncoding = vo.getDefaultEncoding();
            Properties properties = vo.getProperties();

            if (host != null) {
                sender.setHost(host);
            }
            if (port != null) {
                sender.setPort(port);
            }
            if (userName != null) {
                sender.setUsername(userName);
            }
            if (password != null) {
                sender.setPassword(password);
            }
            if (defaultEncoding != null) {
                sender.setDefaultEncoding(defaultEncoding);
            }
            if (properties != null && !properties.isEmpty()) {
                properties.stringPropertyNames().forEach(
                        propKey -> javaMailProperties.setProperty(
                                propKey, properties.getProperty(propKey)));
                sender.setJavaMailProperties(javaMailProperties);
            }
        }
        return sender;
    }

    public static AddressVO convert(InternetAddress addr) {
        if(addr!=null) {
            return new AddressVO(addr.getAddress(),addr.getPersonal());
        }
        return null;
    }

    public static InternetAddress convert(AddressVO vo) {
        if(vo!=null) {
            InternetAddress addr = new InternetAddress();
            addr.setAddress(vo.getAddress());
            if(vo.getPersonal()!=null) {
                try {
                    addr.setPersonal(vo.getPersonal(), "UTF-8");
                } catch (UnsupportedEncodingException e) {

                }
            }
            return addr;
        }
        return null;
    }

    public static InternetAddress[] convert(AddressVO[] vos) {
        if(vos!=null) {
            InternetAddress[] addrs = new InternetAddress[vos.length];
            for(int i=0;i attachments = mail.getAttachments();
            Map inlineData = mail.getInline();

            if (plainText==null && htmlText==null) {
                throw new IllegalArgumentException(
                              "Please provide plainText or htmlText.");
            }
            if(!validateAddress(to) &&
               !validateAddress(cc) && 
               !validateAddress(bcc)) {
                throw new IllegalArgumentException(
                               "Please provide 'to', 'cc', or 'bcc'.");
            }

            MimeMessage msg = sender.createMimeMessage();
            try {
                MimeMessageHelper helper = new MimeMessageHelper(
                     msg, multipart, charset == null ? "UTF-8" : charset);

                helper.setFrom(from);
                if (replyTo != null) {
                    helper.setReplyTo(replyTo);
                }
                if (validateAddress(to)) {
                    helper.setTo(to);
                }
                if (validateAddress(cc)) {
                    helper.setCc(cc);
                }
                if (validateAddress(bcc)) {
                    helper.setBcc(bcc);
                }
                helper.setSubject(subject);

                if(multipart && plainText!=null && htmlText!=null) {
                    helper.setText(plainText, htmlText);
                } else if (plainText==null) {
                    helper.setText(htmlText, true);
                } else {
                    helper.setText(plainText);
                }

                msg = helper.getMimeMessage();
            } catch (MessagingException e) {
                throw new IllegalArgumentException(
                               "Please reconfigure mail content", e);
            }

            return msg;
        }
        return null;
    }
}
```

#### MailService.java

```
package com.yqu.mail;

import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.List;

public interface MailService {
    public MailServerVO getMailServer();
    public void setMailServer(MailServerVO mailServer);
    void sendMail(MailVO mail);
    void sendMails(List mail);
}
```

#### MailServiceImpl.java

```
package com.yqu.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class MailServiceImpl implements MailService {
    private JavaMailSenderImpl sender;

    public MailServiceImpl() {}

    public MailServiceImpl(MailServerVO mailServer) {
        setMailServer(mailServer);
    }

    @Override
    public MailServerVO getMailServer() {
        return Util.convert(sender);
    }

    @Override
    public void setMailServer(MailServerVO mailServer) {
        if(sender==null)
            sender = new JavaMailSenderImpl();
        sender = Util.update(sender, mailServer);
    }

    @Override
    public void sendMail(MailVO mail) {
        if(mail!=null) {
            MimeMessage msg = Util.convert(sender, mail);
            sender.send(msg);
        }
    }

    @Override
    public void sendMails(List mails) {
        if(mails!=null && !mails.isEmpty()) {
            List list = new ArrayList<>();
            mails.forEach(mail -> list.add(Util.convert(sender, mail)));
            sender.send(list.toArray(new MimeMessage[mails.size()]));
        }
    }
}
```

#### MailController.java

```
package com.yqu.mail;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.ResourceSupport;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class MailController {
    @Autowired
    private MailService service;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    @ResponseBody
    public HttpEntity  home() {
        ResourceSupport home = new ResourceSupport();
        home.add(linkTo(methodOn(MailController.class).home()).withSelfRel());
        home.add(linkTo(methodOn(MailController.class).sendMail(null)).withRel("mail"));
        home.add(linkTo(methodOn(MailController.class).sendMails(null)).withRel("mails"));
        home.add(linkTo(methodOn(MailController.class).getMailServer()).withRel("server"));
        return new ResponseEntity(home, HttpStatus.OK);
    }

    @RequestMapping(value = "/mail/server", method = RequestMethod.GET)
    @ResponseBody
    public HttpEntity getMailServer() {
        MailServerVO mailServer = service.getMailServer();
        mailServer.add(linkTo(methodOn(MailController.class).getMailServer()).withSelfRel());
        mailServer.add(linkTo(methodOn(MailController.class).setMailServer(null)).withRel("server"));
        return new ResponseEntity(mailServer, HttpStatus.OK);
    }

    @RequestMapping(value = "/mail/server", method = RequestMethod.POST)
    @ResponseBody
    public HttpEntity setMailServer(@RequestBody MailServerVO newMailServer) {
        if(newMailServer!=null) {
            service.setMailServer(newMailServer);
        }
        MailServerVO mailServer = service.getMailServer();
        mailServer.add(linkTo(methodOn(MailController.class).getMailServer()).withSelfRel());
        mailServer.add(linkTo(methodOn(MailController.class).setMailServer(null)).withRel("update"));
        return new ResponseEntity(mailServer, HttpStatus.OK);
    }

    @RequestMapping(value = "/mail", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity sendMail(@RequestBody MailVO mail) {
        if(mail!=null) {
            service.sendMail(mail);
        }
        return new ResponseEntity(mail, HttpStatus.OK);
    }

    @RequestMapping(value = "/mails", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity> sendMails(@RequestBody List mails) {
        if(mails!=null) {
            service.sendMails(mails);
        }
        return new ResponseEntity>(mails, HttpStatus.OK);
    }

}
```

#### application.properties

```
server.context-path=/HelloSpringMail
server.port=8080

applicationDefaultJvmArgs: [
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=55558"
]
```

#### build.gradle

```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.2.6.RELEASE")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'idea'
apply plugin: 'spring-boot'

jar {
    baseName = 'hello-spring-mail'
    version =  '0.1.0'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8

dependencies {
    compile("org.springframework.boot:spring-boot-starter-actuator")
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("org.springframework.boot:spring-boot-starter-mail")
    compile("com.fasterxml.jackson.core:jackson-databind")
    compile("org.springframework.hateoas:spring-hateoas")
    compile("org.springframework.plugin:spring-plugin-core:1.1.0.RELEASE")
    compile("com.jayway.jsonpath:json-path:0.9.1")
}

task wrapper(type: Wrapper) {
    gradleVersion = '2.3'
}
```

### 参考

[Spring Reference：Mail Integration](http://docs.spring.io/spring/docs/current/spring-framework-reference/html/mail.html)  
[Spring HATEOAS](http://projects.spring.io/spring-hateoas/)  
[Understanding HATEOAS](https://spring.io/understanding/HATEOAS)  
[Spring Guide：Building a Hypermedia-Driven RESTful Web Service](http://spring.io/guides/gs/rest-hateoas/)  
[Spring – Sending e-mail with attachment](http://www.mkyong.com/spring/spring-sending-e-mail-with-attachment/)  