#!/bin/bash

# N is the node number of hadoop cluster
N=${1:-3}
HADOOP_VERSION=2.7.5

if [ $# = 0 ]
then
	echo "Please enter the node number of hadoop cluster"
	exit 1
fi
echo -e "\n1. make slaves file"

rm hadoop/config/slaves
i=1
while [ $i -le $N ]
do
	slave="hadoop-slave$i"
	echo -e $slave >> hadoop/config/slaves
	echo -e "\t$slave"
	((i++))
done

echo -e "\n2. build docker hadoop image\n"
dir=$(pwd)

docker build --tag hadoop:$HADOOP_VERSION hadoop/.
