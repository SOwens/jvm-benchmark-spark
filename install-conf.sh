#!/bin/bash

#ln -sf ../../../conf/core-site.xml hadoop-2.6.0/etc/hadoop/core-site.xml
#ln -sf ../../../conf/hdfs-site.xml hadoop-2.6.0/etc/hadoop/hdfs-site.xml
#ln -sf ../../../conf/mapred-site.xml hadoop-2.6.0/etc/hadoop/mapred-site.xml
#ln -sf ../../../conf/hadoop-env.sh hadoop-2.6.0/etc/hadoop/hadoop-env.sh

ln -sf ../../conf/spark-defaults.conf spark-1.4.1-bin-hadoop2.6/conf/spark-defaults.conf 
ln -sf ../../conf/spark-env.sh spark-1.4.1-bin-hadoop2.6/conf/spark-env.sh
ln -sf ../../conf/log4j.properties spark-1.4.1-bin-hadoop2.6/conf/log4j.properties

