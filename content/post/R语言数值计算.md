---
title: 'R语言数值计算'
date: 2013-07-13 21:14:49
categories: 
- DataScience
tags: 
- R语言
- 数值
- 计算
- 运算
---
R中数值计算的对象一般是向量或列表，不同长度的对象进行计算时，短的对象元素将被循环使用。

<table border="1" cellpadding="4" cellspacing="0" frame="border" rules="all" summary="" style="font-family: Arial, Verdana, sans-serif; border-collapse: collapse; border-width: 1px; margin-top: 7pt;min-width:400px"><tbody><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">运算操作符</td></tr><tr><td style="vertical-align: top;">+ - * /<br>& | ！<br>== != > >= < <=<br>^ 幂运算<br>%% 取模<br>%/% 整除</td><td style="vertical-align: top;"><pre style="margin: 0;">> a<-c(2,49,25,8)
> b<-c(2,7,6)
> a/b
[1] 1.000000 7.000000 4.166667 4.000000
Warning message:
In a/b : longer object length is not a multiple of shorter object length
> 2^5
[1] 32
> 25%%6
[1] 1
> 13%/%5
[1] 2
> 7&8
[1] TRUE</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">无归类的函数</td></tr><tr><td style="vertical-align: top;">sign 取符号</td><td style="vertical-align: top;"><pre style="margin: 0;">> sign(-2:2)
[1] -1 -1 0 1 1</pre></td></tr><tr><td style="vertical-align: top;">abs 取绝对值</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">sqrt 取平方根</td><td style="vertical-align: top;"><pre style="margin: 0;">> sqrt(-2:2)
[1] NaN NaN 0.000000 1.000000 1.414214
Warning message:
In sqrt(-2:2) : NaNs produced</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">对数与指数函数</td></tr><tr><td style="vertical-align: top;">log(x, base = exp(1)) 取base为底的对数，base缺省的情况下取自然对数<br>logb(x, base = exp(1)) 是为了兼容S语言而实现的log函数封装器<br>log10(x) 取常用对数<br>log2(x) 取2为底的对数</td><td style="vertical-align: top;"><pre style="margin: 0;">> log(64, 8)
[1] 2</pre></td></tr><tr><td style="vertical-align: top;">log1p(x)<br>计算log(1+x)</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">exp(x) 取指数</td><td style="vertical-align: top;"><pre style="margin: 0;">> exp(1)
[1] 2.718282</pre></td></tr><tr><td style="vertical-align: top;">expm1(x)<br>计算exp(x) - 1</td><td style="vertical-align: top;"></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">取整舍入</td></tr><tr><td style="vertical-align: top;">ceiling(x)<br>向上取整</td><td style="vertical-align: top;"><pre style="margin: 0;">> ceiling(3.666666)
[1] 4
> ceiling(-3.666666)
[1] -3</pre></td></tr><tr><td style="vertical-align: top;">floor(x)<br>向下取整</td><td style="vertical-align: top;"><pre style="margin: 0;">> floor(3.666666)
[1] 3
> floor(-3.666666)
[1] -4</pre></td></tr><tr><td style="vertical-align: top;">trunc(x, ...)<br>取整</td><td style="vertical-align: top;"><pre style="margin: 0;">> trunc(3.666666)
[1] 3
> trunc(-3.666666)
[1] -3</pre></td></tr><tr><td style="vertical-align: top;">round(x, digits = 0)<br>四舍五入，正数的digits为小数个数，负数的digits为整数的个数</td><td style="vertical-align: top;"><pre style="margin: 0;">> round(3.666666,3)
[1] 3.667
> round(-3.666666,3)
[1] -3.667
> round(266.6666,-2)
[1] 300</pre></td></tr><tr><td style="vertical-align: top;">signif(x, digits = 6)<br>四舍五入，正数的digits为整数和小数的个数，负数的digits为整数的个数</td><td style="vertical-align: top;"><pre style="margin: 0;">> signif(3.666666,3)
[1] 3.67
> signif(-3.666666,3)
[1] -3.67
> signif(266.6666,-2)
[1] 300</pre></td></tr><tr><td style="vertical-align: top;">zapsmall(x, digits = getOption("digits"))<br>zapsmall选取round的digits参数，以使向量中与最大绝对值相比接近0的数值被剃掉</td><td style="vertical-align: top;"><pre style="margin: 0;">> zapsmall
function (x, digits = getOption("digits"))
{
 if (length(digits) == 0L)
  stop("invalid 'digits'")
 if (all(ina <- is.na(x)))
  return(x)
 mx <- max(abs(x[!ina]))
 round(x, digits = if (mx > 0) max(0L, digits -log10(mx)) else digits)
}</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">三角函数</td></tr><tr><td style="vertical-align: top;">sin(x) 正弦函数</td><td style="vertical-align: top;"><pre style="margin: 0;">> sin(pi/6)
[1] 0.5</pre></td></tr><tr><td style="vertical-align: top;">cos(x) 余弦函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">tan(x) 正切函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">asin(x) 反正弦函数</td><td style="vertical-align: top;"><pre style="margin: 0;">> asin(0.5) #->pi/6
[1] 0.5235988</pre></td></tr><tr><td style="vertical-align: top;">acos(x) 反余弦函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">atan(x) 反正切函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">atan2 反正切函数<br>atan2(y, x)=atan(y/x).</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">sinpi(x) 正弦函数<br>sinpi(x)=sin(pi*x)</td><td style="vertical-align: top;"><pre style="margin: 0;">> sinpi(1/6)
[1] 0.5</pre></td></tr><tr><td style="vertical-align: top;">cospi(x) 余弦函数<br>cospi(x)=cos(pi*x)</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">tanpi(x) 正切函数<br>tanpi(x)=tan(pi*x)</td><td style="vertical-align: top;"></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">双曲函数</td></tr><tr><td style="vertical-align: top;">sinh(x) 双曲正弦函数<br>sinh(x)=(exp(x)-exp(-x))/2</td><td style="vertical-align: top;"><pre style="margin: 0;">> sinh(pi/6)
[1] 0.5478535
> (exp(pi/6)-exp(-pi/6))/2
[1] 0.5478535</pre></td></tr><tr><td style="vertical-align: top;">cosh(x) 双曲余弦函数<br>cosh(x)=(exp(x)+exp(-x))/2</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">tanh(x) 双曲正切函数<br>tanh(x)=sinh(x)/cosh(x)</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">asinh(x) 反双曲正弦函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">acosh(x) 反双曲余弦函数</td><td style="vertical-align: top;"></td></tr><tr><td style="vertical-align: top;">atanh(x) 反双曲正切函数</td><td style="vertical-align: top;"></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">汇总函数</td></tr><tr><td style="vertical-align: top;">max(..., na.rm = FALSE)<br>取最大值</td><td style="vertical-align: top;"><pre style="margin: 0;">> max(5:1, pi) #-> one number
[1] 5</pre></td></tr><tr><td style="vertical-align: top;">min(..., na.rm = FALSE)<br>取最小值</td><td style="vertical-align: top;"><pre style="margin: 0;">> min(5:1, pi) #-> one number
[1] 1</pre></td></tr><tr><td style="vertical-align: top;">pmax(..., na.rm = FALSE)<br>取并行最大值</td><td style="vertical-align: top;"><pre style="margin: 0;">> pmax(5:1, pi) #-> 5 numbers
[1] 5.000000 4.000000 3.141593 3.141593 3.141593</pre></td></tr><tr><td style="vertical-align: top;">pmin(..., na.rm = FALSE)<br>取并行最小值</td><td style="vertical-align: top;"><pre style="margin: 0;">> pmin(5:1, pi) #-> 5 numbers
[1] 3.141593 3.141593 3.000000 2.000000 1.000000</pre></td></tr><tr><td style="vertical-align: top;">range(..., na.rm = FALSE, finite = FALSE)<br>返回含最大值和最小值的向量</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(NA, 1:3, -1:1/0); x
[1] NA 1 2 3 -Inf NaN Inf
> range(x)
[1] NA NA
> range(x, na.rm = TRUE)
[1] -Inf Inf
> range(x, finite = TRUE)
[1] 1 3</pre></td></tr><tr><td style="vertical-align: top;">which.min(x)<br>返回最小值下标</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(1:4, 0:5, 11);x
[1] 1 2 3 4 0 1 2 3 4 5 11
> which.min(x)
[1] 5</pre></td></tr><tr><td style="vertical-align: top;">which.max(x)<br>返回最大值下标</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(1:4, 0:5, 11);x
[1] 1 2 3 4 0 1 2 3 4 5 11
> which.max(x)
[1] 11</pre></td></tr><tr><td style="vertical-align: top;">any(..., na.rm = FALSE)<br>任一个元素值为真则返回TRUE;<br>所有元素值为假则返回FALSE;<br>na.rm参数为FALSE时，没有元素值为真且数据中有NA值则返回NA</td><td style="vertical-align: top;"><pre style="margin: 0;">> any(c(-2:0)>0)
[1] FALSE
> any(c(1:2,NA)>0)
[1] TRUE
> any(c(-2:0,NA)>0)
[1] NA</pre></td></tr><tr><td style="vertical-align: top;">all(..., na.rm = FALSE)<br>所有元素值为真则返回TRUE;<br>任一个元素值为假则返回FALSE;<br>na.rm参数为FALSE时，没有元素值为假且数据中有NA值则返回NA</td><td style="vertical-align: top;"><pre style="margin: 0;">> all(c(1:2)>0)
[1] TRUE
> all(c(-2:0,NA)>0)
[1] FALSE
> all(c(1:2,NA)>0)
[1] NA</pre></td></tr><tr><td style="vertical-align: top;">sum(..., na.rm = FALSE)<br>任一个元素值为NA则返回NA;<br>元素不含NA，任意元素值为NaN则返回NaN；<br>元素不含NA和NaN，返回元素和，NULL视为整数0</td><td style="vertical-align: top;"><pre style="margin: 0;">> sum(1:3)
[1] 6
> sum(1:3,NA)
[1] NA
> sum(1:3,NaN)
[1] NaN
> sum(1:3,NaN,NA)
[1] NA</pre></td></tr><tr><td style="vertical-align: top;">prod(..., na.rm = FALSE)<br>任一个元素值为NA则返回NA;<br>元素不含NA，任意元素值为NaN则返回NaN；<br>元素不含NA和NaN，返回元素乘积，NULL视为数字0</td><td style="vertical-align: top;"><pre style="margin: 0;">> prod(1:3)
[1] 6
> prod(1:3,NA)
[1] NA
> prod(1:3,NaN)
[1] NaN
> prod(1:3,NaN,NA)
[1] NA</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">累计函数</td></tr><tr><td style="vertical-align: top;">cumsum 取累计和<br>遇到NA或NaN元素，返回NA<br>NULL元素会被忽略掉</td><td style="vertical-align: top;"><pre style="margin: 0;">> cumsum(1:5)
[1] 1 3 6 10 15
> cumsum(c(1:3,NA,4:5))
[1] 1 3 6 NA NA NA
> cumsum(c(1:3,NaN,4:5))
[1] 1 3 6 NA NA NA
> cumsum(c(1:3,NULL,4:5))
[1] 1 3 6 10 15</pre></td></tr><tr><td style="vertical-align: top;">cumprod 取累计乘积<br>遇到NA或NaN元素，返回NA<br>NULL元素会被忽略掉</td><td style="vertical-align: top;"><pre style="margin: 0;">> cumprod(1:5)
[1] 1 2 6 24 120</pre></td></tr><tr><td style="vertical-align: top;">cummin 取累计最小值<br>如果累计最小值不为NA，遇到NaN元素输出NaN；<br>遇到NA元素输出NA<br>NULL元素会被忽略掉</td><td style="vertical-align: top;"><pre style="margin: 0;">> #对于列表元素3 2 1 2 1 0 4 3 2，cummin第四个输入为2，
> #比累计最小值1大，所以第四个输出为1
> cummin(c(3:1, 2:0, 4:2))
[1] 3 2 1 1 1 0 0 0 0
> cummin(c(3:1, NaN, 2:0, NA, 4:2))
[1] 3 2 1 NaN NaN NaN NaN NA NA NA NA</pre></td></tr><tr><td style="vertical-align: top;">cummax 取累计最大值<br>如果累计最小值不为NA，遇到NaN元素输出NaN；<br>遇到NA元素输出NA<br>NULL元素会被忽略掉</td><td style="vertical-align: top;"><pre style="margin: 0;">> #对于列表元素3 2 1 2 1 0 4 3 2，cummin前六个输出都为第一个输入3，
> #第七个输入为4，比累计最小值3大，所以第七个输出为4
> cummax(c(3:1, 2:0, 4:2)) #3 2 1 2 1 0 4 3 2
[1] 3 3 3 3 3 3 4 4 4
> cummax(c(3:1, NA, 2:0, NaN, 4:2))
[1] 3 3 3 NA NA NA NA NA NA NA NA</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center"><a href="http://zh.wikipedia.org/wiki/%CE%92%E5%87%BD%E6%95%B0">beta</a>和<a href="http://zh.wikipedia.org/zh/%CE%93%E5%87%BD%E6%95%B0">gamma</a>相关函数</td>
</tr><tr><td colspan="2">![R语言数值计算](/images/2013/7/0026uWfMgy6PF9i0WUI64.jpg)此外，还有<a href="http://zh.wikipedia.org/zh/%E8%B4%9D%E5%A1%9E%E5%B0%94%E5%87%BD%E6%95%B0">Bessel</a>函数:<ul><li>besselI(x, nu, expon.scaled = FALSE)</li><li>besselK(x, nu, expon.scaled = FALSE)</li><li>besselJ(x, nu)</li><li>besselY(x, nu)</li></ul>其中，排列组合函数choose和阶乘函数factorial比较常用。</td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">复数函数</td></tr><tr><td style="vertical-align: top;">Re(z) 取实部<br>Im(z) 取虚部<br>Mod(z) 取模<br>Arg(z) 取幅角<br>Conj(z) 共轭复数<br><br><br>对于一个复数z=x + iy，<br>r=Mod(z)=√(x^2+y^2)，<br>φ=Arg(z)，<br>x=r*cos(φ)且y=r*sin(φ)</td><td style="vertical-align: top;"><pre style="margin: 0;">> 1:2 + 1i*(8:9)
[1] 1+8i 2+9i
> z <- complex(real = 1:3, imaginary =7:9);z
[1] 1+7i 2+8i 3+9i
> Re(z)
[1] 1 2 3
> Im(z)
[1] 7 8 9
> Mod(z)
[1] 7.071068 8.246211 9.486833
> Arg(z)
[1] 1.428899 1.325818 1.249046
> Conj(z)
[1] 1-7i 2-8i 3-9i</pre></td></tr><tr><td colspan="2" style="background-color: rgb(180, 180, 180);text-align: center">排序函数</td></tr><tr><td style="vertical-align: top;">rev 逆序</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(1:5, 5:3);x
[1] 1 2 3 4 5 5 4 3
> rev(x)
[1] 3 4 5 5 4 3 2 1</pre></td></tr><tr><td style="vertical-align: top;">sort(x, decreasing = FALSE, ...)<br>向量、列表或因子排序</td><td style="vertical-align: top;"><pre style="margin: 0;">> x <- c(1:5, 5:3);x
[1] 1 2 3 4 5 5 4 3
> sort(x)
[1] 1 3 4 15 92</pre></td></tr><tr><td style="vertical-align: top;">order(..., na.last = TRUE, decreasing = FALSE)<br>次序下标，可用于多个变量，例如数据框<br>第一个输出为5，是由于第五个输入按增序排第一</td><td style="vertical-align: top;"><pre style="margin: 0;">> set.seed(1)
> x <- sample(1:10, 5);x
[1] 3 4 5 7 2
> order(x)
[1] 5 1 2 3 4</pre></td></tr><tr><td style="vertical-align: top;">rank(x, na.last = TRUE,<br>ties.method = c("average", "first", "random", "max", "min"))<br>排名</td><td style="vertical-align: top;"><pre style="margin: 0;">> set.seed(1)
> x <- sample(1:10, 5);x
[1] 3 4 5 7 2
> rank(x)
[1] 2 3 4 5 1</pre></td></tr></tbody></table>
