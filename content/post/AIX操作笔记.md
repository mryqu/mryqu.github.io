---
title: 'AIX操作笔记'
date: 2020-12-23 12:31:23
categories: 
- Tool
- Linux
tags: 
- AIX

---

### 查看版本

TL（Technical Level）指 AIX 操作系统的技术版本（以前称为 ML, Maintenance Level），包括硬件、软件的新功能和传统的补丁。  
SP( Service Pack) 指服务补丁版本，包括一些不能等到下一个TL推出的关键的补丁及非常有限的新硬件驱动。  

```
$ oslevel -s
7100-04-04-1717
```

上例中oslevel -s显示结果为7100-04-04-1717，头四位系统版本，接下来两位为技术版本，之后两位为补丁版本，最后4位，前2位标识年份，后2位表示周。  
7100-04-04-1717表示AIX7.1 TL版本04，SP版本04，这个版本是在2017年第17周进行的更新。  


### 安装软件

在ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/ 查找到所需软件的链接，然后通过rpm进行安装。例如：  
```
rpm -Uvh ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/curl/curl-7.9.3-2.aix4.3.ppc.rpm
```

### 查看系统指标  

#### bindprocessor

[bindprocessor](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/b_commands/bindprocessor.html) 用于将进程的内核线程绑定至处理器或取消绑定。

```
$ bindprocessor -q
The available processors are:  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
```

#### lparstat  

[lparstat](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/l_commands/lparstat.html)  报告逻辑分区（LPAR）相关信息和统计。

```
$ lparstat -i
Node Name                                  : actaixtest
Partition Name                             : actaixtest
Partition Number                           : 2
Type                                       : Shared-SMT-4
Mode                                       : Uncapped
Entitled Capacity                          : 0.80
Partition Group-ID                         : 32770
Shared Pool ID                             : 0
Online Virtual CPUs                        : 8
Maximum Virtual CPUs                       : 8
Minimum Virtual CPUs                       : 1
Online Memory                              : 65536 MB
Maximum Memory                             : 65536 MB
Minimum Memory                             : 1024 MB
Variable Capacity Weight                   : 128
Minimum Capacity                           : 0.10
Maximum Capacity                           : 8.00
Capacity Increment                         : 0.01
Maximum Physical CPUs in system            : 6
Active Physical CPUs in system             : 6
Active CPUs in Pool                        : 6
Shared Physical CPUs in system             : 6
Maximum Capacity of Pool                   : 600
Entitled Capacity of Pool                  : 380
Unallocated Capacity                       : 0.00
Physical CPU Percentage                    : 10.00%
Unallocated Weight                         : 0
Memory Mode                                : Shared
Total I/O Memory Entitlement               : 77.000 MB
Variable Memory Capacity Weight            : 128
Memory Pool ID                             : 0
Physical Memory in the Pool                : 50.000 GB
Hypervisor Page Size                       : 4K
Unallocated Variable Memory Capacity Weight: 0
Unallocated I/O Memory entitlement         : 0.000 MB
Memory Group ID of LPAR                    : 32770
Desired Virtual CPUs                       : 8
Desired Memory                             : 65536 MB
Desired Variable Capacity Weight           : 128
Desired Capacity                           : 0.80
Target Memory Expansion Factor             : -
Target Memory Expansion Size               : -
Power Saving Mode                          : Disabled
Sub Processor Mode                         : -
```

#### lsdev

[lsdev](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/l_commands/lsdev.html) 是IBM AIX系统中设备管理的常用命令，用来显示系统中的设备及其特征。  

```
$ lsdev -H
name       status    location description

L2cache0   Available          L2 Cache
cluster0   Available          Cluster Node
en0        Available          Standard Ethernet Network Interface
ent0       Available          Virtual I/O Ethernet Adapter (l-lan)
et0        Defined            IEEE 802.3 Ethernet Network Interface
fslv00     Defined            Logical volume
hd1        Defined            Logical volume
hd2        Defined            Logical volume
hd3        Defined            Logical volume
hd4        Defined            Logical volume
hd5        Defined            Logical volume
hd6        Defined            Logical volume
hd8        Defined            Logical volume
hd10opt    Defined            Logical volume
hd11admin  Defined            Logical volume
hd9var     Defined            Logical volume
hdisk0     Available          Virtual SCSI Solid State Drive
inet0      Available          Internet Network Extension
iocp0      Defined            I/O Completion Ports
iscsi0     Available          iSCSI Protocol Device
lg_dumplv  Defined            Logical volume
livedump   Defined            Logical volume
lo0        Available          Loopback Network Interface
lvdd       Available          LVM Device Driver
mem0       Available          Memory
proc0      Available 00-00    Processor
proc4      Available 00-04    Processor
proc8      Available 00-08    Processor
proc12     Available 00-12    Processor
proc16     Available 00-16    Processor
proc20     Available 00-20    Processor
proc24     Available 00-24    Processor
proc28     Available 00-28    Processor
pty0       Available          Asynchronous Pseudo-Terminal
rcm0       Defined            Rendering Context Manager Subsystem
rootvg     Defined            Volume group
sfw0       Available          Storage Framework Module
sys0       Available          System Object
sysplanar0 Available          System Planar
vio0       Available          Virtual I/O Bus
vsa0       Available          LPAR Virtual Serial Adapter
vscsi0     Available          Virtual SCSI Client Adapter
vty0       Available          Asynchronous Terminal
$
$ lsdev -Cc processor
proc0  Available 00-00 Processor
proc4  Available 00-04 Processor
proc8  Available 00-08 Processor
proc12 Available 00-12 Processor
proc16 Available 00-16 Processor
proc20 Available 00-20 Processor
proc24 Available 00-24 Processor
proc28 Available 00-28 Processor
$
$ lsdev -Cc memory
L2cache0 Available  L2 Cache
mem0     Available  Memory
```

#### lsattr

[lsattr](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/l_commands/lsattr.html) 显示系统中设备属性特征及属性值。  

```
$ lsattr -EHl mem0
attribute      value description                                user_settable

ent_mem_cap    78848 I/O memory entitlement in Kbytes           False
goodsize       65536 Amount of usable physical memory in Mbytes False
mem_exp_factor       Memory expansion factor                    False
size           65536 Total amount of physical memory in Mbytes  False
var_mem_weight 128   Variable memory capacity weight            False
$
$ lsattr -EHl proc0
attribute   value          description           user_settable

frequency   3720000000     Processor Speed       False
smt_enabled true           Processor SMT enabled False
smt_threads 4              Processor SMT threads False
state       enable         Processor state       False
type        PowerPC_POWER7 Processor type        False
```

#### lscfg

[lscfg](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/l_commands/lscfg.html) 显示系统中的配置情况，诊断信息，和重要的产品数据

```
$ lscfg -vp
INSTALLED RESOURCE LIST WITH VPD

The following resources are installed on your machine.

  Model Architecture: chrp
  Model Implementation: Multiple Processor, PCI bus

  sys0                                                           System Object
  sysplanar0                                                     System Planar
  vio0                                                           Virtual I/O Bus
  vscsi0           U8231.E2B.1035C9P-V2-C3-T1                    Virtual SCSI Client Adapter

        Hardware Location Code......U8231.E2B.1035C9P-V2-C3-T1

  hdisk0           U8231.E2B.1035C9P-V2-C3-T1-L8100000000000000  Virtual SCSI Solid State Drive
  ent0             U8231.E2B.1035C9P-V2-C2-T1                    Virtual I/O Ethernet Adapter (l-lan)

        Network Address.............2ECE76871102
        Displayable Message.........Virtual I/O Ethernet Adapter (l-lan)
        Hardware Location Code......U8231.E2B.1035C9P-V2-C2-T1

  vsa0             U8231.E2B.1035C9P-V2-C0                       LPAR Virtual Serial Adapter

        Hardware Location Code......U8231.E2B.1035C9P-V2-C0

  vty0             U8231.E2B.1035C9P-V2-C0-L0                    Asynchronous Terminal
  L2cache0                                                       L2 Cache
  mem0                                                           Memory
  proc0                                                          Processor
  proc4                                                          Processor
  proc8                                                          Processor
  proc12                                                         Processor
  proc16                                                         Processor
  proc20                                                         Processor
  proc24                                                         Processor
  proc28                                                         Processor

  PLATFORM SPECIFIC

  Name:  IBM,8231-E2B
    Model:  IBM,8231-E2B
    Node:  /
    Device Type:  chrp

      System VPD:
        Record Name.................VSYS
        Flag Field..................XXSV
        Brand.......................S0
        Hardware Location Code......U8231.E2B.1035C9P
        Machine/Cabinet Serial No...1035C9P
        Machine Type and Model......8231-E2B
        System Unique ID (SUID).....0004AC14F505
        World Wide Port Name........C0507603327E
        Version.....................ipzSeries
      Physical Location: U8231.E2B.1035C9P

      CEC:
        Record Name.................VCEN
        Flag Field..................XXEV
        Brand.......................S0
        Hardware Location Code......U78AB.001.WZSG1PW
        Machine/Cabinet Serial No...WZSG1PW
        Machine Type and Model......78AB-001
        Controlling CEC ID..........8231-E2B 1035C9P
        Rack Serial Number..........0000000000000000
        Feature Code/Marketing ID...78AB-001
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW

      SYSTEM BACKPLANE:
        Record Name.................VINI
        Flag Field..................XXBP
        Hardware Location Code......U78AB.001.WZSG1PW-P1
        Customer Card ID Number.....2BFC
        Serial Number...............YL10P02590C0
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................46K7877
        Part Number.................74Y2373
        Power.......................2A00000000000000
        Product Specific.(HE).......0001
        Product Specific.(CT).......40F30024
        Product Specific.(HW).......0004
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Product Specific.(BS).........
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1

      QUAD ETHERNET   :
        Record Name.................VINI
        Flag Field..................XXET
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C2
        Customer Card ID Number.....266D
        Serial Number...............YL10P024501C
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................46K8121
        Part Number.................74Y2525
        Product Specific.(HE).......0001
        Product Specific.(CT).......3091000A
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Product Specific.(B1).......E41F138F1B400020
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C2

      6-WAY  PROC CUOD:
        Record Name.................VINI
        Flag Field..................XXPF
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C10
        Customer Card ID Number.....539D
        Serial Number...............B00000771003
        FRU Number..................74Y6153
        Part Number.................74Y6153
        Product Specific.(HE).......0001
        Product Specific.(CT).......40110006
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000000
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Power.......................3400600133038000
        Product Specific.(VZ).......01
        CCIN Extender...............1
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C10

      PROC REGULATOR  :
        Record Name.................VINI
        Flag Field..................XXRG
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C11
        Customer Card ID Number.....2BE8
        Serial Number...............YL102008E1MK
        Part Number.................74Y5457
        FRU Number.................. 74Y5457
        CCIN Extender...............1
        Product Specific.(VZ).......01
        Product Specific.(CR).......
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-P1-C11

      RAID            :
        Record Name.................VINI
        Flag Field..................XXRD
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C12
        Customer Card ID Number.....2BE1
        Serial Number...............YL10P02501BD
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................46K7723
        Part Number.................74Y2859
        Product Specific.(HE).......0001
        Product Specific.(CT).......30F20005
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C12

      RAID            :
        Record Name.................VINI
        Flag Field..................XXRD
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C13
        Customer Card ID Number.....2BCF
        Serial Number...............YL10P025100D
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................44V8361
        Part Number.................74Y2762
        Product Specific.(HE).......0001
        Product Specific.(CT).......30F20005
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C13

      MEMORY CARD     :
        Record Name.................VINI
        Flag Field..................XXRI
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C16
        Customer Card ID Number.....2BE3
        Serial Number...............YL10P02511D9
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................74Y1959
        Part Number.................74Y2756
        Product Specific.(HE).......0001
        Product Specific.(CT).......40B60007
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C16

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C16-C1
        Customer Card ID Number.....31C8
        Serial Number...............YLD004C06A42
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C16-C1

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C16-C2
        Customer Card ID Number.....31C8
        Serial Number...............YLD005106A3A
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C16-C2

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C16-C3
        Customer Card ID Number.....31C8
        Serial Number...............YLD006703026
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C16-C3

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C16-C4
        Customer Card ID Number.....31C8
        Serial Number...............YLD007506A47
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C16-C4

      MEMORY CARD     :
        Record Name.................VINI
        Flag Field..................XXRI
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C17
        Customer Card ID Number.....2BE3
        Serial Number...............YL10P0255088
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................74Y1959
        Part Number.................74Y2756
        Product Specific.(HE).......0001
        Product Specific.(CT).......40B60007
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C17

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C17-C1
        Customer Card ID Number.....31C8
        Serial Number...............YLD000932D12
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C17-C1

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C17-C2
        Customer Card ID Number.....31C8
        Serial Number...............YLD001932D09
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C17-C2

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C17-C3
        Customer Card ID Number.....31C8
        Serial Number...............YLD002932BB2
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C17-C3

      Memory DIMM:
        Record Name.................VINI
        Flag Field..................XXMS
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C17-C4
        Customer Card ID Number.....31C8
        Serial Number...............YLD003932CA5
        CCIN Extender...............1
        Product Specific.(VZ).......03
        FRU Number..................77P8632
        Part Number.................77P8632
        Power.......................4800000000010000
        Size........................8192
        Product Specific.(HE).......0001
        Product Specific.(CT).......10210004
        Product Specific.(HW).......0001
        Product Specific.(B3).......030000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C17-C4

      RAID            :
        Record Name.................VINI
        Flag Field..................XXRD
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C18
        Customer Card ID Number.....2BD9
        Serial Number...............YL11P134501A
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................74Y3346
        Part Number.................74Y3296
        Product Specific.(HE).......0001
        Product Specific.(CT).......30F20005
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C18

      ANCHOR          :
        Record Name.................VINI
        Flag Field..................XXAV
        Hardware Location Code......U78AB.001.WZSG1PW-P1-C19
        Customer Card ID Number.....52C9
        Serial Number...............YL100009L00J
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................74Y2261
        Part Number.................46K7305
        Power.......................8100300000000000
        Product Specific.(HE).......0010
        Product Specific.(CT).......40B40000
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Product Specific.(B9).......435302631744378A74115350D82AA70B78C5C0134D
                                    318508F6DEAB281E814D3222EA84AED5FCA4F74D33
                                    944DF4201EAEF7984D3478C10751C38E737D
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P1-C19

      CEC OP PANEL    :
        Record Name.................VINI
        Flag Field..................XXOP
        Hardware Location Code......U78AB.001.WZSG1PW-D1
        Customer Card ID Number.....2BCD
        Serial Number...............YL11W02420GM
        CCIN Extender...............1
        Product Specific.(VZ).......01
        FRU Number..................74Y2057
        Part Number.................74Y2058
        Product Specific.(HE).......0001
        Product Specific.(CT).......40B50000
        Product Specific.(HW).......0002
        Product Specific.(B3).......000000000000
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-D1

      A IBM AC PS     :
        Record Name.................VINI
        Flag Field..................XXPS
        Hardware Location Code......U78AB.001.WZSG1PW-E1
        Customer Card ID Number.....2B46
        Serial Number...............YL11208A0445
        Part Number.................74Y5985
        FRU Number.................. 74Y5985
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-E1

      A IBM AC PS     :
        Record Name.................VINI
        Flag Field..................XXPS
        Hardware Location Code......U78AB.001.WZSG1PW-E2
        Customer Card ID Number.....2B46
        Serial Number...............YL11208F0029
        Part Number.................74Y5985
        FRU Number.................. 74Y5985
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-E2

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A1
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A1

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A2
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A2

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A3
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A3

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A4
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A4

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A5
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A5

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A6
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A6

      IBM Air Mover   :
        Record Name.................VINI
        Flag Field..................XXAM
        Hardware Location Code......U78AB.001.WZSG1PW-A7
        Customer Card ID Number.....6B1E
        FRU Number.................. 74Y5222
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-A7

      PSBPD6E4A  3GSAS:
        Record Name.................VINI
        Flag Field..................XXDB
        Hardware Location Code......U78AB.001.WZSG1PW-P2
        Customer Card ID Number.....2D1F
        Serial Number...............YL10P0230020
        FRU Number.................. 74Y2021
        Part Number.................74Y2296
        CCIN Extender...............1
        Product Specific.(VZ).......01
        Product Specific.(B2).......50050760398270000000000000000100
        Version.....................RS6K
      Physical Location: U78AB.001.WZSG1PW-P2

      DASD BACKPLANE  :
        Record Name.................VINI
        Flag Field..................XXDB
        Hardware Location Code......U78AB.001.WZSG1PW-P3
        Customer Card ID Number.....2BD7
        Serial Number...............YL10P025906B
        CCIN Extender...............1
        Product Specific.(VZ).......02
        FRU Number..................74Y2023
        Part Number.................74Y2549
        Product Specific.(HE).......0001
        Product Specific.(CT).......40F50003
        Product Specific.(HW).......0001
        Product Specific.(B3).......000000000001
        Product Specific.(B4).......00
        Product Specific.(B7).......000000000000000000000000
        FRU Label...................P3
        Version.....................ipzSeries
      Physical Location: U78AB.001.WZSG1PW-P3

      System Firmware:
        Code Level, LID Keyword.....Phyp_1 16432014022880A00701
        Code Level, LID Keyword.....PFW 11272014022081CF0681
        Code Level, LID Keyword.....FSP_Ker 19122014061881E00100
        Code Level, LID Keyword.....FSP_Fil 19182014061881E00109
        Code Level, LID Keyword.....FipS_BU 19182014061881E00208
        Code Level, LID Keyword.....Phyp_2 16432014022885A00702
        Code Level, LID Keyword.....SPCN3 124620060531A0E00A11
        Code Level, LID Keyword.....SPCN1 183020070213A0E00D00
        Code Level, LID Keyword.....SPCN2 183420070213A0E00D20
        Microcode Image.............AL730_142 AL730_122 AL730_142
        Hardware Location Code......U8231.E2B.1035C9P-Y1
      Physical Location: U8231.E2B.1035C9P-Y1

  Name:  openprom
    Model:  IBM,AL730_142
    Node:  openprom

  Name:  interrupt-controller
    Model:  IBM, Logical PowerPC-PIC, 00
    Node:  interrupt-controller@0
    Device Type:  PowerPC-External-Interrupt-Presentation

  Name:  vty
    Node:  vty@30000000
    Device Type:  serial
    Physical Location: U8231.E2B.1035C9P-V2-C0

  Name:  l-lan
    Node:  l-lan@30000002
    Device Type:  network
    Physical Location: U8231.E2B.1035C9P-V2-C2-T1

  Name:  v-scsi
    Node:  v-scsi@30000003
    Device Type:  vscsi
    Physical Location: U8231.E2B.1035C9P-V2-C3-T1
```

#### pmcycles  

[pmcycles](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/p_commands/pmcycles.html) 用于测量处理器时钟速率。

```
$ pmcycles -m
CPU 0 runs at 3720 MHz
CPU 1 runs at 3720 MHz
CPU 2 runs at 3720 MHz
CPU 3 runs at 3720 MHz
CPU 4 runs at 3720 MHz
CPU 5 runs at 3720 MHz
CPU 6 runs at 3720 MHz
CPU 7 runs at 3720 MHz
CPU 8 runs at 3720 MHz
CPU 9 runs at 3720 MHz
CPU 10 runs at 3720 MHz
CPU 11 runs at 3720 MHz
CPU 12 runs at 3720 MHz
CPU 13 runs at 3720 MHz
CPU 14 runs at 3720 MHz
CPU 15 runs at 3720 MHz
CPU 16 runs at 3720 MHz
CPU 17 runs at 3720 MHz
CPU 18 runs at 3720 MHz
CPU 19 runs at 3720 MHz
CPU 20 runs at 3720 MHz
CPU 21 runs at 3720 MHz
CPU 22 runs at 3720 MHz
CPU 23 runs at 3720 MHz
CPU 24 runs at 3720 MHz
CPU 25 runs at 3720 MHz
CPU 26 runs at 3720 MHz
CPU 27 runs at 3720 MHz
CPU 28 runs at 3720 MHz
CPU 29 runs at 3720 MHz
CPU 30 runs at 3720 MHz
CPU 31 runs at 3720 MHz
```

#### prtconf  

[prtconf](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/p_commands/prtconf.html) 显示系统配置信息。

```
$ prtconf
System Model: IBM,8231-E2B
Machine Serial Number: 1035C9P
Processor Type: PowerPC_POWER7
Processor Implementation Mode: POWER 7
Processor Version: PV_7_Compat
Number Of Processors: 8
Processor Clock Speed: 3720 MHz
CPU Type: 64-bit
Kernel Type: 64-bit
LPAR Info: 2 actaixtest
Memory Size: 65536 MB
Good Memory Size: 65536 MB
Platform Firmware level: AL730_142
Firmware Version: IBM,AL730_142
Console Login: enable
Auto Restart: true
Full Core: false

Network Information
        Host Name: actaixtest.unx.mryqu.com
        IP Address: 10.12.8.4
        Sub Netmask: 255.255.0.0
        Gateway: 10.12.0.1
        Name Server: 10.16.149.6
        Domain Name: unx.mryqu.com

Paging Space Information
        Total Paging Space: 8192MB
        Percent Used: 1%

Volume Groups Information
==============================================================================
Active VGs
==============================================================================
rootvg:
PV_NAME           PV STATE          TOTAL PPs   FREE PPs    FREE DISTRIBUTION
hdisk0            active            399         3           00..00..00..00..03
==============================================================================

INSTALLED RESOURCE LIST

The following resources are installed on the machine.
+/- = Added or deleted from Resource List.
*   = Diagnostic support not available.

  Model Architecture: chrp
  Model Implementation: Multiple Processor, PCI bus

+ sys0                                                           System Object
+ sysplanar0                                                     System Planar
* vio0                                                           Virtual I/O Bus
* vscsi0           U8231.E2B.1035C9P-V2-C3-T1                    Virtual SCSI Client Adapter
* hdisk0           U8231.E2B.1035C9P-V2-C3-T1-L8100000000000000  Virtual SCSI Solid State Drive
* ent0             U8231.E2B.1035C9P-V2-C2-T1                    Virtual I/O Ethernet Adapter (l-lan)
* vsa0             U8231.E2B.1035C9P-V2-C0                       LPAR Virtual Serial Adapter
* vty0             U8231.E2B.1035C9P-V2-C0-L0                    Asynchronous Terminal
+ L2cache0                                                       L2 Cache
+ mem0                                                           Memory
+ proc0                                                          Processor
+ proc4                                                          Processor
+ proc8                                                          Processor
+ proc12                                                         Processor
+ proc16                                                         Processor
+ proc20                                                         Processor
+ proc24                                                         Processor
+ proc28                                                         Processor
$
$
$ prtconf -m
Memory Size: 65536 MB
```

#### smtctl

[smtctl](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/s_commands/smtctl.html) 控制超线程模式。

```
$ smtctl
ksh: smtctl: cannot execute
```

#### svmon  

[svmon](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/s_commands/svmon.html) 用于捕获和分析虚拟内存快照，单位为4KBytes。

```
$ svmon -G
               size       inuse        free         pin     virtual   mmode
memory     16777216     4348117        4012     2010939     3833999    Shar
pg space    2097152       10746

               work        pers        clnt       other
pin         1455116           0        2108      553715
in use      3833999           0      514118
``` 

#### vmstat  

[vmstat](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/v_commands/vmstat.html) 报告虚拟内存统计信息。

```
$ vmstat

System configuration: lcpu=32 mem=65536MB ent=0.80 mmode=shared mpsz=50.00GB

kthr    memory              page              faults              cpu
----- ----------- ------------------------ ------------ -----------------------
 r  b   avm   fre  re  pi  po  fr   sr  cy  in   sy  cs us sy id wa    pc    ec
 2  1 3834027  4282   0   0   0   4    8   0  27 1496 1094  0  0 99  0  0.00   0.6
```

#### 获取cpu参数  

```
sysInfo_NumPhysicalCPUs=$(lparstat -i | grep -q "Maximum Physical CPUs in system" | cut -d: -f2)
sysInfo_NumVirtualCPUs=$(lparstat -i | grep -q "Maximum Virtual CPUs" | cut -d: -f2)

if [ -z "$sysInfo_NumVirtualCPUs" ]; then
  sysInfo_NumVirtualCPUs=$(prtconf | grep "Number Of Processors:" | cut -d: -f2)
fi

sysInfo_NumLogicalCPUs=$(pmcycles -m | wc -l)
```

#### 获取内存参数 

```
meminfo=($(svmon -G | grep "memory"))
if [ ${#meminfo[@]} -ge 4 ]; then
  sysInfo_SystemMemory="$(( meminfo[1] / 256 )) MB"
  sysInfo_FreeMemory="$(( meminfo[3] / 256 )) MB"
fi
``` 

### 软件差异  

#### sed不支持\s  

解决方法：使用空格和Tab代替。  

#### find不支持maxdepth

解决方法：通过find {dir} ! -path {dir} -prune -type f -name {filemask}不进行递归遍历。  
```
$ find . -name "*.ksh"
./codecheck.ksh
./inventory.ksh
./lib/logging.ksh
./lib/utility.ksh
./lib/validation.ksh
./lib/versioninfo.ksh
./profile.ksh
./publish.ksh
$ find . ! -path . -prune -type f -name "*.ksh"
./codecheck.ksh
./inventory.ksh
./profile.ksh
./publish.ksh
```

#### tr在utf8环境有问题

解决办法：不适用tr进行字符串的大小写转换，改用typeset
```
$ export LANG=en_US.UTF-8
$ export LC_ALL=en_US.UTF-8
$ val=$(echo dbcs | tr '[a-z]' '[A-Z]');if [ "$val" != "DBCS" ]; then echo "$val"; fi
ⅾBⅽS
$ typeset -u val="dbcs";if [ "$val" != "DBCS" ]; then echo "$val"; fi

```
#### date跟Linux上的GNU date功能较少

* 缺少-d参数，无法通过时间字符串进行操作，仅能对当前时间进行操作；  
* 缺少-r参数，无法查看文件的修改时间；  

GNU date使用：  
```
mryquLAX> date -u -d @0
Thu Jan  1 00:00:00 UTC 1970
mryquLAX> date -u -d "Thu Jan  1 00:00:00 UTC 1970" "+%s"
0
mryquLAX> date -u -d "Jan  1 00:00:00 UTC 0001" "+%s"
-62135596800
mryquLAX> date -r codecheck.ksh
Tue Jan  5 02:16:01 EST 2021
mryquLAX> date -r codecheck.ksh "+%s"
1609830961
```