---
title: '[C++] 优化twitcurl项目中的HMAC_SHA1'
date: 2017-07-31 05:46:44
categories: 
- C++
tags: 
- C++
- sha1
- hmacsha1
- twitcurl
---
[twitcurl](https://github.com/mryqu/twitcurl)开源项目中包含[SHA1.cpp](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/SHA1.cpp)和[HMAC_SHA1.cpp](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/HMAC_SHA1.cpp)用于计算Twitter认证所需的HMAC-SHA1签名。
HMAC是密钥相关的哈希运算消息认证码（Hash-based Message Authentication Code），HMAC运算利用哈希算法，以一个密钥和一个消息为输入，生成一个消息摘要作为输出。HMAC_SHA1需要一个密钥，而SHA1不需要。HMAC_SHA1的公式为：SHA1(Key XOR opad, SHA1(Key XOR ipad, text))
通过分析[oauthlib.cpp](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/oauthlib.cpp)和[HMAC_SHA1.cpp](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/HMAC_SHA1.cpp)可知：
1.  对于HMAC_SHA1算法，请求URL及参数信息作为文本输入，ConsumerSecret和AccessTokenSecret组合作为密钥输入；
2.  第一步：如果密钥输入大小超过64字节，则先做一次SHA1获取其摘要用于后继操作；否则直接使用密钥进行后继操作；
3.  第二步：密钥输入（/密钥输入摘要）XOR ipad（即0x36）；
4.  第三步：将上一步的[Key XOR ipad]和文本输入并入缓存AppendBuf1；
5.  第四步：使用上一步生成的缓存AppendBuf1一起进行SHA1以产生内部摘要；
6.  第五步：密钥输入（/密钥输入摘要）XOR opad（即0x5C）；
7.  第六步：将上一步的[Key XOR opad]和第四步产生的内部摘要并入缓存AppendBuf2；
8.  第七步：使用上一步生成的缓存AppendBuf2一起进行SHA1以产生外部摘要。

[HMAC_SHA1.h](https://github.com/mryqu/twitcurl/blob/master/libtwitcurl/HMAC_SHA1.h)中定义的AppendBuf1和AppendBuf2都有4K大小，合计8K。能不能省点空间呢？

下面我们可以看一个小示例：
```
char srcTest[] = "abcdef";
int  srcTestL = strlen(srcTest);
char srcTest1[] = "abc";
int  srcTestL1 = strlen(srcTest1);
char srcTest2[] = "def";
int  srcTestL2 = strlen(srcTest2);
unsigned char dst1[20] = "";
unsigned char dst2[20] = "";

CSHA1 sha1A = CSHA1();
sha1A.Reset();
sha1A.Update((UINT_8 *)srcTest, srcTestL);
sha1A.Final();
sha1A.GetHash((UINT_8 *)dst1);
for(int i=0;i<20;i++) {
    if(i<19) printf("%x ", dst1[i]);
    else printf("%x\n", dst1[i]);
}

CSHA1 sha1B = CSHA1();
sha1B.Reset();
sha1B.Update((UINT_8 *)srcTest1, srcTestL1);
sha1B.Update((UINT_8 *)srcTest2, srcTestL2);
sha1B.Final();
sha1B.GetHash((UINT_8 *)dst2);
for(int i=0;i<20;i++) {
    if(i<19) printf("%x ", dst1[i]);
    else printf("%x\n", dst1[i]);
}
```
sha1A实例是对srcTest1和srcTest2合并的内容进行SHA1，而sha1B实例是先后对srcTest1和srcTest2进行Update操作，最终二者生成的摘要是相同的。
```
1f 8a c1 f 23 c5 b5 bc 11 67 bd a8 4b 83 3e 5c 5 7a 77 d2
```
通过学习[RFC3174 US Secure Hash Algorithm 1 (SHA1)](https://tools.ietf.org/html/rfc3174)中的SHA1Input函数，可知对多个文本进行Update操作，效果等同于对合并后的大文本进行一次Update操作。
空间优化方案如下：
*   第一步中密钥输入大小超过64字节，则将输出写回CHMAC_SHA1::HMAC_SHA1的key所指缓存，更新key_len。这样就省掉了4K的SHA1_Key。后继操作使用key和key_len。
*   取消第三步和第六步，原第四步和第七步改用两个Update操作，这样省掉了4K的AppendBuf1和AppendBuf2。
*   64字节的m_ipad和m_opad的使用其实没有重叠在一起，合并成一个64字节的m_block足以。

### 参考
* * *
[RFC3174: US Secure Hash Algorithm 1 (SHA1)](https://tools.ietf.org/html/rfc3174)  
[RFC2104： HMAC: Keyed-Hashing for Message Authentication](https://tools.ietf.org/html/rfc2104)  