---
title: 'sed正则表达式捕获组实践'
date: 2020-12-04 07:31:23
categories: 
- Tool
- Linux
tags: 
- sed
- regex
- capture group

---


```
mryqu> cat test.txt
Hello from="Beijing" via="Nanjing"  to="Shanghai".
test
123

mryqu> sed -e 's/^Hello.*from="[^"]\+".*$/abc/g' test.txt
abc
test
123

mryqu> sed -e 's/^Hello.*from="\([^"]\+\)".*$/\1/g' test.txt
Beijing
test
123

mryqu> sed -e 's/^\(Hello.*from="\)\([^"]\+\)\(".*\)$/\1********\3/g' test.txt
Hello from="********" via="Nanjing"  to="Shanghai".
test
123

mryqu> sed -e 's/^\(Hello.*from="\)\([^"]\+\)\(".*\)$/\1********\3/g' -e 's/^\(Hello.*to="\)\([^"]\+\)\(".*\)$/\1********\3/g' test.txt
Hello from="********" via="Nanjing"  to="********".
test
123

mryqu>
```

注：sed不支持非贪婪模式。  

### 参考

* [Sed教程-正则表达式](https://www.yiibai.com/sed/sed_regular_expressions.html)  
* [grep、sed、awk、perl等对正则表达式的支持的差别](https://blog.csdn.net/u011729865/article/details/78946707)  
* [How to output only captured groups with sed?](https://stackoverflow.com/questions/2777579/how-to-output-only-captured-groups-with-sed)   