p3 Manual

1. Copy all the jar files in the p3 folder to the directory ~/hadoop/hadoop-*.*.*/share/hadoop/mapreduce/

2. Restart YARN

3. Run MapReduce jobs use the manual available on the site: https://sites.google.com/a/networks.cnu.ac.kr/yhlee/p3/manual \
For example, to compute total byte count/packet count of all packets grouped by key (e.g. packet count per each source IP address), you can submit a job using the command

hadoop jar p3.jar p3.runner.PcapCountUp -r [source file/directory]  -d [destination directory] -k [fieldname]  -b [begin date] -e [end date] 




