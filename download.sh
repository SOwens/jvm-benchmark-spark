#!/bin/bash

if [ ! -e src ]; then
    mkdir src
fi

pushd src
if [ ! -e spark-1.4.1-bin-hadoop2.6.tgz ]; then
    # http://spark.apache.org/downloads.html
    wget 'http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-hadoop2.6.tgz' || exit 1
fi
if [ ! -e apache-maven-3.3.3-bin.tar.gz ]; then
    # https://maven.apache.org/download.cgi
    wget 'http://mirror.ox.ac.uk/sites/rsync.apache.org/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz' || exit 1
fi
if [ ! -e sbt-0.13.9.tgz ]; then
    # http://www.scala-sbt.org/download.html
    wget 'https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz' || exit 1
fi
if [ ! -e scala-2.10.4.tgz ]; then
    # http://www.scala-lang.org/download/2.10.4.html
    wget 'http://www.scala-lang.org/files/archive/scala-2.10.4.tgz' || exit 1
fi
if [ ! -e soc-LiveJournal1.txt.gz ]; then
    # http://snap.stanford.edu/data/soc-LiveJournal1.html
    wget 'http://snap.stanford.edu/data/soc-LiveJournal1.txt.gz' || exit 1
fi
popd
