---
title: 'RESTful Web Services Cookbook笔记（二）'
date: 2013-10-19 08:32:47
categories: 
- Service+JavaEE
tags: 
- rest
- 最佳实践手册
- webservice
- http
---
# Atom和AtomPub

Atom聚合格式（RFC 4287）和Atom发布协议（也称为AtomPub，RFC5023）定义了条目和种子等资源及其表述和操作协议。Atom主要用于基于文本的、意图让人们去阅读的博客、讨论论坛、评论系统等资源。AtomPub描述了允许客户端创建和修改Atom格式资源的语义，并引入有助于应用程序发现的服务和分类资源。
Atom和AtomPub被用于很多应用场景。尽管Atom通常用于博客种子，也能进行格式扩展以用于用户简介、搜索结果、相簿等应用数据。
下面列举了Atom条目和种子内的一些元素。Atom条目和种子都是可扩展的，也可以引入新的属性和元素。

|元素|描述
|-----
|atom:author|存在于atom:feed和atom:entry内，表现创建条目/种子的作者，包含至少一个atom:name及可选的atom:uri和atom:email子元素
|atom:content|存在于atom:entry内，提供普通文本、HTML或XHTML条目内容或带媒体类型的其他内容，使用src和type属性链接到任意媒体
|atom:summary|存在于atom:entry内，提供条目摘要或描述。与atom:tile相似，提供type属性。
|atom:id|存在于atom:entry内，包含条目的URN格式的全局唯一标识符（例如urn:guid:550e8400-e29b-41d4-a716-446655440123）。其值在条目/种子更新或移动后必须改变。
|atom:link|存在于atom:feed和atom:entry内，每个条目/种子必须包含一个rel值为self的atom:link元素，可以包含relf值为alternate的多个type和hreflang属性唯一的atom:link元素组合，也可以包含链接关联资源的其他atom:link元素。
|atom:title|存在于atom:feed、atom:entry和atom:source内，包含条目/种子的文本标题表述。支持type属性，值为text（默认）、thml或xhtml。
|atom:update|存在于atom:feed和atom:entry内，包含条目/种子的最新更新时间。
|atom:category|存在于atom:feed和atom:entry内，对条目和种子进行分类。
|atom:contributor|每个Atom条目可以包含一个或多个atom:contributor元素。
|atom:generator|存在于atom:entry和atom:source内，指示生成种子的软件或条目来源。
|atom:icon|存在于atom:feed内，每个种子可以包含一个atom:icon元素。
|atom:logo|存在于atom:feed内，每个种子可以包含一个atom:logo元素。
|atom:published|存在于atom:entry内，每个条目可以包含一个atom:published元素，用于指示条目第一次发布的时间。
|atom:rights|存在于atom:entry内，每个条目可以包含一个atom:rights元素，描述权利例如著作权。
|atom:subtitle|存在于atom:feed和atom:source内，每个条目/源可以包含一个atom:subtitle元素。

使用Atom的好处在于互通性。为了使用Atom，将资源建模成条目，集合建模成种子。这些元素在http://www.w3.org/2005/Atom命名空间下定义，该命名空间常用的前缀为atom。
Atom种子和条目的默认内容模型包括文本、HTML或XHTML内容和摘要、标识符、链接、作者、分类等。该内容模型最适合发布和聚合作为种子的信息片。然而，由于其格式获取的基本概念对大多数应用程序有益，可被用于各种场景而不是仅仅用于内容种子。
当资源的信息模型或元数据与Atom种子和条目的语法和语义自然匹配时使用Atom。即使资源的信息模型无法匹配Atom，考虑为其提供由短文本、HTML或XHTML资源摘要和链接。用户可以通过种子阅读器等工具了解资源。
AtomPub引入了服务文档和媒体资源等额外资源，服务文档有助于客户端发现Web服务提供的集合。服务器能够使用媒体资源将语音、视频、图像媒体或任意文档与Atom条目进行关联。
使用服务文档资源将集合汇入工作空间。该资源表述是XML文档，定义在http://www.w3.org/2007/app命名空间的service是文档的根节点。该命名空间常用的前缀为app。表述的媒体类型是application/atomsvc+xml。服务（app:service）包含一个或多个工作空间（app:workspace）。每个工作空间包含多个的集合（app:collection），列举了所有种子URI、可接受媒体类型（app:accept）和分类（app:category）。
分类资源列举了集合内资源的分类，表述是category作为根节点的XML文档，有atom:category元素组成。表述的媒体类型是application/atomcat+xml。
AtomPub是修改Atom文档的应用协议。它描述如何创建、更新和删除Atom条目，也支持编辑诸如图片、打包文件等关联的非文本媒体。如果正在使用Atom格式发布可编辑资源，考虑支持AtomPub。
允许客户端通过提交消息体为Atom条目文档的POST请求来创建新资源。客户端可以接下来对edit关系类型的链接用PUT方法修改或用DELETE方法删除资源。
当表述是Atom条目文档时在媒体类型上添加参数type=entry。
AtomPub引入的资源类型之一是媒体资源。媒体资源是除了Atom条目文档之外的其他资源，可用于表现文档、图片、音频和视频文件等。由于媒体资源不是Atom条目文档且可能是二进制资源，AtomPub对每个媒体资源关联一个媒体链接资源（描述并链接媒体资源的Atom条目）。
客户端通过发送POST请求来创建媒体资源。服务器创建媒体资源和媒体链接资源，并在响应的通过Location头返回媒体链接资源的URI。在媒体链接资源表述中，通过atom:conteng元素的src属性提供新创建的媒体资源URI。


# 内容协商

内容协商有时也称以为conneg，是当多种表述（/变体）可用时为客户端选择资源的最佳表述。尽管内容协商经常与指示媒体类型优先级相关，它也能用于指示语言本地化、字符编码和压缩编码的优先级。HTTP指定了两种内容协商：服务器驱动协商和代理驱动协商。服务器驱动协商使用request头选择一种变体，代理驱动协商为每一种变体使用不同URI。
当实现一个客户端时，对客户端来说向服务器指示自身能够处理的表述格式、语言、字符编码和压缩编码偏好和能力是非常重要的。即使能够通过带外了解响应中上诉信息，清楚指示客户端的偏好和能力有助于客户端面对变化。否则，当服务器决定提供资源的替换表述，HTTP库的任何默认偏好可能提示服务器返回了不同的表述并中断客户端。
在发送请求时，添加一个Accept头，包含逗号分隔的媒体类型优先级列表。如果媒体类型优先级不一样，对每个媒体类型添加一个q参数，以表示相关优先级（1.0～0.0，优先级越高值越大）。如果客户端仅能处理特定格式，在Accept头添加*;q=0.0以表明无法处理Accept头媒体列表之外的媒体。
如果客户端仅能处理特定字符编码，添加带有偏好字符集的Accept-Charset头，否则避免添加Accept-Charset头。为表述的偏好语言添加Accept-Language头。如果客户端能够解压缩诸如gzip、compress或deflate编码的表述，添加带有支持的压缩编码的Accept-Encoding头，否则，不要使用该头。
```
# Request headers
Accept: application/atom+xml;q=1.0, application/xml;q=0.6, **;q=0.0
# Response
HTTP/1.1 200 OK
Content-Language: en
Vary: Accept-Language
...
# Request for German representation
GET /status HTTP/1.1
Host: www.example.org
Accept-Language: de;q=1.0,**;q=0.0
```

当服务器无法满足客户端偏好且客户端显式包含`**;q=0.8`。这样很难在浏览器获得内容协商的表述。
代理驱动协商当客户端无法使用`Accept-*`头来表示偏好时很有效，它通过为每个变体提供不同URI，客户端使用URI来选择期望的表述。在代理驱动协商中，客户端通过从服务器获得的带外信息判断要使用的URI。如果表述存在，服务器返回表述，否则，返回404(Not Found)状态码。尽管所有Accept-*头内要协商的信息都可在代理驱动协商中实现，通常用于媒体类型和语言类型。下面是代理驱动协商的常用做法：
- 查询参数，例如http://www.example.org/status?format=json和http://www.example.org/status?format=xml
- URI扩展，例如http://www.example.org/status.json和http://www.example.org/status.xml
- 子域，例如en.wikipedia.org和de.wikipedia.org

内容协商并不总是适合的，需要考虑Web服务支持多种格式的代价。当客户端需要多种变体或每个变体包含相同信息时，支持多种变体，否则为每个信息使用不同的URI。
在考虑为每个资源支持多种表述之前，需要考虑：
- 应用程序流可能对每种表述格式都不同。
- 内容协商仅在开发框架支持的时候代价才会很小，并不是所有代发框架都支持通过带有多个媒体类型及不同q参数的Accept头返回表述变体的。
- 在某些情况下，法律和商业需求可能是区域性的，代理驱动语言协商可能是更好的途径。
- 缓存可能无法很多好地处理内容协商响应。一些缓存可能会忽略或限制任意给定资源的存储变体个数。


# 查询

查询信息是HTTP GET方法的一种常见应用，查询通常涉及三个组成部分，即过滤（filtering）、排序（sorting）和投影（projection）。过滤是基于一些过滤条件选择实体的一个子集的过程。排序会影响服务器是如何排列响应中结果的。投影是选择实体中哪些字段将被包含到结果的过程。只要关注URI和表述，查询设计还是相对简单的。客户端负责运行查询，服务器的职责包括设计URI来支持过滤、排序和投影，设计表述，设置合适的缓存头。
使用查询参数来设计查询是一种常用惯例，根据自己的用例，可能需要支持以下一种或全部情况的查询参数：
- 从可用资源中选择数据
- 指定排序条件
- 罗列要包含在响应中资源的字段

```
http://www.example.org/book/978-0374292881/reviews?after=2009-08-15&sortbyAsc=date&fields=title

# view参数值是一个预定义的查询，可在服务器优化常用查询，提供更快的响应速度。
http://www.example.org/book/978-0374292881/reviews?after=2009-08-15&view=summary

# 获取所有标题包含“war”，发行于2000年后、至少有100条评论的电影，按年份排序
http://www.example.org/movies$contains('war')$compare(year>2000)$compare(count(comments)>100)?$sortby=year

# 将查询参数值作为SQL WHERE子句的一部分
http://www.example.org/movies?query='.title like 'war' and year > 2000 order by year'

# 使用XPath表达式选择电影标题
http://www.example.org/movies[year>2000&genre='war']/title 
```
后三个特定查询（ad hoc query）对客户端来说很灵活，但是削弱了服务器优化数据存储和后端缓存的能力，从而降低了性能，并可能造成URI和数据存储方式的紧耦合。所以要避免使用通用查询语言（例如SQL或XPath）的特定查询。
HTTP头中一般断点下载时才用到Range和Content-Range实体头进行字节范围请求（Range:bytes=1102-1311）。有一些服务器在查询上也使用范围请求（Range: query:after=2009-08-15&sortByAsc=date），缓存可能会忽略这种非字节范围请求，应该避免使用，而查询参数则更容易实现与支持。
服务器将查询响应的表述设计为集合资源，当没有查询到任何匹配的资源，返回一个空集合。
尽管HTTP没有限制URI的长度，但它的一些实现处于安全原因对此进行限制，以避免缓存溢出，阻止用户将大量过滤条件编码到URI。使用HTTP POST来支持大查询。使用POST处理查询削弱了HTTP的统一接口。根据定义，GET才是用于安全、幂等地获取消息的。而且缓存把HOST方法的响应当成是不可缓存的，其后果是丧失了缓存能力，尤其增加了分页查询时的时延。然而在遇到实际限制时，这种权衡也是必不可少的。
服务器可以使用查询存储让那些使用POST方式发送的查询变得可以缓存。当客户端使用POST发起一个查询请求时，服务器创建一个包含查询条件的新查询资源，返回一个带有（指向新查询资源）Location头的响应码201(Created)。客户端对新查询资源发起GET请求，返回查询结果。如果客户端再用POST发起相同查询请求，服务器会找到匹配该请求的查询资源，客户端被重定向到该资源的URI上。存储查询弥补了使用POST方式处理查询的一些局限，缺点是不得不将查询永久保存为一个资源。此外，如果查询数量很大，服务器最终很有可能积聚大量不频繁使用的查询，需要频繁清理这些查询。而大量查询也会造成缓存命中率低下，缓存被很快占满，废弃很多不太使用的URI。


# web缓存

当缓存能在不联系原服务器并能提供响应时，缓存会非常有效率地工作。有到期机制的缓存用于降低原服务器接受请求个数并降低应用所耗带宽。有到期机制的缓存基于Cache-Control和Expires头。这些头指导客户端和缓存在一定时间段内保留服务器返回的表述副本。缓存在时间窗内甚至在时间窗外不联系原服务器使用缓存的表述副本服务后继请求。
基于更新频率，决定缓存到期时间。此时间段后，缓存将认为缓存的表述是陈旧的。Cache-Control头是HTTP 1.1头，其max-value值是以秒为单位的新鲜生命期。为了支持遗留的HTTP 1.0缓存，也要包含Expires头及到期时间。如果决定缓存不应保留副本，使用值为no-cache的Cache-Control头。为了支持支持遗留的HTTP 1.0缓存，也要包含Pragma:no-cache头。
下面列举了Cache-Control指令：

|指令|应用
|-----
|public|默认值。当请求是鉴权过的但仍希望允许共享缓存提供缓存响应服务，也可以用此指令
|private|当响应对客户端或用户私有或基于鉴权时使用。当此指令存在时，客户端缓存（例如浏览器缓存和转发代理）可以缓存表述，但服务器上或网络中的共享缓存不能进行缓存。
|no-cache和no-store|此指令防止任何缓存存储或提供缓存的表述。
|max-age|此指令是以秒为单位的新鲜生命期。
|s-maxage|此指令类似于max-age但仅用于共享缓存。当原服务器同事设置了max-age和s-maxage，缓存使用那个s-maxage。实践中，单设max-age就够了。
|must-revalidate|使用此指令请求缓存在提供陈旧表述之前检查原服务器。
|proxy-revalidate|此指令类似于must-revalidate除了它仅作用于共享缓存。

```
# Response
HTTP/1.1 200 OK
Date: Sun, 09 Aug 2009 00:56:14 GMT  
Last-Modified: Sun, 09 Aug 2009 00:56:14 GMT 
Expires: Sun, 09 Aug 2009 01:56:14 GMT 
Cache-Control: max-age=3600,must-revalidate 
Content-Type: application/xml; charset=UTF-8
```
像Squid之类的Cache为Cache-Control头提供了两个扩展指令stale-if-error和stale-if-revalidate。服务器使用stale-if-error告知缓存在max-age超时后仍可是使用一段时间的陈旧表述。服务器使用stale-if-revalidate告知缓存在max-age超时后在异步检查服务器响应的同时仍可是使用一段时间的陈旧表述。
并不是所有HTTP响应都被缓存。关于HTTP 1.1，GET、HEAD和POSt方法的响应可以缓存，但缓存认为该方法不可被缓存。对GET和HEAD请求的带有成功状态码的响应设置到期缓存头。无需对其他方法设置到期缓存头。除了带有200 (OK)状态码的成功响应设置到期缓存头，也可以考虑下面的3xx和4xx响应码。这有助于减少来自客户端的错误触发流量。这称之为消极缓存。

|状态码|介绍
|-----
|300 (Multiple Choices)|带有这个状态码的表述可能很少频繁改变。将此响应缓存可以降低服务器负载。
|301 (Move Permanently)|当资源永久搬移，将URI存储在数据库的客户端肯能不会更新。在这种情况下，缓存转发响应可以不联系原服务器。
|400 (Bad Request)|当服务器返回此状态码，假定客户端就不会重发请求了。但有些客户端由于软件bug或者故意会重发请求。
|403 (Forbidden)|如果服务器永久拒绝服务此资源时添加。
|404 (Not Found)|资源不存在时添加
|405 (Method Not Allowed)|客户端可能由于软件bug重发请求。
|410 (Gone)|资源不再存在，因此缓存应尽可能为此返回错误响应。

除非使用线程软件，否则避免在客户端应用程序支持到期缓存，而是在客户端网络部署转发代理缓存，并且避免在客户端代码实现自己的缓存层（工作量大、维护复杂且耦合度高）。
复合资源中有一些数据是不经常改变的，而有一些数据可能是频繁改变的。对到期缓存处理和过期头设置基于最易于改变数据的最强新鲜需求制定。
支持缓存的一个挑战是在客户端没有发送请求时保持缓存新鲜（数据最新）且温暖（缓存不空）。当客户端上传一个新资源，所有缓存都没有这个资源，因此服务器必须为请求生成表述。一个新部署的缓存，必然是空的，只有随着客户端开始请求后才能进行填充。温暖的缓存避免冷启动问题。尽可能将超时与更新频率同步。如果不可能，实现监控数据库等新、定时通过无条件GET请求更新缓存的后台进程。如果使用Squid，使用HTTP缓存通道扩展将资源更新复制到缓存。


# 条件请求

HTTP条件请求有助于解决两个问题。对于GET请求，条件请求帮助客户端和缓存检验缓存的表述是否新鲜。对于PUT、POST和DELETE等不安全的请求，条件请求提供了并发控制。不支持条件GET请求会将降低性能。但对于并发，不支持条件POST、PUT和DELETE请求不安全而且可能影响应用程序完整性。缺乏足够的并发控制检查，服务器容易“丢失更新”或“陈旧删除”。当客户端它基于自认为的资源当前状态提交请求修改或删除资源，但在并发条件下，资源的当前状态并不是静态的，服务器（通过后端方式）或其他客户端都有可能已经修改或删除了资源。
并发控制确保客户端对数据的并发操作被正确处理。有两种并发控制实现方式：
- 悲观并发控制：锁机制。
- 乐观并发控制：此模式下，客户端首先获得令牌，之后在写请求中携带此令牌，如果令牌有效则操作成功，否则操作失败。HTTP以此模式工作。

服务器使用Last-Modified和ETag响应头驱动条件请求。客户端使用If-Modified-Since和If-None-Match验证缓存表述，使用If-Unmodified-Since和If-Match进行并发控制预处理。
如果对存储资源的数据存储区能够控制，修改每个资源的schema以包含用来跟踪版本的修改时戳或序列号。如果数据存储区是数据库，使用触发器在数据修改时自动更新上述字段。如果无法修改存储schema或数据存储区不允许维护时戳或序列号，使用资源数据生成ETag头数值，并存储到单独的表或存储区。如果表述不是很大，使用表述体生成MD5哈希值或每次随资源变动的某些字段用于ETag。Last-Modified是一种弱验证，ETag是一种强验证，两者不必同时使用。
如果客户端在本地存储表述体，可以将响应的Last-Modified和ETag头一同存储。客户端基于上次请求响应的Last-Modified和ETag头发送带有If-Modified-Since或If-Non-Match的条件GET请求，服务器发现表述没有改变，可以省去发送表述体仅发送状态码304 (Not Modified)，否则发送包含新ETag或Last-Modified头的最新表述体。
```
# 客户端在一小时后发出第三个相同请求
GET /person/joe HTTP/1.1 
Host: www.example.org

# 缓存向原服务器发送请求
GET /person/joe HTTP/1.1 
Host: www.example.org
If-Modified-Since: Sun, 09 Aug 2009 00:40:14 GMT
If-None-Match: "3f4a74db207d0447d46710a64971e777"

# 服务器产生的响应
HTTP/1.1 304 Not Modified 
Date: Sun, 09 Aug 2009 01:54:14 GMT
Last-Modified: Sun, 09 Aug 2009 00:56:14 GMT
Expires: Sun, 09 Aug 2009 02:54:14 GMT
Cache-Control: max-age=3600,must-revalidate
E-Tag: "3f4a74db207d0447d46710a64971e777"
Content-Type: application/xml; charset=UTF-8

# 缓存返回的响应
HTTP/1.1 200 OK 
Date: Sun, 09 Aug 2009 00:54:14 GMT
Last-Modified: Sun, 09 Aug 2009 00:40:14 GMT
Expires: Sun, 09 Aug 2009 01:44:14 GMT
Cache-Control: max-age=3600,must-revalidate
...
```
服务器处理条件PUT请求 ![RESTful Web Services Cookbook笔记（二）](/images/2013/10/0026uWfMty6FiLFRZ0R31.png)
服务器处理条件DELETE请求 ![RESTful Web Services Cookbook笔记（二）](/images/2013/10/0026uWfMty6FiLGJNAxf5.png)
当客户端使用条件GET请求查询失败，获得412 (Precondition Failed)状态码。HTTP 1.1允许客户端修改到期缓存、使用包含Cache-Control:no-Cache和Pragma:no-cache的无条件GET请求获取新鲜表述。
当客户端使用PUT创建新资源时，或服务器在同一资源的上一个GET或PUT请求响应中没有返回Last-Modified或ETag头，客户端像和平时一样发送PUT请求。
如果客户端拥有之前对资源请求响应的Last-Modified和ETag头，客户端基于上次请求响应的Last-Modified和ETag头发送带有If-Unmodified-Since或If-Match的条件PUT/DELETE请求。如果服务器返回412 (Precondition Failed)状态码，客户端可通过无条件GET请求获取新鲜表述，决定是否通过重发PUT/DELETE实现自己的需求。
与PUT或DELETE不同，对一个资源的POST请求可能不会对请求URI中的资源造成任何改变。服务器可能会创建一个新资源（状态码201）或使用不同URI（状态码303）标识输出。因此，客户端不会在本地存储表述和条件头。为了让服务器检测和防止客户端重复发送POST请求，可以通过一次性URI实现条件或不可重复的POST请求。
客户端实现通过GET请求获取包含token链接，如果URI的目的是创建新资源，基于序列号、时戳和随机数的连接串生成token。如果URI的目的是修改资源，基于这些资源的实体标签和标识符生成token。
客户端发送服务器响应中提供的一次性URI进行POST请求，服务器查看token是否已经在服务器的事务日志中存在，以检测POST请求有效性，如果存在返回状态码403 (Forbidden)并解释原因，否则根据输出返回状态码201 (Created)或303 (See Other)。