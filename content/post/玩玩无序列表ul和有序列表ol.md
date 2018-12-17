---
title: '玩玩无序列表ul和有序列表ol'
date: 2013-10-18 19:19:21
categories: 
- 前端
tags: 
- html
- css
- 列表
- ul
- ol
---
写博客有时候用到列表，这里好好玩一玩。

### CSS list-style-type 属性

#### 属性介绍

|值|描述
|-----
|none|无标记。
|disc|默认。标记是实心圆。
|circle|标记是空心圆。
|square|标记是实心方块。
|decimal|标记是数字。
|decimal-leading-zero|0开头的数字标记。(01, 02, 03, 等。)
|lower-roman|小写罗马数字(i, ii, iii, iv, v, 等。)
|upper-roman|大写罗马数字(I, II, III, IV, V, 等。)
|lower-alpha|小写英文字母The marker is lower-alpha (a, b, c, d, e, 等。)
|upper-alpha|大写英文字母The marker is upper-alpha (A, B, C, D, E, 等。)
|lower-greek|小写希腊字母(alpha, beta, gamma, 等。)
|lower-latin|小写拉丁字母(a, b, c, d, e, 等。)
|upper-latin|大写拉丁字母(A, B, C, D, E, 等。)
|hebrew|传统的希伯来编号方式
|armenian|传统的亚美尼亚编号方式
|georgian|传统的乔治亚编号方式(an, ban, gan, 等。)
|cjk-ideographic|简单的表意数字
|hiragana|标记是：a, i, u, e, o, ka, ki, 等。（日文片假名）
|katakana|标记是：A, I, U, E, O, KA, KI, 等。（日文片假名）
|hiragana-iroha|标记是：i, ro, ha, ni, ho, he, to, 等。（日文片假名）
|katakana-iroha|标记是：I, RO, HA, NI, HO, HE, TO, 等。（日文片假名）
|inherit|规定应该从父元素继承 list-style-type 属性的值。

#### 示例

```
<ul>
<li style="list-style: none !important;">none</li>
<li style="list-style: disc !important;">disc</li>
<li style="list-style: circle !important;">circle</li>
<li style="list-style: square !important;">square</li>
<li style="list-style: decimal !important;">decimal</li>
<li style="list-style: decimal-leading-zero !important;">decimal-leading-zero</li>
<li style="list-style: lower-roman !important;">lower-roman</li>
<li style="list-style: upper-roman !important;">upper-roman</li>
<li style="list-style: lower-alpha !important;">lower-alpha</li>
<li style="list-style: upper-alpha !important;">upper-alpha</li>
<li style="list-style: lower-greek !important;">lower-greek</li>
<li style="list-style: lower-latin !important;">lower-latin</li>
<li style="list-style: upper-latin !important;">upper-latin</li>
<li style="list-style: hebrew !important;">hebrew</li>
<li style="list-style: armenian !important;">armenian</li>
<li style="list-style: georgian !important;">georgian</li>
<li style="list-style: cjk-ideographic !important;">cjk-ideographic</li>
<li style="list-style: hiragana !important;">hiragana</li>
<li style="list-style: katakana !important;">katakana</li>
<li style="list-style: hiragana-iroha !important;">hiragana-iroha</li>
<li style="list-style: katakana-iroha !important;">katakana-iroha</li>
<li style="list-style: inherit !important;">inherit</li>
</ul>
```
<ul><li style="list-style: none !important;">none</li><li style="list-style: disc !important;">disc</li><li style="list-style: circle !important;">circle</li><li style="list-style: square !important;">square</li><li style="list-style: decimal !important;">decimal</li><li style="list-style: decimal-leading-zero !important;">decimal-leading-zero</li><li style="list-style: lower-roman !important;">lower-roman</li><li style="list-style: upper-roman !important;">upper-roman</li><li style="list-style: lower-alpha !important;">lower-alpha</li><li style="list-style: upper-alpha !important;">upper-alpha</li><li style="list-style: lower-greek !important;">lower-greek</li><li style="list-style: lower-latin !important;">lower-latin</li><li style="list-style: upper-latin !important;">upper-latin</li><li style="list-style: hebrew !important;">hebrew</li><li style="list-style: armenian !important;">armenian</li><li style="list-style: georgian !important;">georgian</li><li style="list-style: cjk-ideographic !important;">cjk-ideographic</li><li style="list-style: hiragana !important;">hiragana</li><li style="list-style: katakana !important;">katakana</li><li style="list-style: hiragana-iroha !important;">hiragana-iroha</li><li style="list-style: katakana-iroha !important;">katakana-iroha</li><li style="list-style: inherit !important;">inherit</li></ul>

### CSS list-style-position 属性

#### 属性介绍

|值|描述
|-----
|inside|列表项目标记放置在文本以内，且环绕文本根据标记对齐。
|outside|默认值。保持标记位于文本的左侧。列表项目标记放置在文本以外，且环绕文本不根据标记对齐。
|inherit|规定应该从父元素继承 list-style-position 属性的值。

#### 示例

```
<ul>
<li style="list-style-position: inside !important;">inside</li>
<li style="list-style-position: outside !important;">outside</li>
<li style="list-style-position: inherit !important;">inherit</li>
</ul>
```
<ul><li style="list-style-position: inside !important;">inside</li><li style="list-style-position: outside !important;">outside</li><li style="list-style-position: inherit !important;">inherit</li></ul>

### CSS list-style-image 属性

#### 属性介绍

|值|描述
|-----
|_URL_|图像的路径。
|none|默认。无图形被显示。
|inherit|规定应该从父元素继承 list-style-image 属性的值。
