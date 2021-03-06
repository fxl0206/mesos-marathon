#!/usr/bin/env bash

prefix=/root/apps/mesos
DEPLOY_DIR=${prefix}/etc/mesos

# Pull in deploy specific options.
test -e ${DEPLOY_DIR}/mesos-deploy-env.sh && \
  . ${DEPLOY_DIR}/mesos-deploy-env.sh

# Find the list of slaves.
SLAVES_FILE="${DEPLOY_DIR}/slaves"
if test ! -e ${SLAVES_FILE}; then
  echo "Failed to find ${SLAVES_FILE}"
  exit 1
fi

# The expected format of the SLAVES_FILE is one IP/host per line.
# Additionally, you can temporarily comment out a host or IP by placing a hash
# character '#' as the first character of the line.  As an example, changing
# this MASTERS_FILE:
#
# 10.1.1.1
# 10.1.1.2
#
# to this one:
#
# 10.1.1.1
# #10.1.1.2
#
# removes the 10.1.1.2 IP address from being used.  Note that this does NOT
# support comments through the end of line, like this:
#
# 10.1.1.1  # my first IP
# 10.1.1.2  # my second IP
#
SLAVES=`cat ${SLAVES_FILE} | grep -v '^#'`

killall="killall"

# Add sudo if requested.
if test "x${DEPLOY_WITH_SUDO}" = "x1"; then
  killall="sudo ${killall}"
fi

for slave in ${SLAVES}; do
  echo "Stopping mesos-slave on ${slave}"
  ssh ${SSH_OPTS} ${slave} "${killall} mesos-slave" &
  sleep 0.1
done

wait # Wait for all the ssh's to finish.
