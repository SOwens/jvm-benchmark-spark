#!/bin/bash

if [ ! -e scala-2.10.4 ]; then
    tar xzvf src/scala-2.10.4.tgz || exit 1
fi

if [ ! -e sbt ]; then
    tar xzvf src/sbt-0.13.9.tgz || exit 1
fi

if [ ! -e apache-maven-3.3.3 ]; then
    tar xzvf apache-maven-3.3.3-bin.tar.gz || exit 1 
fi

if [ ! -e spark-1.4.1-bin-hadoop2.6 ]; then
    tar xzvf src/spark-1.4.1-bin-hadoop2.6.tgz || exit 1
fi

if [ ! -e data ]; then
    mkdir data
    zcat src/soc-LiveJournal1.txt.gz | head -n 20000000 > data/soc-lj-20m.txt
fi

source env.sh
pushd bench
sbt package
popd

#ln -sf ../../../conf/core-site.xml hadoop-2.6.0/etc/hadoop/core-site.xml
#ln -sf ../../../conf/hdfs-site.xml hadoop-2.6.0/etc/hadoop/hdfs-site.xml
#ln -sf ../../../conf/mapred-site.xml hadoop-2.6.0/etc/hadoop/mapred-site.xml
#ln -sf ../../../conf/hadoop-env.sh hadoop-2.6.0/etc/hadoop/hadoop-env.sh

ln -sf ../../conf/spark-defaults.conf spark-1.4.1-bin-hadoop2.6/conf/spark-defaults.conf 
ln -sf ../../conf/spark-env.sh spark-1.4.1-bin-hadoop2.6/conf/spark-env.sh
ln -sf ../../conf/log4j.properties spark-1.4.1-bin-hadoop2.6/conf/log4j.properties

