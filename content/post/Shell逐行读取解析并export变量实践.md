---
title: 'Shell逐行读取、解析并export变量实践'
date: 2020-12-15 12:31:23
categories: 
- Tools
- Linux
tags: 
- shell
- 逐行读取
- export变量
- 变量的二次引用

---

setenv.yaml示例  
```
MY_HOME: /local/install/myhome
MY_JAVA_HOME: $MY_HOME/jre/bin
```


test.ksh示例  
```
#!/bin/ksh

getCustEnv() {
  # 除了while read 也可以使用for var，但是需要更改IFS为换行符
  cat setenv.yaml | while read line; do
    line=$(echo $line | grep -v "^\s*#" | grep ":")
    if [ ! -z $line ]; then
      key=$(echo $line | cut -d: -f1 | sed -e 's/^\s*//' -e 's/\s*$//')
      val=$(echo $line | cut -d: -f2 | sed -e 's/^\s*//' -e 's/\s*$//')

      echo "line=$line"
      echo "key=$key"
      echo "val=$val"
      if [ ! -z $key ]; then
        echo "export $key=$val"
        # 不可以直接执行export，否则变量值还是字符串，例如MY_JAVA_HOME变量值仍为$MY_HOME/jre/bin，而不是/local/install/myhome/jre/bin
        eval export $key=$val
        # 变量的二次引用 这里${!key}不好使 		
        eval newVal=\${$key}
        echo "$key=$newVal"
      fi
      echo ""
    fi
  done
}

getCustEnv
```
