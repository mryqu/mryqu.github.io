---
title: '[HBase] HBase Shell中的put操作解析'
date: 2014-01-03 23:20:51
categories: 
- Hadoop/Spark
- HBase
tags: 
- hbase
- shell
- ruby
- put
- datatype
---
阅读了[HBase Shell datatype conversion](http://stackoverflow.com/questions/8652390/hbase-shell-datatype-conversion)一贴，感觉下列两个操作结果中的单元格数据值都像是文本类型的：
```
put 'mytable', '2342', 'cf:c1', '67'
put 'mytable', '2341', 'cf:c1', 23

```

预知真相，看来只好看HBase Shell代码了。HBase Shell是Ruby代码，首先找到这些代码的位置：
```
cd $HBASE_HOME
find . -name '*.rb' -print

```

找到了$HBASE_HOME/lib/ruby/shell/commands/put.rb，其GitHub代码库位置为[https://github.com/apache/hbase/commits/master/hbase-shell/src/main/ruby/shell/commands/put.rb](https://github.com/apache/hbase/commits/master/hbase-shell/src/main/ruby/shell/commands/put.rb)：
```
def command(table, row, column, value, timestamp=nil, args = {})
  put table(table), row, column, value, timestamp, args
end

def put(table, row, column, value, timestamp = nil, args = {})
  format_simple_command do
    table._put_internal(row, column, value, timestamp, args)
  end
end
```

继而找到了$HBASE_HOME/lib/ruby/hbase/table.rb，其GitHub代码库位置为[https://github.com/apache/hbase/blob/master/hbase-shell/src/main/ruby/hbase/table.rb](https://github.com/apache/hbase/blob/master/hbase-shell/src/main/ruby/hbase/table.rb)：
```
def _put_internal(row, column, value, timestamp = nil, args = {})
  p = org.apache.hadoop.hbase.client.Put.new(row.to_s.to_
  family, qualifier = parse_column_name(column)
  if args.any?
     attributes = args[ATTRIBUTES]
     set_attributes(p, attributes) if attributes
     visibility = args[VISIBILITY]
     set_cell_visibility(p, visibility) if visibility
  end
  #Case where attributes are specified without timestamp
  if timestamp.kind_of?(Hash)
        timestamp.each do |k, v|
          if v.kind_of?(Hash)
                set_attributes(p, v) if v
          end
          if v.kind_of?(String)
                set_cell_visibility(p, v) if v
          end
          
    end
    timestamp = nil
  end  
  if timestamp
    p.add(family, qualifier, timestamp, value.to_s.to_j-a-v-a_bytes)
  else
    p.add(family, qualifier, value.to_s.to_j-a-v-a_bytes)
  end
  @table.put(p)
end
```

看到value.to_s后可知数值型value经过to_s函数后也变成文本型了。下面做一下测试：
![[HBase] HBase Shell中的put操作解析](/images/2014/1/0026uWfMzy7923QrFS3c3.png)
"123".to_s和123.to_s结果是相同的。而Bytes.toBytes方法经过to_s函数后变成对象引用的文本表现，对底层存储来说跟输入数据没有任何关联。
