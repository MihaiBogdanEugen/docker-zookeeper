#!/usr/bin/env bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

export ZOOKEEPER_CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT:-"2181"}
export ZOOKEEPER_TICK_TIME=${ZOOKEEPER_TICK_TIME:-"2000"}                     
export ZOOKEEPER_MIN_SESSION_TIMEOUT=${ZOOKEEPER_MIN_SESSION_TIMEOUT:-"4000"}
export ZOOKEEPER_MAX_SESSION_TIMEOUT=${ZOOKEEPER_MAX_SESSION_TIMEOUT:-"40000"}
export JVM_HEAP_SIZE=${JVM_HEAP_SIZE:-"2G"}

# myid is required for clusters
if [[ -n "${ZOOKEEPER_SERVERS-}" ]]
then
  if [[ -n "${IS_KUBERNETES-}" ]]
  then
    echo "Kubernetes setup"
  else
    dub ensure ZOOKEEPER_SERVER_ID
  fi  
  export ZOOKEEPER_INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-"10"}
  export ZOOKEEPER_SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-"5"}
fi

if [[ -n "${ZOOKEEPER_SERVER_ID-}" ]] || [[ -n "${IS_KUBERNETES-}" ]]
then
  dub template "/opt/zookeeper/tools/templates/myid.template" "/var/lib/zookeeper/data/myid"
fi

echo "===> Writing java.env ..."
dub template "/opt/zookeeper/tools/templates/java.env.template" "/opt/zookeeper/conf/java.env"

echo "===> Writing log4j.properties ..."
dub template "/opt/zookeeper/tools/templates/log4j.properties.template" "/opt/zookeeper/conf/log4j.properties"

echo "===> Writing zoo.cfg ..."
dub template "/opt/zookeeper/tools/templates/zoo.cfg.template" "/opt/zookeeper/conf/zoo.cfg"

echo "===> Check if $ZOOKEEPER_DATA_DIR is writable ..."
dub path $ZOOKEEPER_DATA_DIR writable

echo "===> Check if $ZOOKEEPER_DATA_LOG_DIR is writable ..."
dub path $ZOOKEEPER_DATA_LOG_DIR writable