---
title: 'YAML'
date: 2015-05-22 22:55:52
categories: 
- Tech
tags: 
- yaml
- json
- xml
- sdl
- 数据序列化
---
## 简介

**YAML**是一个可读性高的数据序列化格式。YAML参考了其他多种语言，包括：[XML](https://zh.wikipedia.org/wiki/XML)、[C语言](https://zh.wikipedia.org/wiki/C%E8%AA%9E%E8%A8%80)、[Python](https://zh.wikipedia.org/wiki/Python)、[Perl](https://zh.wikipedia.org/wiki/Perl)以及电子邮件格式RFC[2822](http://www.rfc-editor.org/rfc/rfc2822.txt)。ClarkEvans在2001年首次发表了这种语言 ，另外Ingy d?t Net与OrenBen-Kiki也是这语言的共同设计者。目前已经有数种编程语言或脚本语言支援（或者说解析）这种语言。
_YAML_是"YAML Ain't a Markup Language"（YAML不是一种[标记语言](https://zh.wikipedia.org/wiki/%E6%A0%87%E8%AE%B0%E8%AF%AD%E8%A8%80)）的[递回缩写](https://zh.wikipedia.org/wiki/%E9%81%9E%E8%BF%B4%E7%B8%AE%E5%AF%AB)。在开发的这种语言时，_YAML_的意思其实是："Yet Another Markup Language"（仍是一种[标记语言](https://zh.wikipedia.org/wiki/%E6%A0%87%E8%AE%B0%E8%AF%AD%E8%A8%80)），但为了强调这种语言以数据做为中心，而不是以标记语言为重点，而用反向缩略语重新命名。

## 功能

YAML的语法和其他高阶语言类似，并且可以简单表达列表、哈希表，标量等数据形式。它使用空白符号缩排和大量依赖外观的特色，特别适合用来表达或编辑数据结构、各种配置文件、调试时的转储内容、文件标题（例如：许多电子邮件标题格式和YAML非常接近）。尽管它比较适合用来表达分层数据，不过也有紧凑的语法可以表示关联性数据。由于YAML使用空白字符和分行来分隔数据，使得它特别适合用[grep](https://zh.wikipedia.org/wiki/Grep)／[Python](https://zh.wikipedia.org/wiki/Python)／[Perl](https://zh.wikipedia.org/wiki/Perl)／[Ruby](https://zh.wikipedia.org/wiki/Ruby)操作。其让人最容易上手的特色是巧妙避开各种封闭符号，如：引号、各种括号等，这些符号在嵌套结构时会变得复杂而难以辨认。

## 范例

### 简单的文件

数据结构可以用类似大纲的缩排方式呈现
```
---
receipt:     Oz-Ware Purchase Invoice
date:        2007-08-06
customer:
    given:   Dorothy
    family:  Gale

items:
    - part_no:   A4786
      descrip:   Water Bucket (Filled)
      price:     1.47
      quantity:  4

    - part_no:   E1628
      descrip:   High Heeled "Ruby" Slippers 
      price:     100.27
      quantity:  1

bill-to:  &id001
    street: | 
            123 Tornado Alley
            Suite 16
    city:   East Westville
    state:  KS

ship-to:  *id001   

specialDelivery:  >
    Follow the Yellow Brick
    Road to the Emerald City.
    Pay no attention to the 
    man behind the curtain.
...
```

注意在YAML中，字串不一定要用双引号标示。另外，在缩排中空白字符的数目并不是非常重要，只要相同阶层的元素左侧对齐就可以了。这个文件的的顶层由七个键值组成：其中一个键值"items"，是个两个元素构成的[数组](https://zh.wikipedia.org/wiki/%E9%99%A3%E5%88%97)（或称[列表](https://zh.wikipedia.org/wiki/%E6%B8%85%E5%96%AE)），这列表中的两个元素同时也是包含了四个键值的哈希表。文件中重复的部分用这个方法处理：使用锚点（&）和参考（*）标签将"bill-to"哈希表的内容复制到"ship-to"哈希表。也可以在文件中加入可选的空行，以增加可读性。在一个文档中，可同时包含多个文件，并用"---"分隔。可选的符号"..."可以用来表示文档结尾（在利用串流的通讯中，这非常有用，可以在不关闭串流的情况下，发送结束讯号）。

## 语言的构成元素

### YAML的基本元件

YAML提供缩排／区块以及内置（inline）两种格式，来表示列表和[哈希表](https://zh.wikipedia.org/wiki/%E9%9B%9C%E6%B9%8A%E8%A1%A8)。以下展示几种YAML的基本原件。

#### 列表（[数组](https://zh.wikipedia.org/wiki/%E9%99%A3%E5%88%97)）

习惯上列表比较常用区块格式（block format）表示，也就是用短杠+空白字符作为起始。
```
--- # 最喜爱的电影
- Casablanca
- North by Northwest
- Notorious
```

另外还有一种内置格式（inline format）可以选择──用方括号围住，并用逗号+空白区隔（类似[JSON](https://zh.wikipedia.org/wiki/JSON)的语法）
```
--- # 购物清单
[milk, pumpkin pie, eggs, juice]
```

#### [哈希表](https://zh.wikipedia.org/wiki/%E9%9B%9C%E6%B9%8A%E8%A1%A8)

键值和数据由冒号及空白字符分开。
```
--- # 区块形式
name: John Smith
age: 33
--- # 內置形式
{name: John Smith, age: 33}
```

#### 区块的字符

再次强调，字串不需要包在引号之内。

##### 保存新行(Newlines preserved)
```
data: |                                    #译者注：這是一首著名的五行民謠(limerick)
  There once was a man from Ealing      #这里曾有一个来自伊灵的人
  Who got on a bus bound to Darjeeling  #他搭上一班往大吉岭的公車
  It said on the door                   #门上这么说的
  "Please don't spit on the floor"      #"請勿在地上吐痰"
  So he carefully spat on the ceiling   #所以他小心翼翼的吐在天花板上
```

根据设定，前方的引领空白符号（leading whitespace）必须排成条状，以便和其他数据或是行为（如范例中的缩排）明显区分。

##### 折叠新行(Newlines folded)
```
data: >
  Wrapped text         #包裹的文字
  will be folded       #将会被收
  into a single        #进一个
  paragraph            #段落内

  Blank lines denote   #空白的行代表
  paragraph breaks     #分段符
```

和保存新行不同的是，换行字符会被转换成空白字符。而引领空白字符则会被自动消去。

#### 元素的分层组合

##### 于列表中使用哈希表
```
- {name: John Smith, age: 33}
- name: Mary Smith
  age: 27
```

##### 于哈希表中使用列表
```
men: [John Smith, Bill Jones]
women:
  - Mary Smith
  - Susan Williams
```

### YAML的进阶元件

这部分算是一个后续的讨论，在比较各种数数据列语言时，YAML最常被提到的特色有两个：结构和数据类型。

#### 结构

YAML结构可以让多个文档存在一个文件中，为重复节点使用参考，使用任意节点作为键值。

##### 数据锚节点和参考节点

为了维持文件的简洁，并避免数据输入的错误，YAML提供了结点锚节点(&)和参考节点(*)。参考会将结构加入锚点标记的内容，并可以在所有结构中可用（可以参考上面"ship-to"的范例）
下例是指令序列队列中，两个单步操作被重复使用而无需每次详细定义。
```
#眼部激光手术的序列器协议
---
- step:  &id001                  # 定义锚标签 &id001
    instrument:      Lasik 2000
    pulseEnergy:     5.4
    pulseDuration:   12
    repetition:      1000
    spotSize:        1mm

- step: &id002
    instrument:      Lasik 2000
    pulseEnergy:     5.0
    pulseDuration:   10
    repetition:      500
    spotSize:        2mm

- step: *id001                   # 参考第一步 (使用锚标签 &id001)
- step: *id002                   # 参考第二部
- step: *id001
- step: *id002
```

#### 数据类型

由于YAML自动监测简单数据类型，因此显式类型在大部分的YAML文件中很难看到。数据类型可以分成三大类：核心类型(core)、定义(defined)和用户定义(user-defined)。核心类型可自动被解析器分析（例如：浮点数，整数，字串，列表，哈希表，...）。有一些高级的数据类型，例如二进制数据，在YAML规范中有被“定义”，但不是每一种解析器都支持。最后，YAML提供一种方式在本地扩展数据类型以接受用户自定义的类，结构或原型数据（例如：四倍精度的浮点数）。

##### 强迫转型

YAML的自动判定实体是那种数据类型。但有时使用者会想要将数据显式转型成某种类型。最常见的状况是字串，有时候可能看起来像数字或布尔值，这种时候可以使用双引号，或是使用显式类型标签。
```
---
a: 123                     # 整數
b: "123"                   # 字串（使用雙括號）
c: 123.0                   # 浮點數
d: !!float 123             # 浮點數，使用!!表达的显式数据类型
e: !!str 123               # 字串，使用显式数据类型
f: !!str Yes               # 字串，使用显式数据类型
g: Yes                     # 布尔值"真"
h: Yes we have No bananas  # 字串（包含"Yes"和"No"）
```

##### 其他特定数据类型

并非每个YAML实现都有每个特定数据类型。这些内建的类型需要在类型名称之前加上两个惊叹号前缀（!!）。包括[集合](https://zh.wikipedia.org/wiki/%E9%9B%86%E5%90%88)（sets），有序映照（orderedmaps），[时间戳](https://zh.wikipedia.org/wiki/%E6%99%82%E9%96%93%E6%88%B3%E8%A8%98)（timestamps）以及十六进制数据（hexadecimal）等几种尤其有趣的特定数据类型在本文没有介绍。下面这个范例则是base64编码的二进制数据（binary）。
```
---
picture: !!binary |
 R0lGODlhDAAMAIQAAP//9/X
 17unp5WZmZgAAAOfn515eXv
 Pz7Y6OjuDg4J+fn5OTk6enp
 56enmleECcgggoBADs=mZmE
```

##### 使用者自定义数据类型扩充

许多YAML的实现允许使用者自定义数据类型。这是序列化对象的一个很不错的方法。本地数据类型不是通用数据类型，但是使用YAML解析器库定义在应用中。本地数据类型用单个惊叹号（!）表示。
```
---
myObject:  !myClass { name: Joe, age: 15}

```

### 语法

在[yaml.org](http://yaml.org/)（英文）可以找到简短的速查表及规范全本。下面的内容，是关于基本元件的摘要。

- YAML使用可打印的[Unicode](https://zh.wikipedia.org/wiki/Unicode)字符，[UTF-8](https://zh.wikipedia.org/wiki/UTF-8)或[UTF-16](https://zh.wikipedia.org/wiki/UTF-16)格式均可。
- 使用空白字符为文件缩排来表示结构；不过不能使用制表键(TAB)。
- 注解由井字号（ **#** ）开始，可以出现在一行中的任何位置，而且范围只有一行（也就是一般所谓的单行注解）
- 每个列表成员以单行表示，并用短杠 （ **-** ）起始。或使用[方括号](https://zh.wikipedia.org/wiki/%E6%8B%AC%E8%99%9F)（ **[]** ），并用[逗号](https://zh.wikipedia.org/wiki/%E9%80%97%E8%99%9F)+空白（**,** ）分开成员。
- 每个哈希表的成员用冒号（ **:** ）分开键值和内容。或使用大括号（**{ }**），并用逗号+空白（**,** ）分开。
  - 哈希表的键值可以用[问号](https://zh.wikipedia.org/wiki/%E5%95%8F%E8%99%9F) (**?** )起始，用来明确的表示多个词汇组成的键值。
- 字串平常并不使用引号，但必要的时候可以用[双引号](https://zh.wikipedia.org/wiki/%E5%8F%8C%E5%BC%95%E5%8F%B7)( **"** )或[单引号](https://zh.wikipedia.org/wiki/%E5%8D%95%E5%BC%95%E5%8F%B7)( **'** )框住。
  - 使用双引号表示字串时，可用倒斜线（ **\** ）开始的转义字符（这跟[C语言](https://zh.wikipedia.org/wiki/C%E8%AA%9E%E8%A8%80)类似）表示特殊字符。
- 区块的字串用缩排和修饰词（非必要）来和其他数据分隔，有新行保留（preserve）（使用符号 **|**）或新行折叠（flod）（使用符号 **>** ）两种方式。
- 在单一数据流中，可用连续三个[连字号](https://zh.wikipedia.org/wiki/%E8%BF%9E%E5%AD%97%E5%8F%B7)（**---**）区分多个文档。
  - 另外，还有选择性的连续三个点号（ **...** ）用来表示文档结尾。
- 重复的内容可使从参考标记[星号](https://zh.wikipedia.org/wiki/%E6%98%9F%E8%99%9F) (***** )复制到锚点标记（ **&** ）。
- 指定格式可以使用两个[惊叹号](https://zh.wikipedia.org/wiki/%E6%83%8A%E5%8F%B9%E5%8F%B7)( **!!** )，后面接上名称。
- 文档中的单一文件可以使用**[指导指令](https://zh.wikipedia.org/wiki/%E7%B7%A8%E8%AD%AF%E7%A8%8B%E5%BC%8F%E5%AE%9A%E5%90%91)**，使用方法是[百分比符号](https://zh.wikipedia.org/w/index.php?title=%E7%99%BE%E5%88%86%E6%AF%94%E7%AC%A6%E8%99%9F&action=edit&redlink=1)(**%** )。有两个[指导指令](https://zh.wikipedia.org/wiki/%E7%B7%A8%E8%AD%AF%E7%A8%8B%E5%BC%8F%E5%AE%9A%E5%90%91)在YAML1.1版中被定义：
  - %YAML 指令，用来识别文件的YAML版本。
  - %TAG 指令，被用作URI前缀的缩写。这个方法可能用于在节点类型的标签中。
YAML再使用逗号及冒号时，后面都必须接一个空白字符，这样包含标点的字串或数值（例如：5**,**280或http**:**//www.wikipedia.org）就无需使用引号了。

另外还有两个特殊符号在YAML中被[保留](https://zh.wikipedia.org/wiki/%E4%BF%9D%E7%95%99%E5%AD%97)，有可能在未来的版本被使用：（**@** ）和（ **`** ）。

## 与其他数据序列化格式语言比较

虽然YAML是参考[JSON](https://zh.wikipedia.org/wiki/JSON)，[XML](https://zh.wikipedia.org/wiki/XML)和[SDL](https://zh.wikipedia.org/wiki/SDL)等语言，不过跟这些语言比起来，YAML仍有自己的特色。

### JSON

JSON的语法是YAML1.2版的基础，其发布就是为了使YAML全面兼容JSON，使JSON的语法称为YAML1.2版的子集。YAML之前的版本并不是严格兼容，但差异也不是很显著，因此大部分的JSON文件都可以被某些YAML解析器(例如Syck)解析。这是因为JSON的语法结构和YAML的内置格式相同。虽然扩展的分层也可以使用类似JSON的内置格式，除非其有助于增强文档可读性，否则YAML标准并不建议这样使用。YAML的许多扩展在JSON是找不到的，如：注释、高级数据类型、关系性锚节点、不带引号的字串、保留键值顺序的哈希表。

### [XML](https://zh.wikipedia.org/wiki/%E5%8F%AF%E6%89%A9%E5%B1%95%E6%A0%87%E8%AE%B0%E8%AF%AD%E8%A8%80)和SDL

XML和SDL标签概念，在YAML中是找不到的。_对于数据结构序列化_，标签属性是一个存在问题的工具（尽管这是有争议的），将数据和元数据进行分离后当使用通用语言中的原生数据结构（如：哈希表、数组）进行表达时增加了复杂性。YAML则以数据类型的可扩展性作为替代（包括对象的类类型）。

YAML本身的规范中，并没有类似XML语言定义文档模式描述符（language-defined document schemadescriptors）──例如验证自己本身的结构是否正确的文件。 不过，[用于YAML的外部定义的模式描述述语言](https://zh.wikipedia.org/w/index.php?title=YAML%E7%B6%B1%E8%A6%81%E6%8F%8F%E8%BF%B0%E8%AA%9E%E8%A8%80&action=edit&redlink=1)（例如Doctrine、Kwalify和Rx）可以完成同样的功能。另外YAXML语言定义的类型声明提供的语义已经提供了足够的方式，来辨认YAML文件是否正确。YAXML──用XML描述YAML的结构──可以让[XML模式](https://zh.wikipedia.org/wiki/XML_Schema)与[XSLT](https://zh.wikipedia.org/wiki/XSLT)转换程式应用在YAML之上。

### 缩排划界

由于YAML的运作主要依赖大纲式的缩排来决定结构，这有效解决了[界定符冲突](https://zh.wikipedia.org/w/index.php?title=%E7%95%8C%E5%AE%9A%E7%AC%A6%E8%A1%9D%E7%AA%81&action=edit&redlink=1)（Delimitercollision）的问题。YAML的数据形态不依赖引号之特点，使的YAML文件可以利用区块，轻易的插入各种其他类型文件，如：XML、SDL、JSON，甚至插入另一篇YAML。

![YAML](/images/2015/5/0026uWfMgy6SulpROB086.png)

相反的，要将YAML置入XML或SDL中时，需要将所有空白字符和位势符号（potentialsigils，如：<、>和&）转换成实体语法；要将YAML置入JSON中，需要用引号框住，并转换内部的所有引号。

### 非分层的数据模型

跟SDL、JSON等，每个子结点只能有单一一个父节点的阶层是模型不同，YAML提供了一个简单的关系体制，可以从树状结构的其他地方，重复相同的数据，而不必显示那些冗余的结构。这点和XML中的IDRef类似。YAML解析器在将YAML转换成物件时，会自动将那些参考数据的结构展开，所以程式在使用时并不会查觉到哪些数据是解码自这种结构。XML则不会将这种结构展开。这种表示法可以增加程式的可读性，并且在那种‘大部分参数维持和上次相同，只有少数改变’的配置文件及通讯协议中可以减少数据输入错误。一个例子是：‘送货地点’和‘购买地点’在发票的纪录中几乎都是相同的数据。

### 实际的考量

YAML是“面向行的”，因此很容易将有程序的非结构化输出转换成YAML格式并保留大部分的原始文件之外观。因为无需匹配封闭的标签、括弧及引号，很容易通过一个不算精致的程序的输出命令生成格式良好的YAML文档。同样，空格分隔可让面向行的命令grep、Awk、perl、ruby和Python，在快捷地过滤YAML文件时更加方便。

特别是与标记语言不同的，连续的YAML区块往往本身都是格式良好的YAML文件。这使得很容易撰写那种“在开始提取的具体记录之前，不需要'读取全部文件内容'”的解析器（通常需要匹配的起始和关闭标签、寻找引号和转移字符）。当处理一个单一静态的，整个存在内存中的数据结构将很大，或为提取一个项目来重建的整个结构，代价相当昂贵的记录档，这种特性是相当方便的。

违反直观的是，尽管它的缩排方式似乎更加复杂化了嵌套层次，YAML将缩排视为一个单一的空白，这可能会取得比其他标记语言更好的压缩比。此外，可以通过下列方式避免极深的缩排：(1)使用“内置格式”（即简称类JSON格式）而无缩排；或(2)使用关联锚点展开阶层以形成一个摊平的格式，使得YAML解析器能透明地重组成完整的数据结构。

#### 安全性

YAML是纯粹用来表达数据的语言，所以内部不会存[代码注射](https://zh.wikipedia.org/wiki/%E4%BB%A3%E7%A2%BC%E6%B3%A8%E5%B0%84)的可执行命令。这代表解析器会相当（至少）安全的解析文件，而不用担心潜在与执行命令相关的安全漏洞。举例来说，[JSON](https://zh.wikipedia.org/wiki/JSON)是[JavaScript](https://zh.wikipedia.org/wiki/JavaScript)的子集，使用JavaScript本身的解析器是相当诱人的，不过也造成许多[代码注射](https://zh.wikipedia.org/wiki/%E4%BB%A3%E7%A2%BC%E6%B3%A8%E5%B0%84)的漏洞。虽然在所有数据序列化格式语言中，安全解析本质上是可能的，但可执行性却正是这样一个恶名昭彰的缺陷；而YAML缺乏相关的命令语言，可能是一个相对安全的利益。

然而，YAML允许语言特定的标签，因此支持这些标签的解析器能够创建任意本地对象。任何允许复杂对象实例可被执行的YAML解析器将会受潜在的代码注射攻击。

### 数据处理和呈现

XML和YAML规范为数据结点的展现、处理及储存提供了不同的_逻辑_模型。
**XML**: XML文档中的主要逻辑结构是: 1) 元素，2)属性。对于这些基本逻辑结构，基础XML规范对于元素重复性或显示顺序等因素没有定义约束。在XML处理器的定义一致性上，XML规范仅将其归为两类:1) 有效，2) 无效。XML没有为API、处理模型或数据展现模型维护详细定义；尽管某些在用户或规范实现可以独立选择的其他规范中有定义，例如文档对象模型和XQuery。
对于定义有效XML内容的更丰富的模型是W3CXML模式标准。它允许对有效XML内容进行完整规范并被开源、免费和商业处理器和类库广泛支持。
**YAML**: YAML文档中的主要逻辑结构是: 1) 标量， 2) 列表， 3) 哈希表。YAML规范也指出了施用于这些基本罗结构的基本约束。例如，哈希表键值是无序的。当节点顺序很重要的时候，必须使用列表。
而且，在定义L处理器的定义一致性上，YAML规范定义了两种基本操作: 1) 转储； 2)加载。所有YAML兼容处理器必须提供至少一个操作，并可选地提供者两种操作。最后，YAML规范定义了在转储和加载操作处理时所必须创建的信息模型或“表现图”，尽管这些表现不需要通过API被用户访问。

## 实现与函数库

### 移植性

简单的YAML文档（例如：简单的键值对）不需要完整的YAML解析器，便可以被正则表达式解析。许多常用的编程语言──纯用某个语言，让函数库具有可携性──都有的YAML的产生器和解析器。当效能比较重要时，也有许多和C语言绑定的函数库可使用。

### C语言函数库

- [libYAML](http://pyyaml.org/wiki/LibYAML)2007-06时，这个YAML的函数库渐趋稳定，并被YAML格式作者推荐使用。
- [SYCK](http://whytheluckystiff.net/syck/)这个实现支援大部分1.0版的格式，并且被广泛的使用。它使用高阶interpretedlanguages进行最佳化。在2005之后，这个专案已经不再更新，不过仍可使用。

### 其他函数库

下面几种编程语言都有与YAML相关的函数库
- [Perl](https://zh.wikipedia.org/wiki/Perl)
  - [YAML::](http://search.cpan.org/dist/YAML)一个通用的界面，被数个YAML解析器使用。
  - [YAML::Tiny](http://search.cpan.org/dist/YAML-Tiny/)YAML简化版的实现。拥有小巧轻快的优点──比完整功能的YAML实现快上许多──并用纯Perl写成。
  - [YAML::Syck](http://search.cpan.org/dist/YAML-Syck/)与SYCK函数库绑定。提供快速，highly featured的YAML解析器。
  - [YAML::XS](http://search.cpan.org/dist/YAML-LibYAML/)与LibYaml绑定。提供1.1版更好的相容性。
- [PHP](https://zh.wikipedia.org/wiki/PHP)
  - [Spyc](http://spyc.sourceforge.net/) 纯PHP的实现。
  - [PHP-Syck](http://pecl.php.net/package/syck)（与SYCK函数库绑定）
  - [sfYaml](http://trac.symfony-project.org/browser/branches/1.1/lib/yaml/)为[symfony](https://zh.wikipedia.org/wiki/Symfony)项目重写的Spyc,可独立使用， 可以产生和解析YAML文件。
- [Python](https://zh.wikipedia.org/wiki/Python)
  - [PyYaml](http://pyyaml.org/)纯Python，或可选用LibYAML的函数库。
  - [PySyck](http://pyyaml.org/wiki/PySyck)与SYCK绑定。
- [Ruby](https://zh.wikipedia.org/wiki/Ruby)（从1.8版开始，YAML解析器成为标准函数库之一。以SYCK为基础。）
  - [Ya2YAML](http://rubyforge.org/projects/ya2yaml/)with full [UTF-8](https://zh.wikipedia.org/wiki/UTF-8)support
- [Java](https://zh.wikipedia.org/wiki/Java_(programming_language))
  - [jvyaml](https://jvyaml.dev.java.net/) 以Syck为基础，andpatterned off ruby-yaml
  - [JYaml](http://jyaml.sourceforge.net/)纯Java的实现。
- [ R](https://zh.wikipedia.org/w/index.php?title=R_(programming_language)&action=edit&redlink=1)
  - [CRAN YAML](http://biostat.mc.vanderbilt.edu/twiki/bin/view/Main/YamlR) 以SYCK为基础。
- [JavaScript](https://zh.wikipedia.org/wiki/JavaScript)
  - 原生的JavaScript即可产生YAML，但不能解析。
  - [YAML JavaScript](http://sourceforge.net/projects/yaml-javascript) 产生和解析。
- [.NET](https://zh.wikipedia.org/wiki/.NET)
  - [[1]](http://yaml-net-parser.sourceforge.net/)
- [OCaml](https://zh.wikipedia.org/wiki/OCaml)
  - [OCaml-Syck](http://sourceforge.net/projects/ocaml-syck/)
- [C++](https://zh.wikipedia.org/wiki/C++)
  - [ 用C++将libYaml包装](http://git.snoyman.com/cppweb.git?a=blob;f=src/cppmodels/yaml.hpp;h=e67377c792309a51eb5a4c9dac05ba89befd38d6;hb=HEAD)
- [Objective-C](https://zh.wikipedia.org/wiki/Objective-C)
  - [ Cocoa-Syck](http://code.whytheluckystiff.net/syck/browser/trunk/ext/cocoa/src)
- [Lua](https://zh.wikipedia.org/wiki/Lua_(programming_language))
  - [Lua-Syck](http://code.whytheluckystiff.net/syck/browser/trunk/ext/lua)
- [Haskell](https://zh.wikipedia.org/wiki/Haskell)
  - [Haskell Reference wrappers](http://ben-kiki.org/oren/YamlReference/)
- [XML](https://zh.wikipedia.org/wiki/XML)[YAXML](http://yaml.org/xml.html) (currently draft only)
- [Go](https://zh.wikipedia.org/wiki/Go)
  - [go-yaml](https://github.com/go-yaml/yaml) 借鉴 C 库libyaml 设计的 Go 语言移植