FROM prographerj/ubuntu16-java8
MAINTAINER Prographer J<prographer.j@gmail.com>

ARG SCALA_VERSION=2.11
ARG KAFKA_VERSION=1.0.1
ARG JMX_PORT=8429
USER root

#install dev tools
RUN apt-get update -y
RUN apt-get install -y libsnappy1v5

# kafka
RUN curl -Ls http://mirror.navercorp.com/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./kafka_${SCALA_VERSION}-${KAFKA_VERSION} kafka
ENV KAFKA_HOME /usr/local/kafka
ENV PATH $PATH:$KAFKA_HOME/bin

#kafka config copy
ADD config/zookeeper.properties $KAFKA_HOME/config/zookeeper.properties
ADD config/server.properties $KAFKA_HOME/config/server.properties.template
ADD config/start-kafka.sh /start-kafka.sh
RUN chmod +x /start-kafka.sh
RUN mkdir -p /tmp/zookeeper

#port
EXPOSE 2181 2888 3888
EXPOSE 9092 ${JMX_PORT}

#CMD ["/start-kafka.sh"]
RUN echo "/start-kafka.sh" >> ~/.bashrc
