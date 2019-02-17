#!/usr/bin/env bash

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-topics --list --exclude-internal \
    --zookeeper ${KCU_ZK_SERVER:-1.1.1.2:2181}