./bin/start --master zk://60.3.22.12:2181/mesos --zk zk://60.3.22.12:2181/marathon 2>&1 | ./cronolog -k 5 $HOME/logs/marathon-server-%Y%m%d.log &
