---
title: '[算法] Trie（数字树、字典树、前缀树）'
date: 2013-09-18 21:06:56
categories: 
- Algorithm.DataStruct
tags: 
- trie
- 数字树
- 字典树
- 前缀树
- 算法
---
术语trie取自re**trie**val，也被称为数字树、字典树或前缀树，是一种有序树数据结构，哈希树的变种。
与二叉查找树不同，树中节点不存储与节点关联的键，而是通过树中的位置定义键。一个节点的所有子孙节点拥有与该节点相同的字符串前缀，根节点与空字符串相关联。并不是每个节点都与值关联，仅叶节点和部分内部节点与值关联。
![[算法] Trie（数字树、字典树、前缀树）](/images/2013/9/72ef7beatx6CZasDuxx1f.png)含有键为"A"、"to"、"tea"、"ted"、"ten"、"i"、"in"和"inn"的trie示例。
trie 中的键通常是字符串，但也可以是其它的结构。trie的算法可以很容易地修改为处理其它结构的有序序列，比如一串数字或者形状的排列。比如，bitwise trie中的键是一串位元，可以用于表示整数或者内存地址。

## 性质

- 根节点不包含字符，除根节点外每一个节点都只包含一个字符；
- 从根节点到某一节点，路径上经过的字符连接起来，为该节点对应的字符串；
- 每个节点的所有子节点包含的字符都不相同。

## 应用

### 替代其他数据结构

trie较二叉查找树有很多优点，trie可用于替代哈希表，优点如下：
- trie数据查找与不完美哈希表（链表实现，完美哈希表为数组实现）在最差情况下更快：对于trie，最差情况为O(m)，m为查找字符串的长度；对于不完美哈希表，会有键冲突（不同键哈希相同），最差情况为O(N)，N为全部字符产集合个数。典型情况下是O(m)用于哈希计算、O(1)用于数据查找。
- trie中不同键没有冲突
- trie的桶与哈希表用于存储键冲突的桶类似，仅在单个键与多个值关联时需要
- 当更多的键加入trie，无需提供哈希方法或改变哈希方法
- tire通过键为条目提供了字母顺序Trie也有一些缺点：
- trie数据查找在某些情况下（尤其当数据直接从磁盘或随机访问时间远远高于主内存的辅助存储设备时）比哈希表慢
- 当键为某些类型时（例如浮点数）之类的键，前缀链很长且前缀不是特别有意义。然而bitwisetrie能够处理标注IEEE单精度和双精度浮点数。
- 一些trie会比哈希表消耗更多空间：对于trie，每个字符串的每个字符都可能需要分配内存；对于大多数哈希表，为整个条目分配一块内存。

### 字典表示

典型应用是预测文本排序（常被搜索引擎系统用于文本词频统计）、字典自动完成、字符串近似匹配（拼写检查、断字）。

## 实现

trie基本操作有：查找、插入和删除。
trie数据查找的方法为
- 从根结点开始一次搜索；
- 取得要查找关键词的第一个字母，并根据该字母选择对应的子树并转到该子树继续进行检索；
- 在相应的子树上，取得要查找关键词的第二个字母,并进一步选择对应的子树进行检索。
- 迭代过程……
- 在某个结点处，关键词的所有字母已被取出，则读取附在该结点上的信息，即完成查找。

```
public class Trie {
 
  private Node root = new Node("");
 
  public Trie() {}
 
  public Trie(List argInitialWords) {
    for (String word:argInitialWords) {
      addWord(word);
    }
  }
 
  public void addWord(String argWord) {
    char argChars[] = argWord.toCharArray();
    Node currentNode = root;
 
    for (int i = 0; i < argChars.length; i++) {
      if (!currentNode.containsChildValue(argChars[i])) {
        currentNode.addChild(argChars[i], 
                  new Node(currentNode.getValue() + argChars[i]));
      }
 
      currentNode = currentNode.getChild(argChars[i]);
    }
 
    currentNode.setIsWord(true);
  }
 
  public boolean containsPrefix(String argPrefix) {
    return contains(argPrefix, false);
  }
 
  public boolean containsWord(String argWord) {
    return contains(argWord, true);
  }
 
  public Node getWord(String argString) {
    Node node = getNode(argString);
    return node != null && node.isWord()  node : null;
  }
 
  public Node getPrefix(String argString) {
    return getNode(argString);
  }
 
 
  private boolean contains(String argString, boolean argIsWord) {
    Node node = getNode(argString);
    return (node != null && node.isWord() && argIsWord) ||
            (!argIsWord && node != null);
  }
 
  private Node getNode(String argString) {
    Node currentNode = root;
    char argChars[] = argString.toCharArray();
    for (int i = 0; i < argChars.length && currentNode != null; i++) {
      currentNode = currentNode.getChild(argChars[i]);
 
      if (currentNode == null) {
        return null;
      }
    }
 
    return currentNode;
  }
}
 
 
class Node {
 
  private final String value;
  private Map children = new HashMap();
  private boolean isValidWord;
 
  public Node(String argValue) {
    value = argValue;
  }
 
  public boolean addChild(char c, Node argChild) {
    children.put(c, argChild);
    return true;
  }
 
  public boolean containsChildValue(char c) {
    return children.containsKey(c);
  }
 
  public String getValue() {
    return value.toString();
  }
 
  public Node getChild(char c) {
    return children.get(c);
  }
 
  public boolean isWord() {
    return isValidWord;
  }
 
  public void setIsWord(boolean argIsWord) {
    isValidWord = argIsWord;
 
  }
 
  public String toString() {
    return value;
  }
 
}
 
public class Test {
 
  private static BufferedReader br = new BufferedReader(
                                new InputStreamReader(System.in));
 
  public static void main(String[] args) {
    String words[] = { "a", "apple", "argument", "aptitude", "ball", "bat" };
    Trie trie = new Trie(Arrays.asList(words));
    try {
      while (true) {
        System.out.print("Word to lookup: ");
        String word = br.readLine().trim();
        if (word.isEmpty())
          break;
        if (trie.containsWord(word))
          System.out.println(word + " found");
        else if (trie.containsPrefix(word)) {
          if (confirm(word + " is a prefix.  Add it as a word "))
            trie.addWord(word);
        }
        else {
          if (confirm("Add " + word + " "))
            trie.addWord(word);
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
 
  public static boolean confirm( String question )  throws IOException
  {
    while (true) {
      System.out.print(question + " ");
      String ans = br.readLine().trim();
      if (ans.equalsIgnoreCase("N") || ans.equalsIgnoreCase("NO"))
        return false;
      else if (ans.equalsIgnoreCase("Y") || ans.equalsIgnoreCase("YES"))
        return true;
      System.out.println("Please answer Y, YES, or N, NO");
    }
  }
}
```

## 引用

维基百科：[Trie](http://en.wikipedia.org/wiki/Prefix_tree)[字典树](http://zh.wikipedia.org/wiki/%E5%AD%97%E5%85%B8%E6%A0%91)  
百度百科:[字典树](http://baike.baidu.com/view/2759664.htm)[前缀树](http://baike.baidu.com/view/9875057.htm)  
[An Implementation of Double-Array Trie](http://linux.thai.net/~thep/datrie/datrie.html)  