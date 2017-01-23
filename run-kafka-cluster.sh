#!/bin/bash

# N is the node number of kafka cluster
N=$1


if [ $# = 0 ]
then
	echo "Please enter the node number of kafka cluster"
	exit 1
fi

docker rm -f kafka-1 &> /dev/null
echo "start kafka-1 container..."
docker run -itd \
                --net=hadoop \
                -p 2181:2181 \
                -p 9092:9092 \
                --name kafka-1 \
                --hostname kafka-1 \
                --env KAFKA_BROKER_ID=1 \
                kafka:1.0 &> /dev/null

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
	                kafka:1.0 &> /dev/null
	i=$(( $i + 1 ))
done
