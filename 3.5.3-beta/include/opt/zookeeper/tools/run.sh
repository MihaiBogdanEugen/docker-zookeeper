#!/usr/bin/env bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

echo "===> ENV Variables ..."
env | sort

echo "===> User"
id

echo "===> Configuring ..."
/opt/zookeeper/tools/configure.sh

echo "===> Launching ... "
exec /opt/zookeeper/tools/launch.sh