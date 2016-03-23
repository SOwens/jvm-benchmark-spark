/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// scalastyle:off println
//package org.apache.spark.examples.graphx

import scala.collection.mutable
import org.apache.spark._
import org.apache.spark.storage.StorageLevel
import org.apache.spark.graphx._
import org.apache.spark.graphx.lib._
import org.apache.spark.graphx.PartitionStrategy._

/**
 * Driver program for running graph algorithms.
 */
object BenchPageRank extends Logging {

  def main(args: Array[String]): Unit = {
    if (args.length < 3) {
      System.err.println(
        "Usage: BenchPageRank <file> <num_edge_partitions> <runs> [<options>]")
      System.exit(1)
    }

    val fname = args(0)
    val numEPart = args(1).toInt
    var numRuns = args(2).toInt
    val optionsList = args.drop(3).map { arg =>
        arg.dropWhile(_ == '-').split('=') match {
            case Array(opt, v) => (opt -> v)
            case _ => throw new IllegalArgumentException("Invalid argument: " + arg)
        }
    }
    val options = mutable.Map(optionsList: _*)
    
    val conf = new SparkConf().setAppName("BenchPageRank")
    GraphXUtils.registerKryoClasses(conf)
    
    val partitionStrategy: Option[PartitionStrategy] = options.remove("partStrategy")
        .map(PartitionStrategy.fromString(_))
    val edgeStorageLevel = options.remove("edgeStorageLevel")
        .map(StorageLevel.fromString(_)).getOrElse(StorageLevel.MEMORY_ONLY)
    val vertexStorageLevel = options.remove("vertexStorageLevel")
        .map(StorageLevel.fromString(_)).getOrElse(StorageLevel.MEMORY_ONLY)

    val tol = 0.001F
    //val outFname = options.remove("output").getOrElse("")
    //val numIterOpt = options.remove("numIter").map(_.toInt)

    var i = 0
    for (i <- 1 to numRuns) {
        System.gc()
        
        println("--- Benchmark PageRank ---")
        println("begin %d/%d".format(i, numRuns))
        val st = System.nanoTime
        val sc = new SparkContext(conf.setAppName("PageRank(" + fname + ")"))

        val unpartitionedGraph = GraphLoader.edgeListFile(sc, fname,
          numEdgePartitions = numEPart,
          edgeStorageLevel = edgeStorageLevel,
          vertexStorageLevel = vertexStorageLevel).cache()
        val graph = partitionStrategy.foldLeft(unpartitionedGraph)(_.partitionBy(_))

        println("GRAPHX: Number of vertices " + graph.vertices.count)
        println("GRAPHX: Number of edges " + graph.edges.count)

        val pr = PageRank.runUntilConvergence(graph, tol).vertices.cache()

        println("GRAPHX: Total rank: " + pr.map(_._2).reduce(_ + _))
        val et = System.nanoTime
        println("end %d/%d".format(i, numRuns))
        println("run %d, elapsed = %d us".format(i, (et - st) / 1000))
        println("---")

        /*
        if (!outFname.isEmpty) {
          logWarning("Saving pageranks of pages to " + outFname)
          pr.map { case (id, r) => id + "\t" + r }.saveAsTextFile(outFname)
        }
        */

        sc.stop()
    }
  }
}
// scalastyle:on println
