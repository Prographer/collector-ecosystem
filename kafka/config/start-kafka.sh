#!/bin/bash
if [ -z $KAFKA_BROKER_ID ]; then
    echo "broker id is not set"
else
    echo -e "broker id create: #$KAFKA_BROKER_ID\n"
    echo $KAFKA_BROKER_ID > /tmp/zookeeper/myid
    sed -i 's/{{KAFKA_BROKER_ID}}/'"$KAFKA_BROKER_ID"'/g' /usr/local/kafka/config/server.properties

    echo -e "zookeeper server start: #$KAFKA_BROKER_ID\n"
    zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties

    echo -e "kafka server start: #$KAFKA_BROKER_ID\n"
    kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
fi
