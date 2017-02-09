#!/bin/bash
if [ -z $ZK_ID ]; then
    echo "zookeeper id is not set"
else
    echo -e "zookeeper id create: #$ZK_ID\n"
    echo $ZK_ID > /tmp/zookeeper/myid

    echo -e "zookeeper server start: #$ZK_ID\n"
    zkServer.sh start
fi
