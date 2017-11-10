#!/usr/bin/env bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

dub ensure ZOOKEEPER_CLIENT_PORT

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

export ZOOKEEPER_HEAP_SIZE=${ZOOKEEPER_HEAP_SIZE:-2G}

dub template "/opt/zookeeper/tools/templates/java.env.template" "/opt/zookeeper/conf/java.env"
dub template "/opt/zookeeper/tools/templates/log4j.properties.template" "/opt/zookeeper/conf/log4j.properties"
dub template "/opt/zookeeper/tools/templates/tools-log4j.properties.template" "/opt/zookeeper/conf/tools-log4j.properties"
dub template "/opt/zookeeper/tools/templates/zookeeper.properties.template" "/opt/zookeeper/conf/zoo.cfg"
