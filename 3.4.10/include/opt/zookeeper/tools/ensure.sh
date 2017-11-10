#!/usr/bin/env bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

dub ensure ZOOKEEPER_DATA_DIR

echo "===> Check if $ZOOKEEPER_DATA_DIR is writable ..."
dub path $ZOOKEEPER_DATA_DIR writable

dub ensure ZOOKEEPER_DATA_LOG_DIR

echo "===> Check if $ZOOKEEPER_DATA_LOG_DIR is writable ..."
dub path $ZOOKEEPER_DATA_LOG_DIR writable
