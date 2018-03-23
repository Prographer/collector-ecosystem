#!/bin/bash

# N is the node number of kafka cluster
N=$1
ZK_PREFIX=${2:-kafka}

if [ $# = 0 ]
then
	echo "Please enter the node number of kafka cluster"
	exit 1
fi
echo -e "\n1. make zookeeper.properties file"
# change zookeeper.properties file
rm kafka/config/zookeeper.properties
cp kafka/config/zookeeper.properties.template kafka/config/zookeeper.properties

echo -e "\ninitLimit=5\nsyncLimit=2\n" >> kafka/config/zookeeper.properties

echo -e " - zookeeper server"
i=1
while [ $i -le $N ]
do
	zookeeper_server="server.$i=$ZK_PREFIX-$i:2888:3888"
	echo -e $zookeeper_server >> kafka/config/zookeeper.properties
	echo -e "\t$zookeeper_server"

	connection_string+="$ZK_PREFIX-$i:2181,"
	((i++))
done

echo -e "\n2. make server.properties\n - zookeeper connection string\n\t"${connection_string%,}
sed 's/{{ZOOKEEPER_CONNECTIONS}}/'"${connection_string%,}"'/g' kafka/config/server.properties.template > kafka/config/server.properties

echo -e "\n3. build docker kafka image\n"
docker build --tag kafka:1.0.1 kafka/.
