#!/usr/bin/env bash

if [[ $1 == *"old"* ]]
then
    docker run --net=host --rm \
        confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
        kafka-consumer-groups \
        --zookeeper ${KCU_ZK_SERVER:-1.1.1.2:2181} \
        --list
else
    docker run --net=host --rm \
        confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
        kafka-consumer-groups \
        --bootstrap-server ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
        --list
fi