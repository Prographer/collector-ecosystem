#!/bin/bash
if [ -z $KAFKA_BROKER_ID ]; then
    echo "broker id is not set"
else
    echo -e "broker id create: #$KAFKA_BROKER_ID\n"
    echo $KAFKA_BROKER_ID > /tmp/zookeeper/myid
    cat /usr/local/kafka/config/server.properties.template | sed \
    -e "s|{{KAFKA_BROKER_ID}}|${KAFKA_BROKER_ID:-0}|g" \
    -e "s|{{KAFKA_ADVERTISED_HOST_NAME}}|${KAFKA_ADVERTISED_HOST_NAME:-$IP}|g" > /usr/local/kafka/config/server.properties

    if [[ $RUN_ZK == "true" ]]; then
        echo -e "zookeeper server start: #$KAFKA_BROKER_ID\n"
        zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
    fi
    echo -e "kafka server start: #$KAFKA_BROKER_ID\n"
    kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
fi
