./mesos-master --ip=60.3.22.12 --zk=zk://60.3.22.12:2181/mesos --work_dir=/var/lib/mesos --quorum=1 2>&1 | ./cronolog -k 5 ../logs/mesos-master-server-%Y%m%d.log &
