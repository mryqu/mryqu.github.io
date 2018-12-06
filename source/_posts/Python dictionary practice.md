---
title: 'Python dictionary practice'
date: 2013-07-25 19:55:43
categories: 
- Python
tags: 
- python
- dict
- 键值互换
- top
---
# reverse Dict (Swap Key and Value)
```
>>> a={"a":123,"b":222,"c":30,"d":6,"e":1}
>>> print a
{'a': 123, 'c': 30, 'b': 222, 'e': 1, 'd': 6}
>>> res = dict((v,k) for k,v in a.iteritems())
>>> print res
{1: 'e', 6: 'd', 123: 'a', 222: 'b', 30: 'c'}
```

```
>>> a={"a":123,"b":222,"c":30,"d":6,"e":1}
>>> print a
{'a': 123, 'c': 30, 'b': 222, 'e': 1, 'd': 6}
>>> res = dict(zip(a.values(), a.keys()))
>>> print res
{1: 'e', 6: 'd', 123: 'a', 222: 'b', 30: 'c'}
```


# Top N by Dict Value

```
>>> from collections import Counter
>>> a={"a":123,"b":222,"c":30,"d":6,"e":1}
>>> top_three = Counter(a).most_common(3)
>>> for key, value in top_three: print key, float(value)
...
b 222.0
a 123.0
c 30.0
```

```
>>> a={"a":123,"b":222,"c":30,"d":6,"e":1}
>>> res = sorted(a.items(), key=lambda x:x[1], reverse=True)
>>> res
[('b', 222), ('a', 123), ('c', 30), ('d', 6), ('e', 1)]
>>> for idx in range(3): print res[idx][0], float(res[idx][1])
...
b 222.0
a 123.0
c 30.0
```


# Top N by Dict Key

```
>>> a = {1: 'e', 6: 'd', 123: 'a', 222: 'b', 30: 'c'}
>>> res = sorted(a.items(), reverse=True)
>>> print res
[(222, 'b'), (123, 'a'), (30, 'c'), (6, 'd'), (1, 'e')]
>>> for idx in range(3): print res[idx][1], float(res[idx][0])
...
b 222.0
a 123.0
c 30.0
```