FROM prographerj/ubuntu16-java8
MAINTAINER Prographer J<prographer.j@gmail.com>

USER root

ARG HADOOP_VERSION=2.7.3

#install dev tools
RUN apt-get update
RUN apt-get install -y openssh-server openssh-client rsync libsnappy1v5

#ssh setting
ADD config/ssh-config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -A

RUN echo "/usr/sbin/sshd" >> ~/.bashrc

# hadoop
RUN curl -Ls http://apache.tt.co.kr/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-$HADOOP_VERSION hadoop
RUN cd /usr/local/hadoop && mkdir -p logs

ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

ENV PATH $PATH:$HADOOP_PREFIX/bin
ENV PATH $PATH:$HADOOP_PREFIX/sbin

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/default\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_PREFIX=/usr/local/hadoop\n:' $HADOOP_CONF_DIR/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_CONF_DIR/hadoop-env.sh

#copy config
ADD config/core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
ADD config/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
ADD config/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
ADD config/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
ADD config/slaves $HADOOP_PREFIX/etc/hadoop/slaves

RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
RUN service ssh start

#Running in master node
#namenode format
ADD config/hadoop-init.sh /hadoop-init.sh
RUN chmod +x /hadoop-init.sh

#Running in master node
#flume setup
ADD config/flume-init.sh /flume-init.sh
RUN chmod +x /flume-init.sh

ADD config/flume-kafka2hdfs.conf.template /kafka2hdfs.conf.template
ADD config/flume-start.sh.template /flume-start.sh
RUN chmod +x /flume-start.sh

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 22
