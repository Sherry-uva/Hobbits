Hadoop-pcap Manual

**Limitations**

This SerDe currently only supports deserialization of PCAPs. We use HiveIgnoreKeyTextOutputFormat to disable serialization in the OUTPUTFORMAT paramters below.


1.Dowanload the hadoop-pcap library
hadoop-pcap-serde-1.1-jar-with-dependencies.jar


2.Add the library in Hive
hive> ADD JAR /<absolute path>/hadoop-pcap-serde-1.1-jar-with-dependencies.jar

We could also add this command into hive config file to execute it defaultly
hive config file: ~/hive/conf/.hiverc


3.Create an external table to read pcap file through the deserializer of hadoop-pcap

hive> CREATE EXTERNAL TABLE pcaps_ext \
      (ts bigint, ts_usec double, protocol string, src string, src_port int, dst string, dst_port int, len int, ttl int) \
      ROW FORMAT SERDE 'net.ripe.hadoop.pcap.serde.PcapDeserializer' \
      STORED AS INPUTFORMAT 'net.ripe.hadoop.pcap.io.PcapInputFormat' \
      OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' \
      LOCATION 'hdfs:///input';


4.Create internal tables using the external table

hive> CREATE TABLE pcaps_orc STORED AS ORC AS SELECT * FROM pcaps_ext; \
hive> CREATE TABLE pcaps_txt STORED AS TEXTFILE AS SELECT * FROM pcaps_ext;

The mapreduce job-ID will be printed when creating internal table.\
We could use it to get the execution information from below

/tmp/hadoop-yarn/staging/history/done_intermediate/hadoop/<jobID>.summary

The output files converted from pcap file will be stored in the HDFS warehouse folder.\
We could check their total size and compare with input files.

hive> dfs -du -s -h /user/hive/warehouse/<internal table name>


