# Data Collector EcoSystem

## 개요
  이 시스템은 Kafka + Flume + Hadoop을 용해서 데이터를 수집하는 Docker File이다.
## 참고
  Hadoop:
    - https://github.com/sequenceiq/hadoop-docker
    - http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/
  Kafka:
    - https://github.com/ches/docker-kafka

## version
  - Java: Oracle jdk 8.121
  - Hadoop: 2.7.3
    - Hadoop-zookeeper: 3.4.6
  - Flume: 1.7.0
  - Kafka: 0.10.1.1
    - Kafka-Scala: 2.11
    - Kafka-Zookeeper: 3.4.8

## 사용방법
**Kafka가 실행이 안된상태에서 Flume을 실행 할 경우 zookeeper에 접속 할 수 없으므로 kafka를 먼저 실행 해야 한다.**
1. Docker Machine 생성
    - OSX: Kafka를 외부에서 접속하기 위해서는 docker-machine 을 이용하여 구성해야 한다. 그리고 여기에서 나오는 IP를 Kafka서버에 전달 해줘야 한다.
```
docker-machine create --driver virtualbox collector
```
    - machine active
```
docker-machine env collector
eval $(docker-machine env collector)
```
    - network 생성
```
docker network create --driver=bridge hadoop
```
2. Kafka Cluster 생성
```
resize-kafka-cluster.sh [Number of Clusters] [Zookeeper prefix]
```
  - Number of Cluster: 클러스터 수
  - Zookeeper prefix: 주키퍼 서버를 따로 운영 할 경우
    - 현재 zk/Docker를 실행하면 zk-1,zk-2와 같은 형태가 생성 되므로 prefix에 zk넣음
  - ex) resize-kafka-cluster.sh 3 zk

3. Kafka 실행
```
kafka/run-kafka-cluster.sh [Number of Clusters] [RUN_ZK(true or false)]
```
  - 내장 Zookeeper를 사용할 경우 true, 외부 Zookeeper를 사용 할 경우 false
4. Hadoop Cluster 생성(Master에 Flume 설치)
```
resize-hadoop-cluster.sh [Number of Clusters]
```

5. Hadoop Cluster 실행
```
run-hadoop-cluster.sh [Number of Clusters]
```
run-cluster를 실행하면 hadoop-master container로 접속 된다.  
master로 접속 수 아래 명령어를 수행한다.
```
  1) Nmaenode Format
    ./hadoop-init.sh

  2) Hadoop 실행
    ./start-dfs.sh

  3) Yarn 실행
    ./start-yarn.sh

  4) Flume 설치(Master에만 설치함)
    source ./flume-init.sh setup
  *환경변수 등록을 해야 하므로 source를 이용해서 shell실행

  5) Flume 실행
    - flume-kafka2hdfs.conf.template 을 이용하여 conf를 수정 한다.
      참고: conf에서 tier1.sources.src1.zookeeperConnect에
           kafka의 zookeeper 주소를 입력해야함
    - flume-start.sh.template을 이용하여 sh을 수정 한다.
```


## Zookeeper 서버를 따로 운영 할 경우
1. Zookeeper 생성
```
resize-zk-cluster.sh [Number of Node]
```

2. Zookeeper 실행

```
run-zk-cluster.sh [Number of Node]
```
