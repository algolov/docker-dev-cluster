#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: topic-delete.sh topic-name"
    echo "topic-name:   The topic to be delete"
    exit 1
fi

docker run --net=host --rm confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
  kafka-topics --delete \
  --topic ${1} \
  --zookeeper ${KCU_ZK_SERVER:-1.1.1.2:2181}