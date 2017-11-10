#!/usr/bin/env bash

ZOOKEEPER_CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT:-2181}
echo mntr | nc localhost $ZOOKEEPER_CLIENT_PORT >& 1
