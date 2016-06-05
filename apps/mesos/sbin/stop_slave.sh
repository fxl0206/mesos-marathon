PROCESS_NAME="./mesos-slave"

CUR_USER=`whoami`
ps -ef | grep ${PROCESS_NAME} | grep ${CUR_USER} | grep -v grep | awk '{print $2}' | while read pid
do
        kill ${pid} 2>&1 >/dev/null
        echo "success stop mesos-slave pid:${pid}"
done
