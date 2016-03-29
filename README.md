## JVM Benchmark Based on Apache Spark MapReduce Engine

This setup is designed to replicate the Spark benchmark used in the paper [Benchmarking Weak Memory Models] (https://kar.kent.ac.uk/51638/).

This runs Apache Spark GraphX PageRank on 20 million lines of the [SNAP LiveJournal dataset] (http://snap.stanford.edu/data/soc-LiveJournal1.html).
It was inspired by a similar benchmark described by Lokesh Gidra et al in their paper on [NumaGiC] (http://dl.acm.org/citation.cfm?id=2694361).

### Requirements

* Java 7+ (e.g. OpenJDK 1.7 or 1.8)

Generally `sudo apt-get install openjdk-7-jdk` should be sufficient on Ubuntu.

### Setup

1. Update BENCH_ROOT and JAVA_HOME in env.sh
2. Download sources (around 500MiB of data), run ./download.sh
3. Unpack the sources, run ./unpack.sh

### Usage

    source env.sh
    ./run.sh <number-of-runs>

### Tuning

This benchmark is tuned for systems with around 8 cores and 16 GiB of RAM.

Memory usage can be adjusted by changing `SPARK_WORKER_MEMORY` in `conf/spark-env.sh`, and `spark.driver.memory` and `spark.executor.memory` in `conf/spark-defaults.conf`.
For increased memory usage the input dataset (in the data directory) should be increased, i.e. use more lines from `src/soc-LiveJournal1.txt.gz`.

Concurrency can be adjusted by changing `spark.akka.threads` in `conf/spark-defaults.conf`.
For increased concurrency you should also increase the input data set size and potentially adjust the number of partitions in the `run.sh` (default 16).





