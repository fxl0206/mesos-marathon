./mesos-slave --master=zk://60.3.22.12:2181/mesos --containerizers=docker,mesos --ip=60.3.22.12 --hostname=60.3.22.12 2>&1 | ./cronolog -k 5 ../logs/mesos-slave-server-%Y%m%d.log &
