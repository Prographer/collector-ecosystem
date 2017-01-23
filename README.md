# Data Collector EcoSystem

## 개요
  이 시스템은 Kafka + Flume + Hadoop을 용해서 데이터를 수집하는 Docker File이다.

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

1. Kafka Cluster 생성
```
kafka/resize-cluster.sh [Number of Clusters]
```

2. Kafka 실행
```
kafka/run-cluster.sh [Number of Clusters]
```

3. Hadoop Cluster 생성(Master에 Flume 설치)
```
hadoop/resize-cluster.sh [Number of Clusters]
```

4. Hadoop Cluster 실행
```
hadoop/run-cluster.sh [Number of Clusters]
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
