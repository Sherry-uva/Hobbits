
#The script takes one argument, which is the input pcap
#it splits the pcap file into 128 KB, and load the pcap splits
#into HDFS

input.pcap=$1

#split
tcpdump -r input.pcap -w output.pcap -C 128

#load
hdfs dfs -put output.pcap* /input
