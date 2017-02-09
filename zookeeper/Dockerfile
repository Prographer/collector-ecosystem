FROM prographerj/ubuntu16-java8
MAINTAINER Prographer J<prographer.j@gmail.com>

ARG ZK_VERSION=3.4.6
USER root

#install dev tools
RUN apt-get update -y

# kafka
RUN curl -Ls http://apache.mirror.cdnetworks.com/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz | tar -xz -C /usr/local/

RUN cd /usr/local && ln -s ./zookeeper-${ZK_VERSION} zk
ENV ZK_HOME /usr/local/zk
ENV PATH $PATH:$ZK_HOME/bin

#kafka config copy
ADD config/zoo.cfg $ZK_HOME/conf/zoo.cfg
ADD config/start-zk.sh /start-zk.sh
RUN chmod +x /start-zk.sh
RUN mkdir -p /tmp/zookeeper

#port
EXPOSE 2181 2888 3888

RUN echo "/start-zk.sh" >> ~/.bashrc
