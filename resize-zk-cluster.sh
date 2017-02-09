#!/bin/bash

# N is the node number of kafka cluster
N=$1
ZK_VERSION=3.4.6

if [ $# = 0 ]
then
	echo "Please enter the node number of zk cluster"
	exit 1
fi
echo -e "\n1. make zoo.cfg file"
# change zookeeper.properties file
rm zookeeper/config/zoo.cfg
cp zookeeper/config/zoo.cfg.template zookeeper/config/zoo.cfg

echo -e "\ninitLimit=5\nsyncLimit=2\n" >> zookeeper/config/zoo.cfg

echo -e " - zookeeper server"
i=1
while [ $i -le $N ]
do
	zookeeper_server="server.$i=zk-$i:2888:3888"
	echo -e $zookeeper_server >> zookeeper/config/zoo.cfg
	echo -e "\t$zookeeper_server"

	connection_string+="zk-$i:2181,"
	((i++))
done

echo -e "\n3. build docker kafka image\n"
docker build --tag zk:$ZK_VERSION zookeeper/.
