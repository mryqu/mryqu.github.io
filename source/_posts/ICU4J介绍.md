---
title: 'ICU4J介绍'
date: 2015-07-02 00:08:26
categories: 
- Java
tags: 
- icu
- icu4j
- unicode
---
[ICU (International Components for Unicode)](http://site.icu-project.org/)是为软件应用提供Unicode和全球化支持的一套成熟、广泛使用的C/C++和Java类库集，可在所有平台的C/C++和Java软件上获得一致的结果。
[ICU](http://site.icu-project.org/)首先是由Taligent公司开发的，Taligent公司被合并为IBM公司全球化认证中心的Unicode研究组后，[ICU](http://site.icu-project.org/)由IBM和开源组织合作继续开发。开始ICU只有Java平台的版本，后来这个平台下的ICU类被吸纳入SUN公司开发的JDK1.1，并在JDK以后的版本中不断改进。
C++和C平台下的ICU是由JAVA平台下的ICU移植过来的，移植过的版本被称为ICU4C，来支持这C/C++两个平台下的国际化应用。ICU4J和ICU4C区别不大，但由于ICU4C是开源的，并且紧密跟进Unicode标准，ICU4C支持的Unicode标准总是最新的；同时，因为JAVA平台的ICU4J的发布需要和JDK绑定，ICU4C支持Unicode标准改变的速度要比ICU4J快的多。
[ICU](http://site.icu-project.org/)的功能主要有:
- 代码页转换:对文本数据进行Unicode、几乎任何其他字符集或编码的相互转换。ICU的转化表基于IBM过去几十年收集的字符集数据，在世界各地都是最完整的。
- 排序规则（Collation）:根据特定语言、区域或国家的管理和标准比较字数串。ICU的排序规则基于Unicode排序规则算法加上来自公共区域性数据仓库（Commonlocale data repository）的区域特定比较规则。
- 格式化:根据所选区域设置的惯例，实现对数字、货币、时间、日期、和利率的格式化。包括将月和日名称转换成所选语言、选择适当缩写、正确对字段进行排序等。这些数据也取自公共区域性数据仓库。
- 时间计算: 在传统格里历基础上提供多种历法。提供一整套时区计算API。
- Unicode支持:ICU紧密跟进Unicode标准，通过它可以很容易地访问Unicode标准制定的很多Unicode字符属性、Unicode规范化、大小写转换和其他基础操作。
- 正则表达式: ICU的正则表达式全面支持Unicode并且性能极具竞争力。
- Bidi: 支持不同文字书写顺序混合文字（例如从左到右书写的英语，或者从右到左书写的阿拉伯文和希伯来文）的处理。
- 文本边界: 在一段文本内定位词、句或段落位置、或标识最适合显示文本的自动换行位置。

下面的示例是使用ICU4J检测文本编码：
```
package com.yqu.icu4j;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.ibm.icu.text.CharsetDetector;
import com.ibm.icu.text.CharsetMatch;

public class EncodingDetector {
  public static void tryEncoding(String fileName) 
  throws IOException {
    System.out.println("===Getting encoding of " + fileName);
    Path path = Paths.get(fileName);
    byte[] data = Files.readAllBytes(path);
    CharsetDetector detector = new CharsetDetector();
    detector.setText(data);
    CharsetMatch match = detector.detect();
    String encoding = match.getName();
    System.out.println("The Content in " + encoding);
    CharsetMatch[] matches = detector.detectAll();
    System.out.println("All possibilities:");
    for (CharsetMatch m : matches) {
      System.out.println("  CharsetName:" + m.getName() + 
                         " Confidence:" + m.getConfidence());
    }
  }
  
  public static void main(String[] args) {
    try {
      tryEncoding("c:/utf8.txt");
      tryEncoding("c:/gbk.txt");
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
```

测试的是内容如下、但编码分别为uft8和GBK的两个文件：
```
GB18030编码向下兼容GBK和GB2312，兼容的含义是不仅字符兼容，而且相同字符的编码也相同。GB18030收录了所有Unicode3.1中的字符，包括中国少数民族字符，GBK不支持的韩文字符等等，也可以说是世界大多民族的文字符号都被收录在内。
```

结果为：
```
===Getting encoding of c:/utf8.txt
The Content in UTF-8
All possibilities:
  CharsetName:UTF-8 Confidence:100
  CharsetName:windows-1252 Confidence:40
  CharsetName:windows-1253 Confidence:21
  CharsetName:Big5 Confidence:10
  CharsetName:GB18030 Confidence:10
  CharsetName:Shift_JIS Confidence:10
  CharsetName:UTF-16LE Confidence:10
  CharsetName:UTF-16BE Confidence:10
  CharsetName:KOI8-R Confidence:2
  CharsetName:windows-1255 Confidence:2
  CharsetName:windows-1250 Confidence:2
  CharsetName:windows-1254 Confidence:1
  CharsetName:windows-1255 Confidence:1
===Getting encoding of c:/gbk.txt
The Content in GB18030
All possibilities:
  CharsetName:GB18030 Confidence:100
  CharsetName:EUC-KR Confidence:41
  CharsetName:EUC-JP Confidence:41
  CharsetName:Big5 Confidence:10
  CharsetName:Shift_JIS Confidence:10
  CharsetName:UTF-16LE Confidence:10
  CharsetName:UTF-16BE Confidence:10
  CharsetName:ISO-8859-7 Confidence:3
  CharsetName:ISO-8859-6 Confidence:3
  CharsetName:ISO-8859-1 Confidence:3
  CharsetName:ISO-8859-9 Confidence:1
  CharsetName:ISO-8859-2 Confidence:1
```

此外，由于GB18030和Big5编码有交集，在尝试的过程中发现测试内容很少时可能会发生误判。

### 参考

[ICU项目主页](http://site.icu-project.org/)  