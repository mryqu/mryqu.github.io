---
title: '[算法] O(0)的exch函数'
date: 2014-01-10 06:40:31
categories: 
- Algorithm.DataStruct
tags: 
- 算法
- exch
- swap
- o(0)
---
常用的exch函数：
```
public static void exch(int[] nums, int i, int j) {
  int tmp = nums[i];
  nums[i] = nums[j];
  nums[j] = tmp;
}
```

不使用辅助空间的exch函数：
```
public static void exch(int[] nums, int i, int j) {
  nums[i] ^= nums[j];
  nums[j] ^= nums[i]; 
  nums[i] ^= nums[j]; 
}
```

控制流及nums[i]和nums[j]状态如下：

|nums[i]|nums[j]
|---
|= nums[i] ^ nums[j]|/
|/|= nums[j] ^ (nums[i] ^ nums[j])<br>= nums[i]
|= (nums[i] ^ nums[j]) ^ nums[i]<br>= nums[j]|/

