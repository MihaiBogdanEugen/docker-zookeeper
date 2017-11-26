#!/usr/bin/env bash

if [[ -n "${ZOOKEEPER_SERVER_ID-}" ]]
then
  echo "===> Printing ${ZOOKEEPER_DATA_DIR}/myid "
  cat ${ZOOKEEPER_DATA_DIR}/myid
fi

echo "===> Launching zookeeper ... "
exec zkServer.sh start-foreground
