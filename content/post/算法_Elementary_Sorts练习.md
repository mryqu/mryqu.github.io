---
title: '[算法] Elementary Sorts练习'
date: 2014-02-17 22:27:59
categories: 
- Algorithm.DataStruct
tags: 
- algorithm
- sort
- selection
- insertion
---
本作业帖用于练习[http://algs4.cs.princeton.edu/21elementary/](http://algs4.cs.princeton.edu/21elementary/)里面的作业。

- **Stoogesort.** Analyze the running time andcorrectness of the following recursive sorting algorithm: if theleftmost item is larger than the rightmost item, swap them. Ifthere are 2 or more items in the current subarray, (i) sort theinitial two-thirds of the array recursively, (ii) sort the finaltwo-thirds of the array, (iii) sort the initial two-thirds of thearray again.![[算法] Elementary Sorts练习](/images/2014/2/0026uWfMzy73W0vfCzl9f.png)
[StoogeSort](https://en.wikipedia.org/wiki/Stooge_sort)时间复杂度为O(_n_log3 / log 1.5 )= O(_n_2.7095...)，比合并排序慢，甚至比冒泡排序慢，仅用于低效简单排序示范。

- **Guess-sort.** Pick two indices i and j atrandom; if a[i] > a[j], then swap them. Repeat until the inputis sorted. Analyze the expected running time of thisalgorithm. _Hint_: after each swap, thenumber of inversions strictly decreases. If there are m bad pairs,then the expected time to find a bad pair is Theta(n^2/m). Summingup from m =1 to n^2 yields O(N^2 log N) overall, ala couponcollector. This bound is tight: consider input 1 0 3 2 5 4 7 6...![[算法] Elementary Sorts练习](/images/2014/2/0026uWfMzy73W0zYRKg58.png)
- **Bogosort.** Bogosort is a randomizedalgorithm that works by throwing the N cards up in the air,collecting them, and checking whether they wound up in increasingorder. If they didn't, repeat until they do. Implement bogosortusing the shuffling algorithm from Section 1.4. Estimate therunning time as a function of N.![[算法] Elementary Sorts练习](/images/2014/2/0026uWfMzy73W0Efz7V7f.png)
- **Slowsort.** Consider the following sortingalgorithm: choose two integer i and j at random. If i < j, buta[i] > a[j], swap them. Repeat until the array is in ascendingorder. Argue that the algorithm will eventually finish (withprobability 1). How long will it takes as a function ofN? _Hint_: How many swaps will it make inthe worst case?
- **Minimum numberof moves to sort an array.** Given a list of Nkeys, a _moveoperation_ consists of removing any one keyfrom the list and appending it to the end of the list. No otheroperations are permitted. Design an algorithm that sorts a givenlist using the minimum number of moves.
- **Guess-Sort.** Consider the followingexchanged-based sorting algorithm: pick two random indices; if a[i]and a[j] are an inversion, swap them; repeat. Show that theexpected time to sort an array of size N is at most N^2 log N.See [this paper](http://www.sciencedirect.com/science/article/pii/S0166218X04001131?np=y)for an analysis and related sorting algorithm known asFun-Sort.
- **Swapping aninversion.** Given an array of N keys, let a[i]and a[j] be an inversion (i < j but a[i] > a[j]). Prove ordisprove: swapping a[i] and a[j] strictly decreases the number ofinversions.
- **Binaryinsertion sort.** Develop animplementation [BinaryInsertion.java](http://algs4.cs.princeton.edu/21elementary/BinaryInsertion.java.html) ofinsertion sort that uses binary search to find the insertion pointj for entry a[i] and then shifts all of the entries a[j] to a[i-1]over one position to the right. The number of compares to sort anarray of length N should be ~ N lg N in the worst case. Note thatthe number of array accesses will still be quadratic in the worstcase. Use [SortCompare.java](http://algs4.cs.princeton.edu/21elementary/SortCompare.java.html) toevaluate the effectiveness of doing so.![[算法] Elementary Sorts练习](/images/2014/2/0026uWfMzy73W0IZNHo1e.png)
BinaryInsertionSort与二分法查找有一处不同在于：搜索中hi=mid，而二分法查找则hi=mid-1。

a[mid]大于v时：如果另hi=mid-1，则此时的a[hi]有可能小于v，而lo肯定小于hi，则插入会出现错误。
