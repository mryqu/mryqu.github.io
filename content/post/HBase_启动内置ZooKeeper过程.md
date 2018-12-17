---
title: '[HBase] 启动内置ZooKeeper过程'
date: 2015-02-24 07:00:09
categories: 
- Hadoop/Spark
- HBase
tags: 
- hbase
- zookeeper
- hbase_manages_zk
- start
- process
---
- `start-hbase.sh`
  - `hbase-daemons.sh start zookeeper`
    - `zookeepers.sh --hosts /usr/local/hbase/conf/regionservers--config /usr/local/hbase/conf cd /usr/local/hbase;/usr/local/hbase/bin/hbase-daemon.sh --config /usr/local/hbase/confstart zookeeper`
      检查配置HBASE_MANAGES_ZK，若不为true则终止处理。
      - `ssh node51054 cd /usr/local/hbase;/usr/local/hbase/bin/hbase-daemon.sh --config /usr/local/hbase/confstart zookeeper`
        - `hbase zookeeper start`
          - `java org.apache.hadoop.hbase.zookeeper.HQuorumPeer`