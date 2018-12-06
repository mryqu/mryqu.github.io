---
title: 'Vagrant base box列表'
date: 2015-05-28 05:28:59
categories: 
- Tool
- Vagrant
tags: 
- vagrant
- basebox
- ubuntu
---
Vagrant的basebox都是打包了最小安装版操作系统(仅有一些跟Vagrant通讯必需的工具)的虚拟机镜像。[vagrantbox.es](http://www.vagrantbox.es/)列出了很多Vagrant的basebox，其中既有官方的box也有很多非官方的box。
有的box名是lucid32.box、lucid64.box、precise32.box、precise64.box，一开始不明白怎么回事，后来知道用的是Ubuntu的英文代码。

### Ubuntu各种版本的英文代码

|版本|英文代号|中译
|-----
|Ubuntu 4.10|Warty Warthog|多疣的疣猪
|Ubuntu 5.04|Hoary Hedgehog|白发的刺猬
|Ubuntu 5.10|Breezy Badger|活泼的獾
|Ubuntu 6.06|Dapper Drake|整洁的公鸭
|Ubuntu 6.10|Edgy Eft|尖利的小蜥蜴
|Ubuntu 7.04|Feisty Fawn|烦躁不安的鹿
|Ubuntu 7.10|Gutsy Gibbon|胆大的长臂猿
|Ubuntu 8.04|Hardy Heron|坚强的鹭
|Ubuntu 8.10|Intrepid Ibex|无畏的羱羊
|Ubuntu 9.04|Jaunty Jackalope|活泼的鹿角兔
|Ubuntu 9.10|Karmic Koala|幸运的树袋熊
|Ubuntu 10.04|Lucid Lynx|清醒的猞猁
|Ubuntu 10.10|Maverick Meerkat|标新立异的的狐獴
|Ubuntu 11.04|Natty Narwhal|敏捷的独角鲸
|Ubuntu 11.10|Oneiric Ocelot|有梦的虎猫
|Ubuntu 12.04|Precise Pangolin|精准的穿山甲
|Ubuntu 12.10|Quantal Quetzal|量子的格查尔鸟
|Ubuntu 13.04|Raring Ringtail|铆足了劲的环尾猫熊
|Ubuntu 13.10|Saucy Salamander|活泼的蝾螈
|Ubuntu 14.04|Trusty Tahr|可靠的塔尔羊
|Ubuntu 14.10|Utopic Unicorn|乌托邦的独角兽
|Ubuntu 15.04|Vivid Vervet|活泼的长尾黑颚猴
|Ubuntu 15.10|Wily Werewolf|老谋深算的狼人

我家里现在装的是衍生版本Ubuntu Kylin 15.04，不知道英文代码是不是vivid Vervet？

### Debian各种版本的英文代码

|版本|代号|发布期|玩具总动员的对应角色|脚注
|-----
|1.1|Buzz|1996.6.17|巴斯光.，电影主角之一的太空人|使用Linux内核2.0
|1.2|Rex|1996.12.12|抱抱龙|&nbsp;
|1.3|Bo|1997.6.2|放羊的女孩“宝贝”|&nbsp;
|2.0|[Hamm](http://www.debian.org/releases/hamm/)|1998.7.24|小猪储蓄罐“火腿”|&nbsp;
|2.1|[Slink](http://www.debian.org/releases/slink/)|1999.3.9|弹簧狗|APT面世
|2.2|[Potato](http://www.debian.org/releases/potato/)|2000.8.15|蛋头先生|&nbsp;
|3.0|[Woody](http://www.debian.org/releases/woody/)|2002.7.19|胡迪，电影主角之一的牛仔|&nbsp;
|3.1|[Sarge](http://www.debian.org/releases/sarge/)|2005.6.6|绿色塑胶玩具士兵的首领“队长”|&nbsp;
|4.0|[Etch](http://www.debian.org/releases/etch/)|2007.4.8|画板|&nbsp;
|5.0|[Lenny](http://www.debian.org/releases/lenny/)|2009.2.14|望远镜|&nbsp;
|6.0|[Squeeze](http://www.debian.org/releases/squeeze/)|2011.2.6|三只眼的外星人|其i386及amd64架构为长期支持版本，<br>是第一个包含长期支持的Debian版本，<br>支持到2016.2。
|7.0|[Wheezy](http://www.debian.org/releases/wheezy/)|2013.5.5|吱吱（第二部玩具总动员的一个角色，<br>是一只带着领结的玩具企鹅）|上一个稳定版本
|8.0|[Jessie](http://www.debian.org/releases/jessie/)|2015.4.25|翠丝（第二部玩具总动员的一个角色，<br>是一个为虚拟的电视剧 Woody's Roundup<br>而塑造的女牛仔人物）|目前的稳定版本，默认init系统切换为systemd
