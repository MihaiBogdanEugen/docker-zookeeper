#!/usr/bin/env bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

export ZOOKEEPER_TICK_TIME=${ZOOKEEPER_TICK_TIME:-"2000"}                     
export ZOOKEEPER_MIN_SESSION_TIMEOUT=${ZOOKEEPER_MIN_SESSION_TIMEOUT:-"4000"}
export ZOOKEEPER_MAX_SESSION_TIMEOUT=${ZOOKEEPER_MAX_SESSION_TIMEOUT:-"40000"}
export ZOOKEEPER_HEAP_SIZE=${ZOOKEEPER_HEAP_SIZE:-"2G"}

# myid is required for clusters
if [[ -n "${ZOOKEEPER_SERVERS-}" ]]
then
  dub ensure ZOOKEEPER_SERVER_ID
  export ZOOKEEPER_INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-"10"}
  export ZOOKEEPER_SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-"5"}
fi

if [[ -n "${ZOOKEEPER_SERVER_ID-}" ]]
then
  dub template "/opt/zookeeper/tools/templates/myid.template" "/var/lib/zookeeper/data/myid"
fi

if [[ -n "${KAFKA_JMX_OPTS-}" ]]
then
  if [[ ! $KAFKA_JMX_OPTS == *"com.sun.management.jmxremote.rmi.port"*  ]]
  then
    echo "KAFKA_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property. It is required for accessing the JMX metrics externally."
  fi
fi

echo "===> Writing java.env ..."
dub template "/opt/zookeeper/tools/templates/java.env.template" "/opt/zookeeper/conf/java.env"

echo "===> Writing log4j.properties ..."
dub template "/opt/zookeeper/tools/templates/log4j.properties.template" "/opt/zookeeper/conf/log4j.properties"

echo "===> Writing tools-log4j.properties..."
dub template "/opt/zookeeper/tools/templates/tools-log4j.properties.template" "/opt/zookeeper/conf/tools-log4j.properties"

echo "===> Writing zoo.cfg ..."
dub template "/opt/zookeeper/tools/templates/zoo.cfg.template" "/opt/zookeeper/conf/zoo.cfg"

echo "===> Check if $ZOOKEEPER_DATA_DIR is writable ..."
dub path $ZOOKEEPER_DATA_DIR writable

echo "===> Check if $ZOOKEEPER_DATA_LOG_DIR is writable ..."
dub path $ZOOKEEPER_DATA_LOG_DIR writable