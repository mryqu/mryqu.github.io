---
title: '小玩Java序列化'
date: 2013-07-08 21:17:41
categories: 
- Java
tags: 
- java
- 序列化
---
折腾GemFire，免不了要折腾序列化和发序列化。GemFire支持Java的序列化，同时也有自己的DataSerializable接口实现自己的序列化，此外还有Delta接口支持数据同步时仅传送上一次数据同步后的更新。
今天测试的实现先用Java的序列化，一开始玩java.io.Serializable接口，后来玩writeObject()和readObject()方法。顺便看看有writeObject方法后ObjectOutputStream调用堆栈与原有分支的不同。

```
private void writeSerialData(Object obj, ObjectStreamClass desc)
throws IOException {
  ObjectStreamClass.ClassDataSlot[] slots = desc.getClassDataLayout();
  for (int i = 0; i < slots.length; i++) {
    ObjectStreamClass slotDesc = slots[i].desc;
    if (slotDesc.hasWriteObjectMethod()) {
      PutFieldImpl oldPut = curPut;
      curPut = null;
      if (extendedDebugInfo) {
        debugInfoStack.push("custom writeObject data (class \""
            + slotDesc.getName() + "\")");
      }
      SerialCallbackContext oldContext = curContext;
      try {
        curContext = new SerialCallbackContext(obj, slotDesc);
        bout.setBlockDataMode(true);
        slotDesc.invokeWriteObject(obj, this);
        bout.setBlockDataMode(false);
        bout.writeByte(TC_ENDBLOCKDATA);
      } finally {
        curContext.setUsed();
        curContext = oldContext;
        if (extendedDebugInfo) {
          debugInfoStack.pop();
        }
      }
      curPut = oldPut;
    } else {
      defaultWriteFields(obj, slotDesc);
    }
  }
}
```

Java序列化会写入类描述符，在序列化后的字节数据占一定比例。GemFire支持Java序列化的同时有自己的序列化实现，GemFire自己的序列化实现更高效，而像Hadoop这样的项目则根本不使用Java的序列化，只支持自己的序列化实现。</font>
为了让父类不可序列化的子类序列化，需要父类有public或protected无参构造器，子类需要负责存储和恢复父类的public、protected和（如可访问的）package字段。当父类没有无参构造器，会在运行态序列化子类时返回错误。
下面是Java序列化规范和两个博客连接（这两篇写的都非常细致，后一个一篇都3到5万字，很值得学习）。
[Java Object Serialization Specification](http://docs.oracle.com/javase/6/docs/platform/serialization/spec/serialTOC.html)  
[理解Java对象序列化](http://www.blogjava.net/jiangshachina/archive/2012/02/13/369898.html)   
Java序列化[1](http://blog.csdn.net/silentbalanceyh/article/details/8183849)[2](http://blog.csdn.net/silentbalanceyh/article/details/8250096)[3](http://blog.csdn.net/silentbalanceyh/article/details/8294269)