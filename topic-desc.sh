#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: topic-desc.sh topic-name"
    exit 1
fi

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-topics --describe \
    --topic ${1} \
    --zookeeper ${KCU_ZK_SERVER:-1.1.1.2:2181}