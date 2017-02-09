#!/bin/bash
if [[ ! "$#" -eq 1 ]]; then
    echo "You should exec command : source flume-init.sh setup"
elif [[ "$1"="setup" ]]; then
    FLUME_VERSION="1.7.0"
    if [ -z "$FLUME_HOME" ]; then
        echo "Flume setup Start"
        echo "Flume download - version 1.7.0"

        curl -L 'http://apache.tt.co.kr/flume/'"$FLUME_VERSION"'/apache-flume-'"$FLUME_VERSION"'-bin.tar.gz' | tar -xz -C /usr/local/
        cd /usr/local && ln -s ./apache-flume-$FLUME_VERSION-bin flume

        echo "Setting Flume Path"
        echo 'export FLUME_HOME=/usr/local/flume' >> ~/.bashrc
        echo 'export PATH=$PATH:$FLUME_HOME/bin' >> ~/.bashrc

        source ~/.bashrc

        echo "Flume Path setting"
        cp $FLUME_HOME/conf/flume-env.sh.template $FLUME_HOME/conf/flume-env.sh
        cp /kafka2hdfs.conf.template $FLUME_HOME/conf/kafka2hdfs.conf
        sed -i '/^#FLUME_CLASSPATH=""/ s:.*:FLUME_CLASSPATH="'"$HADOOP_PREFIX"'/share/hadoop/common/lib/zookeeper-3.4.6.jar":' $FLUME_HOME/conf/flume-env.sh

        export FLUME_HOME=/usr/local/flume
        export PATH=$PATH:$FLUME_HOME/bin

        cd /

        echo "Flume Setup Success!"
    else
        echo "Flume is aleady setup."
    fi
fi
