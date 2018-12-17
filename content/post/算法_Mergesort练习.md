---
title: '[算法] Mergesort练习'
date: 2014-02-20 23:39:55
categories: 
- Algorithm.DataStruct
tags: 
- algorithm
- mergesort
- exercise
---
本作业帖用于练习[http://algs4.cs.princeton.edu/22mergesort/](http://algs4.cs.princeton.edu/22mergesort/)里面的作业。

- **Merge with atmost log N compares per item.** Design a mergingalgorithm such that each item is compared at most a logarithmicnumber of times. (In the standard merging algorithm, an item can becompared N/2 times when merging two subarrays of size N/2.)
  [ reference](http://www.reddit.com/comments/9jqsi/how_to_merge_sorted_lists_with_olog_n_comparisons/)
  ![[算法] Mergesort练习](/images/2014/2/0026uWfMzy744H2x64bd3.jpg)
- **Lower boundfor sorting a Youngtableaux.** A _Youngtableaux_ is an N-by-N matrix such that theentries are sorted both column wise and row wise. Prove thatTheta(N^2 log N) compares are necessary to sort the N^2 entries(where you can access the data only through the pairwisecomparisons).
  _Solution sketch._ If entry (i, j) iswithin 1/2 of i + j, then all of the 2N-1 grid diagonals areindependent of one another. Sorting the diagonals takes N^2 log Ncompares.
- Given anarray a of size 2N with N items insorted order in positions 0 through N-1, and anarray b of size N with N items inascending order, merge the array b into a sothat a contains all of the items inascending order. Use O(1) extra memory.
  _Hint:_ merge from right to left.
  ![[算法] Mergesort练习](/images/2014/2/0026uWfMzy744KieasP13.png)
- **k-near-sorting.** Suppose you have anarray a[] of N distinct items whichis nearly sorted: each item at most k positions away from itsposition in the sorted order. Design an algorithm to sort the arrayin time proportional to N log k.
  _Hint_: First, sort the subarray from 0 to 2k; the smallestk items will be in their correct position. Next, sort the subarrayfrom k to 3k; the smallest 2k items will now be in their correctposition.
  ![[算法] Mergesort练习](/images/2014/2/0026uWfMzy745wTVVHa40.png)
- Find a family ofinputs for which mergesort makes strictly fewer than 1/2 N lg Ncompares to sort an array of N distinct keys.
  _Solution:_ a reverse-sorted array of N =2^k + 1 keys uses approximately 1/2 N lg N - (k/2 - 1)compares.
- Write aprogram [SecureShuffle.java](http://algs4.cs.princeton.edu/22mergesort/SecureShuffle.java.html) toread in a sequence of string from standard input and securelyshuffle them. Use the following algorithm: associate each card witha random real number between 0 and 1. Sort the values based ontheir associated real numbers. Use java.security.SecureRandom to generate therandom real numbers. Use Merge.indexSort() toget the random permutation.
- **Merging twoarrays of different lengths.** Given two sortedarrays a[] and b[] of sizes M and N where M ≥ N, devisean algorithm to merge them into a new sortedarray c[] using ~ N lg M compares.
  _Hint_: use binary search.
  _Note_: there is a [lower bound](http://www.cs.cmu.edu/afs/cs/academic/class/15210-f12/www/recis/rec10.pdf) of Omega(N log (1 + M/N)) compares. Thisfollows because there are M+N choose N possible merged outcomes. Adecision tree argument shows that this requires at least lg (M+Nchoose N) compares. We note that n choose r >= (n/r)^r.
  ![[算法] Mergesort练习](/images/2014/2/0026uWfMzy746ovVqKb3f.jpg)
  测试结果：
  ```
  1 2 3 4 5 7 
  merge=4 ,mergeBinary=4 ,2*lg4=4.0
  1 2 3 4 5 6 7 8 9 10 11 12 13 15 
  merge=12 ,mergeBinary=16 ,6*lg8=17.999999999999996
  1 2 3 4 5 6 7 8 9 
  merge=8 ,mergeBinary=4 ,1*lg8=3.0
  ```
  使用二分法查找的合并比较次数有可能反而更多，但是它能保证最差情况下比较次数~ N lgM。例如最后一个案例merge跟mergeBinary相比比较次数差距悬殊。
- **Merging threearrays.** Given three sortedarrays a[], b[], and c[], each of size N,design an algorithm to merge them into a new sortedarray d[] using at most ~ 6 Ncompares in the worst case (or, even better, ~ 5 N compares).
  ![[算法] Mergesort练习](/images/2014/2/0026uWfMzy746pUA1FQe6.jpg)
  测试结果：
  ```
  N=4:merge=21 ,mergeBy2Steps=18 ,binaryMergeBy2Steps=17
  N=4:merge=12 ,mergeBy2Steps=12 ,binaryMergeBy2Steps=7
  N=4:merge=12 ,mergeBy2Steps=8 ,binaryMergeBy2Steps=20
  N=8:merge=45 ,mergeBy2Steps=38 ,binaryMergeBy2Steps=44
  ```
  从测试结果来看，三种方式都能满足最欢情况下不超过6N， 其中mergeBy2Steps没有出现高出另两种方式的比较次数。
- **Merging threearrays.** Given three sortedarrays a[], b[], and c[], each of size N,prove that no compare-based algorithm can merge them into a newsorted array d[] using fewer than ~4.754887503 N compares in the worst case.
- **Arrays withN^(3/2) inversions.** Prove that anycompare-based algorithms that can sort arrays with N^(3/2) or fewerinversions must make ~ 1/2 N lg N compares in the worst case.
  _Proof sketch_: divide up the array into sqrt(N) consecutivesubarrays of sqrt(N) items each, such that the there are noinversion between items in different subarrays but the order ofitems within each subarray is arbitrary. Such an array has at mostN^(3/2) inversions—at most ~N/2 inversions in each of the sqrt(N)subarrays. By the sorting lower bound, it takes ~ sqrt(N) lgsqrt(N) compares to sort each subarray, for a total of ~ 1/2 N lgN.