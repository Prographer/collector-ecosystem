#!/bin/bash

# N is the node number of kafka cluster
N=$1
RUN_ZK = ${2:-true}
KAFKA_VERSION=0.10.11

if [ $# = 0 ]
then
	echo "Please enter the node number of kafka cluster"
	echo "[USAGE] run-kafka-cluster.sh node-number [true or false]"
	echo "[ex] run-kafka-cluster.sh 3 true"
	exit 1
fi

docker rm -f kafka-1 &> /dev/null
echo "start kafka-1 container..."
if [[ $RUN_ZK == "true" ]]; then
	docker run -itd \
	                --net=hadoop \
					-p 2181:2181 \
	                -p 9092:9092 \
	                --name kafka-1 \
	                --hostname kafka-1 \
	                --env KAFKA_BROKER_ID=1 \
					--env KAFKA_ADVERTISED_HOST_NAME=$(docker-machine ip collector) \
					--env KAFKA_PORT=9092 \
					--env RUN_ZK=$RUN_ZK \
	                kafka:$KAFKA_VERSION &> /dev/null
else
	docker run -itd \
	                --net=hadoop \
	                -p 9092:9092 \
	                --name kafka-1 \
	                --hostname kafka-1 \
	                --env KAFKA_BROKER_ID=1 \
					--env KAFKA_ADVERTISED_HOST_NAME=$(docker-machine ip collector) \
					--env KAFKA_PORT=9092 \
					--env RUN_ZK=$RUN_ZK \
	                kafka:$KAFKA_VERSION &> /dev/null
fi

i=2
while [ $i -le $N ]
do
	docker rm -f kafka-$i &> /dev/null
	echo "start kafka-$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name kafka-$i \
	                --hostname kafka-$i \
                    --env KAFKA_BROKER_ID=$i \
					--env RUN_ZK=$RUN_ZK \
	                kafka:$KAFKA_VERSION &> /dev/null
	i=$(( $i + 1 ))
done
