#!/bin/bash
N=$1
ZK_PREFIX=${2:-kafka}
RUN_ZK=${3-true}

if [[ $RUN_ZK == "true" ]]; then
	echo $RUN_ZK
fi

$ZK_PORT="--env RUN_ZK=true"
echo $ZK_PORT
