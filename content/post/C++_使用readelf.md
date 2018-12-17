---
title: '[C++] 使用readelf'
date: 2015-12-08 06:06:31
categories: 
- Tool
- C++
tags: 
- readelf
- cpp
- gcc
---
在计算机科学中，[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)文件（Executableand LinkableFormat）是一种用于二进制文件、可执行文件、目标代码、共享库和核心转储格式文件，是UNIX系统实验室（USL）作为应用程序二进制接口（ApplicationBinaryInterface，ABI）而开发和发布的，也是Linux的主要可执行文件格式。1999年，被86open项目选为x86架构上的类Unix操作系统的二进制文件标准格式，用来取代COFF。因其可扩展性与灵活性，也可应用在其它处理器、计算机系统架构的操作系统上。
ELF文件由4部分组成，分别是ELF头（ELF header）、程序头表（Program headertable）、节（Section）和节头表（Section headertable）。实际上，一个文件中不一定包含全部内容，而且他们的位置也未必如同所示这样安排，只有ELF头的位置是固定的，其余各部分的位置、大小等信息由ELF头中的各项值来决定。
而[readelf](https://linux.die.net/man/1/readelf)用于显示[ELF](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)文件的信息。
![[C++] 使用readelf](/images/2015/12/0026uWfMzy79UpY8B8m7a.png)

```
Usage: readelf <option(s)> elf-file(s)
 Display information about the contents of ELF format files
 Options are:
  -a --all               全部 Equivalent to: -h -l -S -s -r -d -V -A -I
  -h --file-header       ELF头 Display the ELF file header
  -l --program-headers   程序头表 Display the program headers
     --segments          An alias for --program-headers
  -S --section-headers   节头 Display the sections' header
     --sections          An alias for --section-headers
  -g --section-groups    节组 Display the section groups
  -t --section-details   节细节 Display the section details
  -e --headers           全部头 Equivalent to: -h -l -S
  -s --syms              符号表 Display the symbol table
     --symbols           An alias for --syms
  --dyn-syms             动态符号表 Display the dynamic symbol table
  -n --notes             核心注释 Display the core notes (if present)
  -r --relocs            重定位 Display the relocations (if present)
  -u --unwind            Display the unwind info (if present)
  -d --dynamic           动态节 Display the dynamic section (if present)
  -V --version-info      版本节 Display the version sections (if present)
  -A --arch-specific     架构信息 Display architecture specific information (if any)
  -c --archive-index     该架构下符号/文件索引 Display the symbol/file index in an archive
  -D --use-dynamic       Use the dynamic section info when displaying symbols
  -x --hex-dump=<number|name>
                         Dump the contents of section <number|name> as bytes
  -p --string-dump=<number|name>
                         Dump the contents of section <number|name> as strings
  -R --relocated-dump=<number|name>
                         Dump the contents of section <number|name> as relocated bytes
  -w[lLiaprmfFsoRt] or
  --debug-dump[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,
               =frames-interp,=str,=loc,=Ranges,=pubtypes,
               =gdb_index,=trace_info,=trace_abbrev,=trace_aranges,
               =addr,=cu_index]
                         显示DWARF2调试节 Display the contents of DWARF2 debug sections
  --dwarf-depth=N        Do not display DIEs at depth N or greater
  --dwarf-start=N        Display DIEs starting with N, at the same depth
                         or deeper
  -I --histogram         柱状图 Display histogram of bucket list lengths
  -W --wide              输出宽度 Allow output width to exceed 80 characters
  @<file>                Read options from <file>
  -H --help              帮助 Display this information
  -v --version           版本 Display the version number of readelf
```

#### 练习 - 查看ELF文件头
```
hadoop@node51054:/usr/bin$ readelf -h curl
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x4023b1
  Start of program headers:          64 (bytes into file)
  Start of section headers:          152600 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         9
  Size of section headers:           64 (bytes)
  Number of section headers:         27
```

#### 练习 - 查看符号表
```
hadoop@node51054:/usr/bin$ readelf -s curl

Symbol table '.dynsym' contains 108 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __errno_location@GLIBC_2.2.5 (2)
     2: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_global_cleanup@CURL_OPENSSL_3 (3)
     3: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __strdup@GLIBC_2.2.5 (4)
     4: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strstr@GLIBC_2.2.5 (4)
     5: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strtoul@GLIBC_2.2.5 (4)
     6: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strerror@GLIBC_2.2.5 (4)
     7: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_getinfo@CURL_OPENSSL_3 (3)
     8: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strchr@GLIBC_2.2.5 (4)
     9: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strlen@GLIBC_2.2.5 (4)
    10: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND memcmp@GLIBC_2.2.5 (4)
    11: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND mkdir@GLIBC_2.2.5 (4)
    12: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strncpy@GLIBC_2.2.5 (4)
    13: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND utime@GLIBC_2.2.5 (4)
    14: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_slist_free_all@CURL_OPENSSL_3 (3)
    15: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND memset@GLIBC_2.2.5 (4)
    16: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_version_info@CURL_OPENSSL_3 (3)
    17: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fcntl@GLIBC_2.2.5 (2)
    18: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND geteuid@GLIBC_2.2.5 (4)
    19: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND calloc@GLIBC_2.2.5 (4)
    20: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND open@GLIBC_2.2.5 (2)
    21: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_mvsnprintf@CURL_OPENSSL_3 (3)
    22: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND localtime@GLIBC_2.2.5 (4)
    23: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_getenv@CURL_OPENSSL_3 (3)
    24: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_mvaprintf@CURL_OPENSSL_3 (3)
    25: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strtod@GLIBC_2.2.5 (4)
    26: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND inflate
    27: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_formfree@CURL_OPENSSL_3 (3)
    28: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND memcpy@GLIBC_2.14 (5)
    29: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND inflateInit2_
    30: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND setlocale@GLIBC_2.2.5 (4)
    31: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND clock_gettime@GLIBC_2.17 (6)
    32: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND time@GLIBC_2.2.5 (4)
    33: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strcpy@GLIBC_2.2.5 (4)
    34: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __isoc99_sscanf@GLIBC_2.7 (7)
    35: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fclose@GLIBC_2.2.5 (4)
    36: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __xstat@GLIBC_2.2.5 (4)
    37: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_mvfprintf@CURL_OPENSSL_3 (3)
    38: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND inflateEnd
    39: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fileno@GLIBC_2.2.5 (4)
    40: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __fxstat@GLIBC_2.2.5 (4)
    41: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_init@CURL_OPENSSL_3 (3)
    42: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __ctype_b_loc@GLIBC_2.3 (8)
    43: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strrchr@GLIBC_2.2.5 (4)
    44: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fseek@GLIBC_2.2.5 (4)
    45: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __stack_chk_fail@GLIBC_2.4 (9)
    46: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND tcgetattr@GLIBC_2.2.5 (4)
    47: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fputs@GLIBC_2.2.5 (4)
    48: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_strequal@CURL_OPENSSL_3 (3)
    49: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND getpwuid@GLIBC_2.2.5 (4)
    50: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _Jv_RegisterClasses
    51: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fflush@GLIBC_2.2.5 (4)
    52: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fopen@GLIBC_2.2.5 (4)
    53: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_getdate@CURL_OPENSSL_3 (3)
    54: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND signal@GLIBC_2.2.5 (4)
    55: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND free@GLIBC_2.2.5 (4)
    56: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND getenv@GLIBC_2.2.5 (4)
    57: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fputc@GLIBC_2.2.5 (4)
    58: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND tcsetattr@GLIBC_2.2.5 (4)
    59: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND malloc@GLIBC_2.2.5 (4)
    60: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_msnprintf@CURL_OPENSSL_3 (3)
    61: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND pipe@GLIBC_2.2.5 (4)
    62: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_version@CURL_OPENSSL_3 (3)
    63: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND ftruncate@GLIBC_2.2.5 (4)
    64: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __memset_chk@GLIBC_2.3.4 (10)
    65: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strcmp@GLIBC_2.2.5 (4)
    66: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strtol@GLIBC_2.2.5 (4)
    67: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_setopt@CURL_OPENSSL_3 (3)
    68: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_free@CURL_OPENSSL_3 (3)
    69: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND read@GLIBC_2.2.5 (2)
    70: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_strnequal@CURL_OPENSSL_3 (3)
    71: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_cleanup@CURL_OPENSSL_3 (3)
    72: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fread@GLIBC_2.2.5 (4)
    73: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND poll@GLIBC_2.2.5 (4)
    74: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_slist_append@CURL_OPENSSL_3 (3)
    75: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND puts@GLIBC_2.2.5 (4)
    76: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_perform@CURL_OPENSSL_3 (3)
    77: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND strtok@GLIBC_2.2.5 (4)
    78: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fgets@GLIBC_2.2.5 (4)
    79: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_maprintf@CURL_OPENSSL_3 (3)
    80: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_mprintf@CURL_OPENSSL_3 (3)
    81: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND gettimeofday@GLIBC_2.2.5 (4)
    82: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND memmove@GLIBC_2.2.5 (4)
    83: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND realloc@GLIBC_2.2.5 (4)
    84: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_formadd@CURL_OPENSSL_3 (3)
    85: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_pause@CURL_OPENSSL_3 (3)
    86: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND access@GLIBC_2.2.5 (4)
    87: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_strerror@CURL_OPENSSL_3 (3)
    88: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND isatty@GLIBC_2.2.5 (4)
    89: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_deregisterTMCloneTab
    90: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_mfprintf@CURL_OPENSSL_3 (3)
    91: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fsetxattr@GLIBC_2.3 (8)
    92: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND lseek@GLIBC_2.2.5 (2)
    93: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_main@GLIBC_2.2.5 (4)
    94: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
    95: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_registerTMCloneTable
    96: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_global_init@CURL_OPENSSL_3 (3)
    97: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND fwrite@GLIBC_2.2.5 (4)
    98: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND close@GLIBC_2.2.5 (2)
    99: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND curl_easy_escape@CURL_OPENSSL_3 (3)
   100: 0000000000625340     8 OBJECT  GLOBAL DEFAULT   25 stdout@GLIBC_2.2.5 (4)
   101: 0000000000625328     0 NOTYPE  GLOBAL DEFAULT   24 _edata
   102: 0000000000625450     0 NOTYPE  GLOBAL DEFAULT   25 _end
   103: 0000000000625348     8 OBJECT  GLOBAL DEFAULT   25 stdin@GLIBC_2.2.5 (4)
   104: 0000000000401cc8     0 FUNC    GLOBAL DEFAULT   11 _init
   105: 0000000000625350     8 OBJECT  GLOBAL DEFAULT   25 stderr@GLIBC_2.2.5 (4)
   106: 0000000000625328     0 NOTYPE  GLOBAL DEFAULT   25 __bss_start
   107: 000000000040f314     0 FUNC    GLOBAL DEFAULT   14 _fini
```
