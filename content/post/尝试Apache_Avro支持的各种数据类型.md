---
title: '尝试Apache Avro支持的各种数据类型'
date: 2013-09-18 22:16:28
categories: 
- Hadoop+Spark
tags: 
- apache
- avro
- 序列化
- idl
---
Apache Avro是一个独立与编程语言的数据序列化系统，该项目由Doug Cutting（Hadoop之父）牵头创建的。它可以提供：
- 丰富的数据结构类型
- 快速可压缩的二进制数据形式
- 存储持久数据的文件容器
- 远程过程调用（RPC）
- 同动态语言的简单集成。读写数据文件和使用RPC协议都不需要生成代码，而代码生成作为一种可选的优化只值得在静态类型语言中实现。

今天尝试一下Apache Avro支持的各种数据类型。

#### test.avsc
```
{"namespace": "com.yqu.avro", 
 "type": "record", 
 "name": "Test", 
 "fields": [ 
   {"name": "stringVar", "type": "string"}, 
   {"name": "bytesVar", "type": ["bytes", "null"]}, 
   {"name": "booleanVar",  "type": "boolean"}, 
   {"name": "intVar",  "type": "int", "order":"descending"}, 
   {"name": "longVar",  "type": ["long", "null"], "order":"ascending"}, 
   {"name": "floatVar",  "type": "float"}, 
   {"name": "doubleVar",  "type": "double"}, 
   {"name": "enumVar",  "type": {"type": "enum", "name": "Suit", "symbols" : ["SPADES", "HEARTS", "DIAMONDS", "CLUBS"]}}, 
   {"name": "strArrayVar", "type": {"type": "array", "items": "string"}}, 
   {"name": "intArrayVar", "type": {"type": "array", "items": "int"}}, 
   {"name": "mapVar", "type": {"type": "map", "values": "long"}}, 
   {"name": "fixedVar", "type": {"type": "fixed", "size": 16, "name": "md5"}} 
 ] 
}
```

使用下列命令将schema编译成代码
```
java -jar avro-tools-1.7.5.jar compile schema test.avsc .
```

#### Test.java
```
package com.yqu.avro;  
@SuppressWarnings("all")
@org.apache.avro.specific.AvroGenerated
public class Test extends org.apache.avro.specific.SpecificRecordBase implements org.apache.avro.specific.SpecificRecord {
  public static final org.apache.avro.Schema SCHEMA$ = 
    new org.apache.avro.Schema.Parser().parse(
    "{"type":"record","name":"Test","namespace":"com.yqu.avro","fields":[{"name":"stringVar","type":"string"},{"name":"bytesVar","type":["bytes","null"]},{"name":"booleanVar","type":"boolean"},{"name":"intVar","type":"int","order":"descending"},{"name":"longVar","type":["long","null"]},{"name":"floatVar","type":"float"},{"name":"doubleVar","type":"double"},{"name":"enumVar","type":{"type":"enum","name":"Suit","symbols":["SPADES","HEARTS","DIAMONDS","CLUBS"]}},{"name":"strArrayVar","type":{"type":"array","items":"string"}},{"name":"intArrayVar","type":{"type":"array","items":"int"}},{"name":"mapVar","type":{"type":"map","values":"long"}},{"name":"fixedVar","type":{"type":"fixed","name":"md5","size":16}}]}");
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }
  @Deprecated public java.lang.CharSequence stringVar;
  @Deprecated public java.nio.ByteBuffer bytesVar;
  @Deprecated public boolean booleanVar;
  @Deprecated public int intVar;
  @Deprecated public java.lang.Long longVar;
  @Deprecated public float floatVar;
  @Deprecated public double doubleVar;
  @Deprecated public com.yqu.avro.Suit enumVar;
  @Deprecated public java.util.List<java.lang.charsequence> strArrayVar;
  @Deprecated public java.util.List<java.lang.integer> intArrayVar;
  @Deprecated public java.util.Map<java.lang.charsequence,java.lang.long> mapVar;
  @Deprecated public com.yqu.avro.md5 fixedVar;
  
  public Test() {}
  
  public Test(java.lang.CharSequence stringVar, java.nio.ByteBuffer bytesVar, 
    java.lang.Boolean booleanVar, java.lang.Integer intVar, java.lang.Long longVar, 
    java.lang.Float floatVar, java.lang.Double doubleVar, com.yqu.avro.Suit enumVar,
     java.util.List<java.lang.charsequence> strArrayVar, 
     java.util.List<java.lang.integer> intArrayVar, 
     java.util.Map<java.lang.charsequence,java.lang.long> mapVar, 
     com.yqu.avro.md5 fixedVar) {
    this.stringVar = stringVar;
    this.bytesVar = bytesVar;
    this.booleanVar = booleanVar;
    this.intVar = intVar;
    this.longVar = longVar;
    this.floatVar = floatVar;
    this.doubleVar = doubleVar;
    this.enumVar = enumVar;
    this.strArrayVar = strArrayVar;
    this.intArrayVar = intArrayVar;
    this.mapVar = mapVar;
    this.fixedVar = fixedVar;
  }

  public org.apache.avro.Schema getSchema() { return SCHEMA$; }
  // Used by DatumWriter.  Applications should not call. 
  public  {
    switch (field$) {
    case 0: return stringVar;
    case 1: return bytesVar;
    case 2: return booleanVar;
    case 3: return intVar;
    case 4: return longVar;
    case 5: return floatVar;
    case 6: return doubleVar;
    case 7: return enumVar;
    case 8: return strArrayVar;
    case 9: return intArrayVar;
    case 10: return mapVar;
    case 11: return fixedVar;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }
  // Used by DatumReader.  Applications should not call. 
  @SuppressWarnings(value="unchecked")
  public void put(int field$,  {
    switch (field$) {
    case 0: stringVar = (value$; break;
    case 1: bytesVar = (value$; break;
    case 2: booleanVar = (value$; break;
    case 3: intVar = (value$; break;
    case 4: longVar = (value$; break;
    case 5: floatVar = (value$; break;
    case 6: doubleVar = (value$; break;
    case 7: enumVar = (com.yqu.avro.Suit)value$; break;
    case 8: strArrayVar = (value$; break;
    case 9: intArrayVar = (value$; break;
    case 10: mapVar = (value$; break;
    case 11: fixedVar = (com.yqu.avro.md5)value$; break;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }

  public java.lang.CharSequence getStringVar() {
    return stringVar;
  }
  
  public void setStringVar(java.lang.CharSequence value) {
    this.stringVar = value;
  }

  public java.nio.ByteBuffer getByteVar() {
    return bytesVar;
  }

  public void setBytesVar(java.nio.ByteBuffer value) {
    this.bytesVar = value;
  }

  public boolean getBooleanVar) {
    return booleanVar;
  }

  public void setBooleanVar(boolean value) {
    this.booleanVar = value;
  }

  public int getIntVar() {
    return intVar;
  }

  public void setIntVar(int value) {
    this.intVar = value;
  }

  public long getLongVar() {
    return longVar;
  }

  public void setLongVar(long value) {
    this.longVar = value;
  }

  public float getFloatVar() {
    return floatVar;
  }

  public void setFloatVar(float value) {
    this.floatVar = value;
  }

  public double getDoubleVar() {
    return doubleVar;
  }

  public void setDoubleVar(double value) {
    this.doubleVar = value;
  }

  public com.yqu.avro.Suit getEnumVar() {
    return enumVar;
  }

  public void setEnumVar(com.yqu.avro.Suit value) {
    this.enumVar = value;
  }

  public java.util.List<java.lang.charsequence> getStrArrayVar() {
    return strArrayVar;
  }
  
  public void setStrArrayVar(java.util.List<java.lang.charsequence> value) {
    this.strArrayVar = value;
  }

  public public java.util.List<java.lang.integer> getIntArrayVar() {
    return intArrayVar;
  }

  public void setIntArrayVar(java.util.List<java.lang.integer> value) {
    this.intArrayVar = value;
  }
  
  public java.util.Map<java.lang.charsequence,java.lang.long> getMapVar() {
    return mapVar;
  }
  
  public void setMapVar(java.util.Map<java.lang.charsequence,java.lang.long> value) {
    this.mapVar = value;
  }
  
  public com.yqu.avro.md5 getFixedVar() {
    return fixedVar;
  }
  
  public void setFixedVar(com.yqu.avro.md5 value) {
    this.fixedVar = value;
  }
  
  public static com.yqu.avro.Test.Builder newBuilder() {
    return new com.yqu.avro.Test.Builder();
  }
  
  public static com.yqu.avro.Test.Builder newBuilder(com.yqu.avro.Test.Builder other) {
    return new com.yqu.avro.Test.Builder(other);
  }
  
  public static com.yqu.avro.Test.Builder newBuilder(com.yqu.avro.Test other) {
    return new com.yqu.avro.Test.Builder(other);
  }  
  
  public static class Builder extends org.apache.avro.specific.SpecificRecordBuilderBase<test>
    implements org.apache.avro.data.RecordBuilder<test> {

    private java.lang.CharSequence stringVar;
    private java.nio.ByteBuffer bytesVar;
    private boolean booleanVar;
    private int intVar;
    private java.lang.Long longVar;
    private float floatVar;
    private double doubleVar;
    private com.yqu.avro.Suit enumVar;
    private java.util.List<java.lang.charsequence> strArrayVar;
    private java.util.List<java.lang.integer> intArrayVar;
    private java.util.Map<java.lang.charsequence,java.lang.long> mapVar;
    private com.yqu.avro.md5 fixedVar;
    
    private Builder() {
      super(com.yqu.avro.Test.SCHEMA$);
    }
        
    private Builder(com.yqu.avro.Test.Builder other) {
      super(other);
      if (isValidValue(fields()[0], other.stringVar)) {
        this.stringVar = data().deepCopy(fields()[0].schema(), other.stringVar);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.bytesVar)) {
        this.bytesVar = data().deepCopy(fields()[1].schema(), other.bytesVar);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.booleanVar)) {
        this.booleanVar = data().deepCopy(fields()[2].schema(), other.booleanVar);
        fieldSetFlags()[2] = true;
      }
      if (isValidValue(fields()[3], other.intVar)) {
        this.intVar = data().deepCopy(fields()[3].schema(), other.intVar);
        fieldSetFlags()[3] = true;
      }
      if (isValidValue(fields()[4], other.longVar)) {
        this.longVar = data().deepCopy(fields()[4].schema(), other.longVar);
        fieldSetFlags()[4] = true;
      }
      if (isValidValue(fields()[5], other.floatVar)) {
        this.floatVar = data().deepCopy(fields()[5].schema(), other.floatVar);
        fieldSetFlags()[5] = true;
      }
      if (isValidValue(fields()[6], other.doubleVar)) {
        this.doubleVar = data().deepCopy(fields()[6].schema(), other.doubleVar);
        fieldSetFlags()[6] = true;
      }
      if (isValidValue(fields()[7], other.enumVar)) {
        this.enumVar = data().deepCopy(fields()[7].schema(), other.enumVar);
        fieldSetFlags()[7] = true;
      }
      if (isValidValue(fields()[8], other.strArrayVar)) {
        this.strArrayVar = data().deepCopy(fields()[8].schema(), other.strArrayVar);
        fieldSetFlags()[8] = true;
      }
      if (isValidValue(fields()[9], other.intArrayVar)) {
        this.intArrayVar = data().deepCopy(fields()[9].schema(), other.intArrayVar);
        fieldSetFlags()[9] = true;
      }
      if (isValidValue(fields()[10], other.mapVar)) {
        this.mapVar = data().deepCopy(fields()[10].schema(), other.mapVar);
        fieldSetFlags()[10] = true;
      }
      if (isValidValue(fields()[11], other.fixedVar)) {
        this.fixedVar = data().deepCopy(fields()[11].schema(), other.fixedVar);
        fieldSetFlags()[11] = true;
      }
    }
        
    private Builder(com.yqu.avro.Test other) {
            super(com.yqu.avro.Test.SCHEMA$);
      if (isValidValue(fields()[0], other.stringVar)) {
        this.stringVar = data().deepCopy(fields()[0].schema(), other.stringVar);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.bytesVar)) {
        this.bytesVar = data().deepCopy(fields()[1].schema(), other.bytesVar);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.booleanVar)) {
        this.booleanVar = data().deepCopy(fields()[2].schema(), other.booleanVar);
        fieldSetFlags()[2] = true;
      }
      if (isValidValue(fields()[3], other.intVar)) {
        this.intVar = data().deepCopy(fields()[3].schema(), other.intVar);
        fieldSetFlags()[3] = true;
      }
      if (isValidValue(fields()[4], other.longVar)) {
        this.longVar = data().deepCopy(fields()[4].schema(), other.longVar);
        fieldSetFlags()[4] = true;
      }
      if (isValidValue(fields()[5], other.floatVar)) {
        this.floatVar = data().deepCopy(fields()[5].schema(), other.floatVar);
        fieldSetFlags()[5] = true;
      }
      if (isValidValue(fields()[6], other.doubleVar)) {
        this.doubleVar = data().deepCopy(fields()[6].schema(), other.doubleVar);
        fieldSetFlags()[6] = true;
      }
      if (isValidValue(fields()[7], other.enumVar)) {
        this.enumVar = data().deepCopy(fields()[7].schema(), other.enumVar);
        fieldSetFlags()[7] = true;
      }
      if (isValidValue(fields()[8], other.strArrayVar)) {
        this.strArrayVar = data().deepCopy(fields()[8].schema(), other.strArrayVar);
        fieldSetFlags()[8] = true;
      }
      if (isValidValue(fields()[9], other.intArrayVar)) {
        this.intArrayVar = data().deepCopy(fields()[9].schema(), other.intArrayVar);
        fieldSetFlags()[9] = true;
      }
      if (isValidValue(fields()[10], other.mapVar)) {
        this.mapVar = data().deepCopy(fields()[10].schema(), other.mapVar);
        fieldSetFlags()[10] = true;
      }
      if (isValidValue(fields()[11], other.fixedVar)) {
        this.fixedVar = data().deepCopy(fields()[11].schema(), other.fixedVar);
        fieldSetFlags()[11] = true;
      }
    }
    
    public java.lang.CharSequence getStringVar {
      return stringVar;
    }
   
    public com.yqu.avro.Test.Builder setStringVar(java.lang.CharSequence value) {
      validate(fields()[0], value);
      this.stringVar = value;
      fieldSetFlags()[0] = true;
      return this; 
    }

    public boolean hasStringVar() {
      return fieldSetFlags()[0];
    }
        
    public com.yqu.avro.Test.Builder clearStringVar() {
      stringVar = null;
      fieldSetFlags()[0] = false;
      return this;
    }

    public java.nio.ByteBuffer getByteVar() {
      return bytesVar;
    }
    
    public com.yqu.avro.Test.Builder setBytesVar(java.nio.ByteBuffer value) {
      validate(fields()[1], value);
      this.bytesVar = value;
      fieldSetFlags()[1] = true;
      return this; 
    }
    
    public boolean hasBytesVar() {
      return fieldSetFlags()[1];
    }
    
    public com.yqu.avro.Test.Builder clearBytesVar() {
      bytesVar = null;
      fieldSetFlags()[1] = false;
      return this;
    }

    public boolean getBooleanVar() {
      return booleanVar;
    }
    
    public com.yqu.avro.Test.Builder setBooleanVar(boolean value) {
      validate(fields()[2], value);
      this.booleanVar = value;
      fieldSetFlags()[2] = true;
      return this; 
    }
    
    public boolean hasBooleanVar() {
      return fieldSetFlags()[2];
    }

    public com.yqu.avro.Test.Builder clearBooleanVar() {
      fieldSetFlags()[2] = false;
      return this;
    }

    public int getIntVar() {
      return intVar;
    }
    
    public com.yqu.avro.Test.Builder setIntVar(int value) {
      validate(fields()[3], value);
      this.intVar = value;
      fieldSetFlags()[3] = true;
      return this; 
    }
    
    public boolean hasIntVar() {
      return fieldSetFlags()[3];
    }

    public com.yqu.avro.Test.Builder clearIntVar() {
      fieldSetFlags()[3] = false;
      return this;
    }

    public long getLongVar() {
      return longVar;
    }
    
    public com.yqu.avro.Test.Builder setLongVar(long value) {
      validate(fields()[4], value);
      this.longVar = value;
      fieldSetFlags()[4] = true;
      return this; 
    }

    public boolean hasLongVar() {
      return fieldSetFlags()[4];
    }

    public com.yqu.avro.Test.Builder clearLongVar() {
      longVar = null;
      fieldSetFlags()[4] = false;
      return this;
    }

    public float getFloatVar() {
      return floatVar;
    }
    
    public com.yqu.avro.Test.Builder setFloatVar(float value) {
      validate(fields()[5], value);
      this.floatVar = value;
      fieldSetFlags()[5] = true;
      return this; 
    }

    public boolean hasFloatVar() {
      return fieldSetFlags()[5];
    }

    public com.yqu.avro.Test.Builder clearFloatVar() {
      fieldSetFlags()[5] = false;
      return this;
    }

    public double getDoubleVar() {
      return doubleVar;
    }

    public com.yqu.avro.Test.Builder setDoubleVar(double value) {
      validate(fields()[6], value);
      this.doubleVar = value;
      fieldSetFlags()[6] = true;
      return this; 
    }

    public boolean hasDoubleVar() {
      return fieldSetFlags()[6];
    }

    public com.yqu.avro.Test.Builder clearDoubleVar() {
      fieldSetFlags()[6] = false;
      return this;
    }

    public com.yqu.avro.Suit getEnumVar() {
      return enumVar;
    }

    public com.yqu.avro.Test.Builder setEnumVar(com.yqu.avro.Suit value) {
      validate(fields()[7], value);
      this.enumVar = value;
      fieldSetFlags()[7] = true;
      return this; 
    }

    public boolean hasEnumVar() {
      return fieldSetFlags()[7];
    }

    public com.yqu.avro.Test.Builder clearEnumVar() {
      enumVar = null;
      fieldSetFlags()[7] = false;
      return this;
    }

    public java.util.List<java.lang.charsequence> getStrArrayVar() {
      return strArrayVar;
    }

    public com.yqu.avro.Test.Builder setStrArrayVar(java.util.List<java.lang.charsequence> value) {
      validate(fields()[8], value);
      this.strArrayVar = value;
      fieldSetFlags()[8] = true;
      return this; 
    }

    public boolean hasStrArrayVar() {
      return fieldSetFlags()[8];
    }

    public com.yqu.avro.Test.Builder clearStrArrayVar() {
      strArrayVar = null;
      fieldSetFlags()[8] = false;
      return this;
    }

    public java.util.List<java.lang.integer> getIntArrayVar() {
      return intArrayVar;
    }
    
    public com.yqu.avro.Test.Builder setIntArrayVar(java.util.List<java.lang.integer> value) {
      validate(fields()[9], value);
      this.intArrayVar = value;
      fieldSetFlags()[9] = true;
      return this; 
    }

    public boolean hasIntArrayVar() {
      return fieldSetFlags()[9];
    }

    public com.yqu.avro.Test.Builder clearIntArrayVar() {
      intArrayVar = null;
      fieldSetFlags()[9] = false;
      return this;
    }

    public java.util.Map<java.lang.charsequence,java.lang.long> getMapVar() {
      return mapVar;
    }

    public com.yqu.avro.Test.Builder setMapVar(java.util.Map<java.lang.charsequence,java.lang.long> value) {
      validate(fields()[10], value);
      this.mapVar = value;
      fieldSetFlags()[10] = true;
      return this; 
    }

    public boolean hasMapVar() {
      return fieldSetFlags()[10];
    }

    public com.yqu.avro.Test.Builder clearMapVar() {
      mapVar = null;
      fieldSetFlags()[10] = false;
      return this;
    }

    public com.yqu.avro.md5 getFixedVar() {
      return fixedVar;
    }
    
    public com.yqu.avro.Test.Builder setFixedVar(com.yqu.avro.md5 value) {
      validate(fields()[11], value);
      this.fixedVar = value;
      fieldSetFlags()[11] = true;
      return this; 
    }

    public boolean hasFixedVar() {
      return fieldSetFlags()[11];
    }

    public com.yqu.avro.Test.Builder clearFixedVar() {
      fixedVar = null;
      fieldSetFlags()[11] = false;
      return this;
    }

    @Override
    public Test build() {
      try {
        Test record = new Test();
        record.stringVar = fieldSetFlags()[0] ? this.stringVar : (;
        record.bytesVar = fieldSetFlags()[1] ? this.bytesVar : (;
        record.booleanVar = fieldSetFlags()[2] ? this.booleanVar : (;
        record.intVar = fieldSetFlags()[3] ? this.intVar : (;
        record.longVar = fieldSetFlags()[4] ? this.longVar : (;
        record.floatVar = fieldSetFlags()[5] ? this.floatVar : (;
        record.doubleVar = fieldSetFlags()[6] ? this.doubleVar : (;
        record.enumVar = fieldSetFlags()[7] ? this.enumVar : (com.yqu.avro.Suit) defaultValue(fields()[7]);
        record.strArrayVar = fieldSetFlags()[8] ? this.strArrayVar : (;
        record.intArrayVar = fieldSetFlags()[9] ? this.intArrayVar : (;
        record.mapVar = fieldSetFlags()[10] ? this.mapVar : (;
        record.fixedVar = fieldSetFlags()[11] ? this.fixedVar : (com.yqu.avro.md5) defaultValue(fields()[11]);
        return record;
      } catch (Exception e) {
        throw new org.apache.avro.AvroRuntimeException(e);
      }
    }
  }
}
```

#### Suit.java

```
package com.yqu.avro;   
@SuppressWarnings("all") 
@org.apache.avro.specific.AvroGenerated 
public enum Suit {  
  SPADES, HEARTS, DIAMONDS, CLUBS  ; 
  public static final org.apache.avro.Schema SCHEMA$ = 
    new org.apache.avro.Schema.Parser().parse(
      "{"type":"enum","name":"Suit","namespace":"com.yqu.avro","symbols":["SPADES","HEARTS","DIAMONDS","CLUBS"]}"); 
  public static org.apache.avro.Schema getClassSchema() {
   return SCHEMA$; 
  } 
}
```

#### Md5.java

```
package com.yqu.avro;   
@SuppressWarnings("all") 
@org.apache.avro.specific.FixedSize(16) 
@org.apache.avro.specific.AvroGenerated 
public class Md5 extends org.apache.avro.specific.SpecificFixed { 
  public static final org.apache.avro.Schema SCHEMA$ = 
    new org.apache.avro.Schema.Parser().parse(
      "{"type":"fixed","name":"Md5","namespace":"com.yqu.avro","size":16}"); 
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }   

  public Md5() { 
    super(); 
  } 
   
  public Md5(byte[] bytes) { 
    super(bytes); 
  } 
}
```

参考：

[Apache Avro规范](http://avro.apache.org/docs/current/spec.html)  
[Apache Avro 与 Thrift 比较](http://www.tbdata.org/archives/1307)  
[Avro总结(RPC/序列化)](http://langyu.iteye.com/blog/708568)  