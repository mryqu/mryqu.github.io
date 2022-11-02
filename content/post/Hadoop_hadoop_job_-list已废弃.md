---
title: '[Hadoop] hadoop job -list已废弃'
date: 2013-10-20 22:04:34
categories: 
- BigData
tags: 
- hadoop
- job
- deprecated
- mapred
- yarn
---
执行hadoop job -list，显示该命令已废弃，不过还能执行成功。
```
~$ hadoop job -list
DEPRECATED: Use of this script to execute mapred command is deprecated.
Instead use the mapred command for it.
```

看一下Hadoop 2.2.0的代码[hadoop-common-project/hadoop-common/src/main/bin/hadoop](https://github.com/apache/hadoop/blob/branch-2.2.0/hadoop-common-project/hadoop-common/src/main/bin/hadoop)：
```
#hdfs commands
namenode|secondarynamenode|datanode|dfs|dfsadmin|fsck|balancer|fetchdt|oiv|dfsgroups|portmap|nfs3)
  echo "DEPRECATED: Use of this script to execute hdfs command is deprecated." 1>&2
  echo "Instead use the hdfs command for it." 1>&2
  echo "" 1>&2
  #try to locate hdfs and if present, delegate to it.  
  shift
  if [ -f "${HADOOP_HDFS_HOME}"/bin/hdfs ]; then
    exec "${HADOOP_HDFS_HOME}"/bin/hdfs ${COMMAND/dfsgroups/groups}  "$@"
  elif [ -f "${HADOOP_PREFIX}"/bin/hdfs ]; then
    exec "${HADOOP_PREFIX}"/bin/hdfs ${COMMAND/dfsgroups/groups} "$@"
  else
    echo "HADOOP_HDFS_HOME not found!"
    exit 1
  fi
  ;;

#mapred commands for backwards compatibility
pipes|job|queue|mrgroups|mradmin|jobtracker|tasktracker)
  echo "DEPRECATED: Use of this script to execute mapred command is deprecated." 1>&2
  echo "Instead use the mapred command for it." 1>&2
  echo "" 1>&2
  #try to locate mapred and if present, delegate to it.
  shift
  if [ -f "${HADOOP_MAPRED_HOME}"/bin/mapred ]; then
    exec "${HADOOP_MAPRED_HOME}"/bin/mapred ${COMMAND/mrgroups/groups} "$@"
  elif [ -f "${HADOOP_PREFIX}"/bin/mapred ]; then
    exec "${HADOOP_PREFIX}"/bin/mapred ${COMMAND/mrgroups/groups} "$@"
  else
    echo "HADOOP_MAPRED_HOME not found!"
    exit 1
  fi
  ;;
```

hadoop Shell命令下的命令列表已经分割成几块，划给其他Shell命令了：
- Hadoop通用：hadoop Shell命令
- HDFS相关：hdfs Shell命令
- MapReduce相关：mapred Shell命令
- YARN相关：yarn Shell命令