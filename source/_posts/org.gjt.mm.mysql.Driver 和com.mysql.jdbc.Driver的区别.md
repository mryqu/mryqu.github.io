---
title: 'org.gjt.mm.mysql.Driver和com.mysql.jdbc.Driver的区别'
date: 2008-10-05 11:43:53
categories: 
- DB/NoSQL
tags: 
- mysql
- 驱动
---
org.gjt.mm.mysql.Driver是早期的驱动名称，后来就改名为**com.mysql.jdbc.Driver**，现在一般都推荐使用**com.mysql.jdbc.Driver**。在最新版本的mysqljdbc驱动中，为了保持对老版本的兼容，仍然保留了org.gjt.mm.mysql.Driver，但是实际上org.gjt.mm.mysql.Driver中调用了**com.mysql.jdbc.Driver**，因此现在这两个驱动没有什么区别。
```
//org.gjt.mm.mysql.Driver的源代码

package org.gjt.mm.mysql;
import java.sql.SQLException;
public class Driver extends com.mysql.jdbc.Driver {
  // ~Constructors//-----------------------------------------------------------
  public Driver() throws SQLException {super();}
}
```
由源代码可以看出，仅仅是为了兼容，才保留了该名字，所以建议直接使用com.mysql.jdbc.Driver