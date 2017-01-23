#!/bin/bash

if [[ "$#" -gt 0 ]]; then
    if [ "$1" = "--force" ]; then
        echo "Namenode force format."
        hadoop namenode -format
    else
        echo "none"
    fi
else
    #hdfs-site.xml -> dfs.namenode.name.dir -> value
    DIR="/home/hdfs/namenode"
    if [ ! -d "$DIR" ]; then
        echo "Namenode soft format."
        hadoop namenode -format
    else
        echo "Namenode is formatted."
    fi
fi
