#!/bin/bash

if [ "$JAVA_HOME" == "" ]; then
	export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
fi
export BENCH_ROOT=$HOME/spark

export MAVEN_ROOT=$BENCH_ROOT/apache-maven-3.3.3
export MAVEN_HOME=$MAVEN_ROOT

#export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true
#export HADOOP_ROOT=$BENCH_ROOT/hadoop-2.6.0
#export HADOOP_HOME=$HADOOP_ROOT

export SPARK_ROOT=$BENCH_ROOT/spark-1.4.1-bin-hadoop2.6
export SPARK_HOME=$SPARK_ROOT
#export SPARK_LOCAL_IP=127.0.0.1
#export SPARK_MASTER_IP=127.0.0.1

export SCALA_ROOT=$BENCH_ROOT/scala-2.10.4
export SCALA_HOME=$SCALA_ROOT

export SBT_ROOT=$BENCH_ROOT/sbt
export SBT_HOME=$SBT_ROOT

export PATH=$MAVEN_HOME/bin:$HADOOP_HOME/bin:$SPARK_HOME/bin:$SCALA_HOME/bin:$SBT_HOME/bin:$PATH
