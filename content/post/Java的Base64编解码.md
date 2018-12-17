---
title: 'Java的Base64编解码'
date: 2015-01-01 11:30:21
categories: 
- Java
tags: 
- java
- base64
---
[Base64](https://zh.wikipedia.org/wiki/Base64)编码是网络上最常见的用于传输8Bit字节代码的编码方式之一，用基于64个可打印字符[大小写字母52个字符、数字10个字符、+和/2个字符(对于URL为-和_)，补全用=]来表示二进制数据的一种表示方法。相关协议可见：

- [RFC4648 The Base16, Base32, and Base64 Data Encodings](https://tools.ietf.org/html/rfc4648)
- [RFC2045 MIME Part One: Format of Internet Message Bodies](https://tools.ietf.org/html/rfc2045#section-6.8)
- [RFC2046 MIME Part Two: Media Types](https://tools.ietf.org/html/rfc2046)
- [RFC2047 MIME Part Three: Message Header Extensions for Non-ASCII Text](https://tools.ietf.org/html/rfc2047)
- [RFC2048 MIME Part Four: Registration Procedures](https://tools.ietf.org/html/rfc2048)
- [RFC2049 MIME Part Five: Conformance Criteria and Examples](https://tools.ietf.org/html/rfc2049)

因为有些网络传送渠道不支持所有的字节，例如传统的邮件只支持可见字符的传送，像ASCII码的控制字符就不能通过邮件传送。通过Base64编码可以把不可打印的字符也能用可打印字符来表示。

### Java6之前

在Java6之前，JDK核心类一直没有Base64的实现类。除了使用Sun内部实现sun.misc.BASE64Encoder、sun.misc.BASE64Decoder或com.sun.org.apache.xerces.internal.impl.dv.util.Base64外，就需要使用第三方类库了。
![Java的Base64编解码](/images/2015/1/0026uWfMzy73T7weHL200.jpg)
### Java6

Java6中添加了Base64的实现：javax.xml.bind.DatatypeConverter两个静态方法parseBase64Binary和 printBase64Binary。
```
import javax.xml.bind.DatatypeConverter;

public class HelloBase64 {

  public static void main(String[] args) {
    String me = "blog.sina.com.cn/yandongqu";
    byte[] plainContent;
      
    String base64Str = DatatypeConverter.printBase64Binary(me.getBytes()); 
    System.out.println(base64Str);
                
    plainContent = DatatypeConverter.parseBase64Binary(base64Str);
    System.out.println(new String(plainContent));
  }
}
```

测试结果：
```
YmxvZy5zaW5hLmNvbS5jbi95YW5kb25ncXU=
blog.sina.com.cn/yandongqu
```

### Java8

Java8中添加了另一个Base64的实现java.util.Base64类。该类提供三种编解码器：

- 基本编解码器：64个字符包括+和/；
- URL编解码器：为了处理URL里面的反斜线“/”，64个字符包括-和_；
- MIME编解码器：使用基本的字母数字产生Base64输出，而且对MIME格式友好：每一行输出不超过76个字符且以“\r\n”结束；

```
import java.util.Base64;

public class HelloBase64 {

  public static void main(String[] args) {
    String me = "blog.sina.com.cn/yandongqu";
    byte[] plainContent;
      
    byte[] base64Content = Base64.getEncoder().encode(me.getBytes());
    System.out.println(new String(base64Content));
    plainContent = Base64.getDecoder().decode(base64Content);
    System.out.println(new String(plainContent));
  }
}
```

测试结果：
```
YmxvZy5zaW5hLmNvbS5jbi95YW5kb25ncXU=
blog.sina.com.cn/yandongqu
```

### 第三方类库

- [commons-codec](https://github.com/apache/commons-codec).jar中的org.apache.commons.codec.binary.Base64类(Apache License)；
- [google-guava](https://github.com/google/guava).jar中的com.google.common.io.BaseEncoding.base64()静态方法 (Apache License)；
- [iHarder.net](http://iharder.sourceforge.net/current/java/base64/)的Base64类(I have released this software into the Public Domain. That meansyou can do whatever you want with it. Really. You don't have tomatch it up with any other open source license &em;just use it. You can rename the files, move the Java packages,whatever you want. If your lawyers say you have to have a license,contact me, and I'll make a special release to you under whateverreasonable license you desire: MIT, BSD, GPL, whatever.)；
- [MiGBase64](https://sourceforge.net/projects/migbase64/files/)的util.Base64类(BSD License)；

### 参考

[从原理上搞定编码（四）-- Base64编码](http://www.cnblogs.com/luguo3000/p/3940197.html)    