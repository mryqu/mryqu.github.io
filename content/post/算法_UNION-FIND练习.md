---
title: '[算法] UNION-FIND练习'
date: 2014-02-15 21:36:28
categories: 
- Algorithm.DataStruct
tags: 
- algorithm
- union-find
- quick-find
- quick-union
---
本作业帖用于练习[http://algs4.cs.princeton.edu/15uf/](http://algs4.cs.princeton.edu/15uf/)里面的作业。

![[算法] UNION-FIND练习](/images/2014/2/0026uWfMzy73RyEdfyb1b.png)

- True or false. Inthe quick union implementation, suppose weset id[p] to id[root(q)] insteadof setting id[root(p)] Would the resultingalgorithm be correct?
_答案：_ 否。使用id[root(p)]可以将p所在连接全部合并到q所在连接，而使用id[p]仅会将p及其子连接合并到q所在连接。

- Which of thefollowing arrays could not possibly occur during the execution ofweighted quick union with path compression:
  - 0 1 2 3 4 5 67 8 9
  - 7 3 8 3 4 5 68 8 1
  - 6 3 8 0 4 5 69 8 1
  - 0 0 0 0 0 0 00 0 0
  - 9 6 2 6 1 4 58 8 9
  - 9 8 7 6 5 4 32 1 0
_答案：_ B,、C、E和F。

  - B中连接{9 1 3}不可能存在。节点1的节点数为2，明显比连接前的节点3多。
  - C中连接{9 1 3 0 6}不可能存在。这个没有做weight才可能出现。
  - E中{1 3 6 5 4}不可能存在。节点6的节点数为3，明显比连接前的节点4和5都多。
  - F中连接{0 9}、{1 8}、{2 7}、{3 6}、{4 5}不可能存在。父子无法互指。
- **Recursive pathcompression.** Implement path compression usingrecursion.
_答案：_
```
public int find(int p) {
   if (p != id[p])
       id[p] = find(id[p]);
   return id[p];
```

- **Pathhalving.** [WeightedQuickUnionPathHalvingUF.java](http://algs4.cs.princeton.edu/15uf/WeightedQuickUnionPathHalvingUF.java.html) implementsa simpler strategy known as _path halving_,that makes every other node on the find path link to itsgrandparent. _Remark_: the amortized costper operation for this algorithm is known to be bounded by afunction known as the _inverse Ackermannfunction_.
_答案：_
```
public int find(int p) {
    while (p != parent[p]) {
        parent[p] = parent[parent[p]];
        p = parent[p];
    }
    return p;
}
```

- **Pathsplitting.** Implement an alternate strategyknown as _path splitting_, that makes everynode on the find path link to itsgrandparent. _Remark_: the amortized costper operation for this algorithm is known to be bounded by afunction known as the _inverse Ackermannfunction_.
_答案：_
```
public int find(int p) {
    while (p != parent[p]) {
        int newp = parent[p];
        parent[p] = parent[newp];
        p = newp;
    }
    return p;
}
```

- **Random quickunion.** Implement the following version ofquick union: Assign the integers 0 through N-1 uniformly at randomto the N elements. When linking two roots, always link the rootwith the smaller label into the root with the larger label. Add inpath compression. _Remark_: the expectedcost per operation for the version without path compression islogarithmic; the expected amortized cost per operation for theversion with path compression is bounded by a function known asthe _inverse Ackermann function_.
_答案：_将WeightedQuickUnionPathCompressionUF类中的sz替换成label，在构造时做一次shuffle即可。

- **3D sitepercolation.** Repeat for 3D lattice. Thresholdaround 0.3117.
- **Bondpercolation.** Same as site percolation, butchoose edges at random instead of sites. True threshold is exactly0.5.
- Given a set of Nelements, create a sequence of N union operations so that weightedquick union has height Theta(log N). Repeat for weighted quickunion with path compression.
- **Hex.** The game of Hex is played on atrapezoidal grid of hexagons.... Describe how to detect when whiteor black has won the game. Use the union-find data structure.
- **Hex.** Prove that the game cannot end in atie. _Hint_: consider the set of cellsreachable from the left side of the board.
- **Hex.** Prove that the first player canguarantee a win with perfect play. _Hint_:if the second player had a winning strategy, you could choose arandom cell initially, and then just copy the second player'swinning strategy. This is called _strategystealing_.
- **Labelingclusters on a grid.** Physicists refer to it asthe [Hoshen-Kopelman algorithm](http://splorg.org:8080/people/tobin/projects/hoshenkopelman/hoshenkopelman.html) although it is union-find on a gridgraph with raster scan order. Applications include modelingpercolation and electrical conductance. Plot site occupancyprobability vs. number of clusters (say 100-by-100, with p between0 and 1, number of clusters between 0 and 1500) or distribution ofclusters. (seems like DFS would suffice here) Matlab has afunction bwlabel in the image processingtoolbox that performs cluster labeling.