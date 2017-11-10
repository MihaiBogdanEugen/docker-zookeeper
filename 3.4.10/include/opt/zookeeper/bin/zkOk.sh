#!/usr/bin/env bash

ZOOKEEPER_CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT:-2181}
OK=$(echo ruok | nc 127.0.0.1 $ZOOKEEPER_CLIENT_PORT)
if [ "$OK" == "imok" ]; then
	exit 0
else
	exit 1
fi