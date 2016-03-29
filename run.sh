#!/bin/bash

RUNS=$1
PARTITIONS=16

spark-submit --class "BenchPageRank" --master "local[*]" bench/target/scala-2.10/benchmark-page-rank_2.10-1.0.jar data/soc-lj-20m.txt $PARTITIONS $RUNS
