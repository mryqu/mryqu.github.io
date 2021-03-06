---
title: 'RESTful Web Services Cookbook笔记（一）'
date: 2013-10-19 08:10:45
categories: 
- Service+JavaEE
tags: 
- rest
- 最佳实践手册
- webservice
- http
---
# 使用统一接口

HTTP是一种应用层协议，它定义了客户端与服务器之间的转移操作的表述形式。在此协议中，诸如GET，POST和DELETE之类的方法是对资源的操作。有了它，无须创造createOrder,getOrder,updateOrder等应用程序特定的操作了。
作为应用协议，HTTP的设计目标是在客户端和服务器之间保持对库、服务器、代理、缓存和其他工具的可见性。可见性是HTTP的一个核心特征。
一旦识别并设计资源，就可以使用GET方法获取资源的表述，使用PUT方法更新资源，使用DELETE方法删除资源，以及使用POST方法执行各种不安全和非幂等的操作。可以添加适当的HTTP标头来描述请求和相应。
以下特性完全取决于保持请求和相应的可见性：
- 缓存：缓存响应内容，并在资源修改时使缓存自动失效。
- 乐观并发控制：检测并发写入，并在操作过期的表述时防止资源发生变更。
- 内容协商：在给定资源的多个可用表述中，选择合适的表述。
- 安全性和幂等性：确保客户端可以重复或重试特定的HTTP请求。

HTTP通过以下途径来实现可见性：
- HTTP的交互是无状态的，任何HTTP中介都可以推断出给定请求和响应的意义，而无须关联过去和将来的请求和响应。
- HTTP使用一个统一接口，包括有OPTIONS，GET，HEAD，POST，DELETE和TRACE方法。接口中的每一个方法操作一个且仅一个资源。每个方法的语法和含义不会因应用程序和资源的不同而发生改变。
- HTTP使用一种与MIME类似的信封格式进行表述编码。这种格式明确区分标头和内容。标头是可见的，除了创建、处理消息的部分，软件的其他部分都可以不用关心消息的内容。

保持可见性的另一方面是使用适当的状态码和状态消息，以便代理、缓冲和客户端可以决定请求的结果。
在某些情况下，可能需要权衡其他特性，如网络效率、客户端的便利性以及分离关注点，为此放弃可见性。当进行这种权衡时，应仔细分析对缓存、幂等性、安全性等特性的影响。
当有多个共享数据的资源，或一个操作修改多个资源时，需要权衡是否降低可见性（例如是否禁止缓存）以便获得更好的信息抽象、更松散的耦合程度、更好地网络效率、更好地资源粒度，或纯粹为了方便客户端使用。
可以通过带有应用程序状态的URI链接来保持应用程序状态而无需依赖服务器中内存中的会话。
安全性和幂等性是服务器要实现的HTTP方法的特征。当客户端发送GET、HEAD、OPTIONS、PUT或DELETE请求时，如果没有使用并发条件限制时，确保服务器提供相同响应。

|方法|是否安全?|是否幂等?
|-----
|GET|是|是
|HEAD|是|是
|OPTIONS|是|是
|PUT|否|是
|DELETE|否|是
|POST|否|否

客户端通过下列方法实现幂等的/安全的HTTP请求：
- 将GET、OPTIONS和HEAD视为只读操作，可按需随时可发送请求。
- 在网络或软件异常的情况下，通过If-Unmodified-Since/If-Match条件标头重发GET、PUT和DELETE请求。
- 不要重发POST请求，除非客户端（通过服务器文档）知道对特定资源的POST实现是幂等的。

Web基础设施严重依赖于GET方法的幂等性和安全性。客户端期望能够重复发起GET请求，而不必担心造成副作用。缓存依赖于不需访问源服务器就能提供已缓存表述的能力。
不要把GET方法用于不安全和非幂等操作。因为这样做可能造成永久性的、意想不到的、不符合需要的资源改变。
可以使用POST方法或PUT方法创建新资源。只有在客户端可以决定资源的URI时才使用PUT方法创建新资源；否则使用POST，由服务器决定新创建资源的URI（客户端请求可以使用Slug头建议新资源的URI）。
在以下场合中使用POST方法：
- 创建新的资源，把资源作为一个工厂
- 通过一个控制器资源来修改一个或多个资源
- 执行需要大数据输入的查询
- 在其他HTTP方法看上去不合适时，执行不安全或非幂等的操作。（缓存不会缓存这一方法的响应）

使用POST方式实现异步任务：服务器在接受到POST请求时，返回状态码202（Accepted），并包含一个让客户端可以跟踪异步任务状态的资源表述和客户端稍后检查状态的建议时间（ping-after）。
客户端使用GET请求查询异步任务状态，如服务器还在执行中，返回响应码200（OK）及包含当前状态的任务资源表述；如服务器成功完成，返回响应码303（SeeOther）以及包含新资源URL的Location头；如服务器任务失败，返回响应码200（OK）及任务失败的表述。
使用DELETE方法实现异步请求：服务器在收到DELETE请求，返回状态码202（Accepted），并包含一个让客户端可以跟踪异步任务状态的资源表述和客户端稍后检查状态的建议时间（ping-after）。
客户端使用GET请求查询异步任务状态，服务器返回响应码200（OK）及包含当前状态的任务资源表述。
避免使用非标准的自定义HTTP方法。当前比较有名的自定义方法包括WebDAV定义的方法、PATCH和MERGE。
HTTP服务器可能会使用自定义HTTP标头，比较有名的自定义HTTP包括X-Powered-By、X-Cache、X-Pingback、X-Forwarded-For及X-HTTP-Method-Override。实现客户端和服务器时，要让他们在没有发现需要的自定义标头时也不会失败。避免使用自定义HTTP标头改变HTTP方法的行为。


# 识别资源

从领域名词中识别资源。
直接将领域实体映射为资源可能导致资源效率低下且难以使用，可以通过网络效率、表述的多少以及客户端的应用程度来帮助确定资源的粒度。
粗粒度设计便于富客户端应用程序，更精细的资源颗粒可以更好地忙族缓存的要求。因此，应从客户端和网络的角度确定资源的粒度。下列原书可能会进一步影响资源粒度：
- 可缓存性
- 修改频率
- 可变性

仔细设计资源粒度，以确保使用更多缓存，减少修改频率，或将不可变数据从使用缓存较少、修改频率更高或可变数据分离出来，这样可以改善客户端和服务器端的效率。
基于应用程序特有的条件来识别相似的资源（例如共享同一数据库schema的资源，有相同特性或属性的资源），可以将这些有共性的资源组织成为集合。
基于客户端的使用模式、性能和延时要求，确定一些新的聚合其他资源的复合资源，来减少客户端与服务器的交互。
符合资源降低了统一接口的可见性，应为它们的表述中包含了和其他资源相重叠的资源。因此，在提供复合资源前,需要考虑一下几点：
- 如果在应用程序的请求很少，那么它可能不是一个好的选择。依赖缓存代理，从缓存中获取这些资源，也许能让客户端收益匪浅。
- 另一个因素是网络开销--客户端与服务器之间的网络开销，服务区和后端服务或他所依赖的数据存储之间的网络开销。如果后者开销很大，那获取大量数据并在服务器上将他们组合成复合资源可能会增加客户端的延时，降低服务器的吞吐量。
- 想要改善延时，可以在客户端和服务器之间增加一个缓存层，并避免复合资源，进行一些负载测试来验证复合资源是否能起到改善作用。

最后，为每个客户端创建特定目标的复合资源并非是注重实效的做法。选择对Web服务最重要的客户端，设计复合资源来满足它们的需要。
像计算两地距离、行车路线、信用卡验证之类的计算或处理函数可被当作资源处理，并使用带有查询参数的HTTP GET获取函数输出表述。
当需要原子性修改多个资源时，可以为每个不同的操作指派一个控制器。客户端通过HTTP POST方法提交请求触发操作。如果操作结果是创建一个新资源，返回响应码201（Created）并在Location头里包含新资源的URL。如果操作结果是对一个或多个已有资源的修改，返回响应码303（See Other）并在Location头里包含客户端可用户获取修改表述的URL。如果服务器无法提供所有修改资源的单个URI，返回状态码200（OK）并在消息体内包含客户选可以用于了解操作结果的表述。
在RESTful Web服务中，控制器有助于对服务器和客户端之间进行关注分离，增进网络效率，让服务器端原子性地实现复杂操作。


# 设计表述

在HTTP设计中，发送发可以用一些名为实体头的标头来描述表述正文（也成为实体正文或消息正文）。有了这些标头，接收方可能在无须查看正文的情况下决定如何处理正文，还可以将解析正文所需要提前了解及猜测的内容尖刀最小程度。
使用以下标头来注解包含消息正文的表述：

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="table-layout: auto; font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th width="120px">标头</th><th>用途</th><th>解析处理</th></tr><tr><td>Content-Type</td><td>用于描述表述类型，即通常所说的media-type或MIME类型，包含charset参数或其他针对该媒体类型而定义的参数。<br><table><tbody><tr><th>媒体类型</th><th>格式</th><th>参考规范</th></tr><tr><td>application/xml</td><td>通用XML格式</td><td>RFC 3023</td></tr><tr><td>application/*+xml</td><td>使用XML格式的特殊用途媒体格式</td><td>RFC 3023</td></tr><tr><td>application/atom+xml</td><td>用于Atom文档的XML格式</td><td>RFC 4287<br>RFC 5023</td></tr><tr><td>application/json</td><td>通用JSON格式</td><td>RFC 4627</td></tr><tr><td>application/javascript</td><td>JavaScript, 用于可以处理JavaScript的客户端</td><td>RFC 4329</td></tr><tr><td>application/x-www-form-urlencoded</td><td>查询字符串格式</td><td>HTML 4.01</td></tr><tr><td>application/pdf</td><td>PDF</td><td>RFC 3778</td></tr><tr><td>text/html</td><td>多种版本的HTML</td><td>RFC 2854</td></tr><tr><td>text/csv</td><td>逗号分隔值，一种通用格式</td><td>RFC 4180</td></tr></tbody></table><br>这个标头告诉接收方如何解析数据。例如，如果标头是application/xml或其他以+xml结尾的值，就可以用XML解析器来解析消息。如果是application/json，就可以用JSON解析器。没有此标头时，就只能解析正文的格式了。</td><td>当收到一个不太Content-Type的表述，避免猜测表述的类型。当客户端发送不带该标头的请求时，返回错误码400（Bad Request）。当从服务器接收到一个不带标头的响应时，将其视为不正确的响应。</td></tr><tr><td>Content-Length</td><td>最早从HTTP 1.0中被引入，用于指定表述正文的大小。<br>发送方需要在写正文前计算出表述的大小并设置该标头，接收方用它来判断自己是否从连接中读取了正确的字节数。<br>HTTP 1.1支持一种名为分块传输编码的更有效机制，这让Content-Length头变的有点多余。如果客户端不支持HTTP 1.1，需要包含Content-Length。此外对于POST和PUT请求就算使用分块传输编码,也要在客户端应用程序的请求中同时包含Content-Length头，因为有些代理会拒绝缺失Content-Length和Transfer-Encoding: chuncked的POST和PUT请求。<br><pre style="border: 1px solid rgb(60, 120, 181); background-color: rgb(180, 180, 180);">HTTP/1.1 200 OK
Last-Modified: Thu, 02 Apr 2009 02:32:28 GMT
Content-Type: application/xml;charset=UTF-8
Transfer-Encoding: chunked
FF
[some bytes here]
        
58
[some bytes here]
0</pre></td><td>在没有确定接收到表述不带Transfer-Encoding: chunked前，不要检查Content-Length头是否存在。</td></tr><tr><td>Content-Language</td><td>如果使用某种语言对表述进行本地化，使用该标头来指定语言。值是两个字母的RFC5646语言标签，还可以在谋面带上连字符（-）和任意两个字母的国家代码。如en-US或kr。</td><td>如果存在该标头，读取并存储它的值，记录下使用的语言。</td></tr><tr><td>Content-MD5</td><td>工具/软件在处理或存储表述时可能存在错误，需要提供一致性校验来验证实体正文的完整性，用该标头的值是表述正文（在进行内容压缩编码之后，分块传输编码之间计算）的MD5摘要。请注意，TCP使用checksum在传输层提供一致性校验，因此此标头对非可靠网络发送或接受大的表述时非常有用。</td><td></td></tr><tr><td>Content-Encoding</td><td>当使用gzip、compress或deflate对表述正文进行编码时，使用该标头。接收方在解析正文前需要先解压缩消息。客户端可以用Accept-Encoding头来表明自己偏好的Content-Encoding。然而，并没有一个标准的方式让客户端了解到服务器是否可以处理用给定编码压缩过的表述。</td><td>让网络库代码来解压这些压缩过的表述。</td></tr><tr><td>Last-Modified</td><td>仅用在响应上的标头，值是一个时间戳，表示服务器最后修改表述或资源的时间。</td><td></td></tr></tbody></table>

大多数情况下，客户端应用程序只需检查Content-Type头和字符编码，以此决定如何解析表述的正文。
一定要基于Content-Type、Content-Language和Content-Encoding头的值来处理响应的表述。
在发送表述时，如果媒体类型允许使用charset参数，则包含一个带字符编码值的charset参数，该参数值将被用于将字符转为字节。当接收到一个表述时，如果带有支持charset参数的媒体类型，使用其指定编码将表述正文的字节构造成字符流；如果收到一个不带charset参数的XML、JSON或HTML表述，让解析器通过相应格式规范的算法检查头几个字节来确定字符集。
JSON媒体类型application/json不指定charset参数，而是使用UTF-8作为默认编码。
另一个引入字符编码不匹配的常见途径是在XML表述的Content-Type头中给定一个编码，正文却又给定另一个编码。这时需要使用charset参数而不是中文中的编码。
还要比避免对XML格式的表述使用text/xml媒体类型，text/xml的默认字符是us-ascii，而application/xml使用UTF-8。
如果需要设计新的格式和媒体类型，考虑以下指导方针：
- 如果媒体类型是基于XML的，使用+xml结尾的子类型。
- 如果媒体类型是私有的，使用vnd.开头的子类型，例如application/vnd.example.org.user+xml。
- 如果打算使媒体类型公共，按照RFC 4288向IANA注册新的媒体类型。

尽管自定义的媒体类型能改善协议级可见性，但现有的用于监控、国旅、路由HTTP流量的协议级工具可能不太关注，甚至不关注媒体类型。因此，没有必要仅仅为了协议层面的可见性而使用自定义媒体类型。
在XML（JSON）表述中，包含一个指向资源自身的self链接。对于那些组成资源的应用程序领域实体，在表述中包含它们的标识符。如果表述中的某个部分包含自然语言文本，添加xml：lang属性（增加一个属性），表示元素的内容用的是本地化语言。
在集合表述中包含以下内容：
- 一个指向集合资源的self链接。
- 如果集合是分页的，包含指向可能的上一页和下一页的链接。

设计集合的表述，以使集合成员在结构和语法上类似（同构）。
除了文本对最终用户的表述有意义之外，避免使用语言、区域或国家特定的格式或格式识别符。而是使用下列可移植的格式：
- 使用W3C XML模式中定义的decimal、float和double数据类型格式化包含汇率的数字。
- 使用ISO 3166中的国际和地区代码
- 使用ISO 4217中的货币代码
- 使用RFC 3339中的日期和时间值
- 使用BCP 47的语言标识符标签
- 使用Olson时区信息数据库中的时区标识符

对于RESTful Web服务，URI是资源的唯一标识符。然而，应用程序代码经常必须处理领域实体标识符（比如数据库中的ID）。应用程序领域实体标识符可作为资源表述中的URN加入。
有些表述可能需要在文本表述中包含二进制数据，可以使用如下的多部分媒体类型。避免对文本格式内的二进制数据使用Base64编码。

|媒体类型|用途
|-----
|multipart/form-data|对数据的名值对及混合多部分任意媒体类数据进行编码，用于通过HTML表单上传文件。
|multipart/mixed|对多部分任意媒体类型进行打包。例如作为application/xml的视频元数据和作为video/mpeg的视频二进制数据被组合进入一个单独的HTTP消息内。
|multipart/alternative|当对相同资源使用不同媒体类型传送替代表述时使用。例如使用text/plain的普通文本和text/html的HTML格式发送邮件
|multipart/related|当各部分互相挂念并需要一同处理时使用。第一个部分是首部分，且通过Content-ID头引用其他部分。

下例展示用户上传file1.txt和file2.gif
```
Content-type: multipart/form-data, boundary=AaB03x

--AaB03x
content-disposition: form-data; name="field1"

Joe Blow
--AaB03x
content-disposition: form-data; name="pics"
Content-type: multipart/mixed, boundary=BbC04y

--BbC04y
Content-disposition: attachment; filename="file1.txt"
Content-Type: text/plain

... file1.txt 的内容...
--BbC04y
Content-disposition: attachment; filename="file2.gif"
Content-type: image/gif
Content-Transfer-Encoding: binary

... file2.gif的内容...
--BbC04y--
--AaB03x--
```

对于那些希望能被最终用户使用的资源，应该为他们提供HTML表述。避免为机器客户端设计HTML表述。以HTML文档的相识提供部分或全部表述时，考虑使用为格式或RDFa来注解HTML，可以让Web爬虫和同类软件从HTML文档中提取信息，而无须依赖文档的结构。
对于那些由客户端输入造成的错误，返回带4xx状态码的表述。对那些由于服务器实现或其当前状态造成的错误，则返回带5xx状态码的表述。这两种情况下，都要包含一个Date头，以表示错误发生时间。
除非请求的方法是HEAD，否则都应该在表述中包含一段正文，使用内容协商或是和阅读的HTML或村文本对其进行格式化和本地化。
如果能以独立的、适合阅读的文档形式来提供纠正或调试错误的信息，就包含一个指向该文档的链接，可以使用Link头，也可以使用正文中的链接。
如果为了后期最终或分析，在服务器上记录了错误日志，应该提供一个可以找到该错误的标识符或链接。
响应正文要具有描述性，但不应该包含注入错误堆栈、数据库连接错误之类的详细信息。如果可以的话，说明客户端可以采取的后续措施。

|错误码|描述|客户端解决方案
|-----
|400(Bad Request)|当服务器由于语法错误无法解读请求时，返回该错误码。|查看错误表述的正文，了解问题的根本原因。
|401(Unauthorized)|当客户端无权访问资源，但在身份验证后可以获得访问权限时返回错误码。如果服务器就算是在身份验证后也不允许客户访问资源，那应该返回403(Forbidden)错误码。返回该错误码时，应该包含一个带有身份验证方法的WWW-Authenticate头。通常使用的方法是Basic和Digest。|如果客户端是面向用户的，提示用户提供身份信息。其他情况下，获取必要的安全身份信息。用带有Authorization头的请求进行重试，其中包含了身份信息。
|403(Forbidden)|当服务器不让客户端获得资源的访问权限，就算通过身份验证也没用时，返回该错误码。|这个错误意味着禁止客户端用这个请求方法来访问资源，不要重复引起该错误的请求。
|404(Not Found)|当没有找到资源时返回该错误码。如有可能，在消息体中说明原因。|资源在服务器端已经不存在了。如果客户端保存了资源的数据，清楚数据或将其标记为已删除。
|405(Not Allowed)|当资源不允许使用某个HTTP方法时返回该错误码。返回一个Allow头，其中带有该资源的有效HTTP方法。|查看Allow头来寻找适用于该资源的方法，然后做适当的代码变更，只用那些方法来访问资源。
|406(Not Acceptable)|内容协商失败|调整Accept-*头
|409(Conflict)|当请求与资源的当前状态有冲突时返回该错误码，并包含一段正文解释原因。|查看PUT的表述正文中列出的冲突。
|410(Gone)|资源以前存在，但今后不会再存在，返回该错误码。除非记录了被删除的资源，否则不能返回这个错误码。如果没有在服务器记录被删除的资源，应该用404(Not Found)取代。|将其等同于404(Not Found)。
|412(Precondition Failed)|条件请求失败|HTTP1.1允许客户端修改到期缓存、使用包含Cache-Control:no-Cache和Pragma:no-cache的无条件GET请求获取新鲜表述。之后进行后继处理。
|413(Request Entity Too Large)|当POST或PUT请求的消息体过大时返回该错误码。如有可能，在正文中说明允许哪些内容，提供一个备选方案。|在响应正文里寻找有效长度的提示。
|414(Unsupported Media Type)|当客户端用一种服务器不理解的格式来发送消息体时返回该错误。|在响应正文里了解请求支持的媒体类型。
|500(Internal Server Error)|由于某些实现上的问题，代码在服务器端失败时返回该错误码是最好的选择。|记录该错误日志，随后通知服务器开发者。
|503(Service Unavailable)|服务器在某个特定间隔或一段不确定的时间内无法完成请求时，返回该错误码。抛出该错误的两个常见场合是后端服务器失败（例如数据库连接失败）或是客户端请求达到了某个服务器设定的频率上限。如有可能，包含一个带日期或秒数的Retry-After响应头，用它的值来做提示。|如果响应中有Retry-After头，在到达时间之后进行重试。


# 设计URI

在设计URI时遵循常用惯例具有下列优势：
- 遵循惯例的URI一般容易调试和管理。
- 服务器可以集中从请求URI中提取数据的代码。
- 可以避免花费宝贵的设计与实现时间来发明处理URI的新惯例和规则。
- 通过跨域、子域和路径来对服务器的URI进行分区，以实现负载分配、监控、路由和安全方面的操作灵活性。

针对本地化、分布式、强化多种监控及安全策略等方面的需求，可以使用域及子域对资源进行合理的分组或划分。（例如基于本地化或客户端进行子域划分）
- 在URI的路径部分使用斜杠分隔符（/）来表示资源之间的层次关系。
- 在URI的路径部分使用逗号（,）和分号（;）来表示非层次元素。分号通常用于表示矩阵参数。
- 使用连字符（-）和下划线（_）来改善长路径中名称的可读性。
- 在URI的查询部分使用“与”符号（&）来分隔参数。
- 在URI中避免出现文件扩展名（例如.php、.aspx和.jsp）。
- 慎用空格和大写字符，以免造成问题。空格是有效的URI字符，但是RFC 3986会将其编码为%20，而applicaton/x-www-form-urlencoded媒体类型会将其编码为+。RFC 3986定义URI除了协议和主机之外的其他部分是大小写敏感，而基于Windows的Web服务器却大小写的影响。

将URI视为不透明的标识符，及需要确保每个资源具有唯一的URI。然而，这可能造成超负荷的URI。在这种情况下，URI可能会变成未定信息和操作的通用网关。这会导致不正确的缓存响应，甚至没有适当鉴权不应该共享的安全数据被泄露。
- 仅使用URI来判断处理请求的资源。例如不要使用定制HTTP头来判断资源。
- 不要重复的状态变化封装入使用相同URI或定制头的POST隧道以造成URI超载。定制头仅用于信息告知用途。

为了让客户端将URI视为不透明的标识符，尽可能在运行时表述消息体和标头中提供URI，这有助于降低服务器和客户端之间的耦合。如果不能提供可能要用到的URI全集，考虑使用URI模板（半耦合）或建立带外规则（紧耦合）以便客户端能够以编程的方式构建URI。
URI应该设计用于很长时间。客户端可能将URI存储到数据库或配置文件，甚至在代码中硬编码。服务器改变了URI，可能会导致客户端无法正常工作。
应该基于稳定概念、标识符和信息来设计URI。如果URI必须改变，来在原有URI的请求可以通过301 (Moved Permanently)转移到新的URI。如果URI被废除，使用401 (Gone)表示其不再有效。


# web链接

HTML、XHTML及Atom建立了在表述中包含链接的规则。理解这些格式语义的客户端可以发现表述中的链接。然而，XML是通用格式，应该由服务器负责设计在XML格式表述中包含链接并将其设计文档给客户端。
XML表述可以使用Atom中定义的link元素。该元素在http://www.w3.org/2005/Atom命名空间定义且具有下列属性：

|属性|介绍
|-----
|href|包含链接的RUI
|rel|指示链接的类型
|title（可选）|人可读的链接标题。
|type（可选）|服务器为链接URI返回表述的媒体类型
|hreflang（可选）|服务器为链接URI返回表述的内容语言
|length（可选）|服务器为链接URI返回表述的内容长度

href既可以是绝对URI也可以是相对URI（需要在link元素中包含xml:base属性）。![RESTful Web Services Cookbook笔记（一）](/images/2013/10/0026uWfMgy6RTyZ9Mdr89.png)
对应Atom的link定义，在JSON表述中可以使用link（或links）特性。
Link标头提供了一种格式无关的方式来传送链接。除了使用表述体内的嵌入链接，也可以使用link标头。Link标头适用于下列场景：
- 表述使用二进制格式，例如图像、富文本文档、表单等。
- 表述的格式不容易很容易发现链接（例如普通文本文档）。
- 当客户端/服务器软件需要不解析表述体添加或读取链接。![RESTful Web Services Cookbook笔记（一）](/images/2013/10/0026uWfMgy6RTzi8xop2d.png)

对链接中的URI没有分配有意义的语义，链接自身就没有什么左右。链接关系类型传送了链接的角色和目的。一旦客户端与服务器对这些类型的含义达成一致，客户端就能发现并使用链接中的URI了。有两种方式为链接关系类型分配值。
- 当链接目的与下列表中的标准类型匹配，使用该值。
   <table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;"><tbody><tr><th>名称</th><th>用途</th></tr><tr><td>self</td><td>使用此类型链接资源的推荐URI</td></tr><tr><td>alternate</td><td>使用此类型提供相同资源替换版本的URI链接（例如某pdf文档的英文版和中文版）</td></tr><tr><td>appendix</td><td>使用此类型提供作为资源集合附录的资源URI链接</td></tr><tr><td>bookmark</td><td>在博客系统使用此类型提供摘要URI链接</td></tr><tr><td>chapter、section和subsection</td><td>使用这些类型用于链接资源集合中的章、节和子节URI</td></tr><tr><td>contents</td><td>使用此类型用于链接资源集合的目录URI</td></tr><tr><td>copyright</td><td>使用此类型用于链接资源的著作权声明URI</td></tr><tr><td>current</td><td>使用此类型用于链接资源集合中最近条目URI</td></tr><tr><td>describedby</td><td>使用此类型用于链接描述链接上下文的URI</td></tr><tr><td>edit</td><td>使用此类型链接客户端能编辑资源的URI</td></tr><tr><td>edit-media</td><td>使用此类型用于与媒体类型关联的Atom条目文档</td></tr><tr><td>enclosure</td><td>使用此类型链接可能很大的相关资源URI(例如视频预览片段里提供完全版本视频的链接)</td></tr><tr><td>first、last、next、next-archive、prev、previous、prev-archive和start</td><td>使用这些类型提供用于滚动浏览资源有序序列的链接</td></tr><tr><td>glossary</td><td>使用此类型链接术语表URI</td></tr><tr><td>help</td><td>使用此类型链接帮助文档URI</td></tr><tr><td>index</td><td>使用此类型链接索引URI</td></tr><tr><td>license</td><td>使用此类型链接许可权URI</td></tr><tr><td>payment</td><td>使用此类型链接购买或支付的URI</td></tr><tr><td>related</td><td>使用此类型链接有关资源</td></tr><tr><td>replies</td><td>使用此类型链接回复本链接的URI</td></tr><tr><td>service</td><td>使用此类型链接Atom种子的服务文档URI</td></tr><tr><td>stylesheet</td><td>使用此类型链接表单URI</td></tr><tr><td>up</td><td>客户端使用此类型来进入上一层资源的链接 URI</td></tr><tr><td>via</td><td>使用此类型标识消息源的资源URI</td></tr></tbody></table>
- 当链接的目的无法与标准类型匹配，使用下列惯例定义一个扩展链接关系类型。
  - 将链接关系类型表达成URI，例如http://www.example.org/rels/create-po。
  - 对该URI提供HTML文档方式的信息通告资源，描述链接关系类型语义和支持的HTTP方法、对请求和响应的支持表述格式及商业规则等细节。
  - 如果链接关系类型用于公共使用，向IANA注册链接类型。

超媒体链接的一个关键应用能够是客户端摆脱学习服务区用于管理应用流程的商业逻辑规则。服务器能提供包含应用状态的链接，因此使用超媒体作为应用状态的引擎。
对每个表述进行设计，使其仅包含客户端可能转移到的下一步的链接。
Web完整性是基于永久URI的，然而有时URI会是临时的。例如，一个URI可能仅对单个用户有效或在特定时间后到期终止。下面列举了几种依赖临时URI的场景：
- Web服务向客户端提供安全令牌。客户端使用该令牌能在短时间内访问某个资源。
- 保险报价Web服务生成报价，每个报价针对特定用户且仅在72小时内有效。报价到期终止后，客户端必须重新获取新报价。
- 当用户在网上注册，服务器通过邮件发送安全令牌给用户并期望用户用之验证邮箱地址。

为了支持短期存活的URI，需要在链接内交互短期URI。为这些链接分配扩展关系类型，并将URI有效期和到期终止后客户端所需操作文档化。当客户端对到期终止URI发送请求，返回适当的4xx错误并在消息体内指示客户端能够采取的操作。
当服务区无法为链接提供用于生成有效且完整URI信息时，服务器可以向客户端提供URI模板。URI模板是在符号外括上大括号的字符串。
为了让符号易于匹配和替换，符号仅限用于URI的下列部分：
- 路径段，例如http://example.org/segment1/{token1}/segment2
- 查询参数的值，例如http://example.org/path?param1={p1}¶m2={p2}
- 矩阵参数的值，例如http://example.org/path?param1={p1};param2={p2}

为了在表述中包含URI模板，使用下列方式：
- 对于XML表述，使用自己的应用程序XML命名空间内定义的link-template元素
- 对于JSON表述，使用link-template或link-templates特性。

Web浏览器是客服端使用链接进行浏览的最好例子。
为了支持服务器提供的URI和URI模板，基于已知链接关系类型从链接中抽取URI和URI模板。这些链接及其他资源数据构成了应用程序的当前状态。
如果应用程序长时间运行，将URI和关系类型同其他表述数据一同存储。
基于链接存在与否决定程序流程。
检查链接关系文档以学习任何关联的商业规则、鉴权、URI长期性、支持的方法和媒体类型等等。