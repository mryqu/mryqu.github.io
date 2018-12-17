---
title: '[HBase] 原始数据类型存储'
date: 2014-01-02 22:37:53
categories: 
- Hadoop/Spark
- HBase
tags: 
- hbase
- primitive
- datatype
- bytes
- storage
---
对原始数据类型如何在HBase中存储，如何在HBaseShell中如何显示尚不了解，做一下小实验满足一下好奇心。使用下列代码存放和读取原始数据类型：
```
byte[] cf = Bytes.toBytes(CF_DEFAULT);

Put put = new Put(Bytes.toBytes("test"));
byte[] val = Bytes.toBytes("123");
System.out.println("Bytes for str: "+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("str"), val);

short shortVal = 123;
val = Bytes.toBytes(shortVal);
System.out.println("Bytes for short:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("short"), val);

int intVal = 123;
val = Bytes.toBytes(intVal);
System.out.println("Bytes for int:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("int"), val);

long longVal = 123L;
val = Bytes.toBytes(longVal);
System.out.println("Bytes for long:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("long"), val);

float floatVal = 123;
val = Bytes.toBytes(floatVal);
System.out.println("Bytes for float:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("float"), val);

double doubleVal = 123;
val = Bytes.toBytes(doubleVal);
System.out.println("Bytes for double:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("double"), val);

boolean boolVal = true;
val = Bytes.toBytes(boolVal);
System.out.println("Bytes for bool:"+ bytesToHex(val)+",len="+val.length);
put.addColumn(cf, Bytes.toBytes("bool"), val);

table.put(put);

Get get = new Get(Bytes.toBytes("test"));
get.addFamily(Bytes.toBytes(cf));
Result res = table.get(get);
System.out.println(res);
```

日志如下：
```
Bytes for str: \x31\x32\x33,len=3
Bytes for short:\x00\x7B,len=2
Bytes for int:\x00\x00\x00\x7B,len=4
Bytes for long:\x00\x00\x00\x00\x00\x00\x00\x7B,len=8
Bytes for float:\x42\xF6\x00\x00,len=4
Bytes for double:\x40\x5E\xC0\x00\x00\x00\x00\x00,len=8
Bytes for bool:\xFF,len=1

keyvalues={test/JavaGenValues:bool/1388673053337/Put/vlen=1/seqid=0,
test/JavaGenValues:double/1388673053337/Put/vlen=8/seqid=0, 
test/JavaGenValues:float/1388673053337/Put/vlen=4/seqid=0, 
test/JavaGenValues:int/1388673053337/Put/vlen=4/seqid=0, 
test/JavaGenValues:long/1388673053337/Put/vlen=8/seqid=0, 
test/JavaGenValues:short/1388673053337/Put/vlen=4/seqid=0, 
test/JavaGenValues:str/1388673053337/Put/vlen=3/seqid=0}
```

HBase Shell扫描表返回如下结果：
![[HBase] 原始数据类型存储](/images/2014/1/0026uWfMzy7911u8vAe82.jpg)

总结：
- 对于byte、short、int、long、float和double数据类型，其Bytes存储的vlen固定为1、2、4、8、4、和8
- 对于字符串，其Bytes存储其UTF8编码的字节码
- 对于布尔类型，值true存储为\xFF，值false存储为\x00
- HBaseShell显示Bytes存储时，可打印字节显示字符，否则显示十六进制内容。具体实现可参见org.apache.hadoop.hbase.util.Bytes#toStringBinary(byte[],int, int)方法。

### 参考

[Apache HBase APIs Example](http://hbase.apache.org/book.html#_examples)    