#!/bin/bash

# N is the node number of kafka cluster
N=$1
ZK_VERSION=3.4.6

if [ $# = 0 ]
then
	echo "Please enter the node number of zookeeper cluster"
	exit 1
fi

docker rm -f zk-1 &> /dev/null
echo "start zk-1 container..."
docker run -itd \
                --net=hadoop \
                -p 2181:2181 \
                --name zk-1 \
                --hostname zk-1 \
                --env ZK_ID=1 \
                zk:$ZK_VERSION &> /dev/null

i=2
while [ $i -le $N ]
do
	docker rm -f zk-$i &> /dev/null
	echo "start zk-$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name zk-$i \
	                --hostname zk-$i \
                    --env ZK_ID=$i \
	                zk:$ZK_VERSION &> /dev/null
	i=$(( $i + 1 ))
done
