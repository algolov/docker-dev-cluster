#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: consumer-delete.sh my-group my-other-group"
    exit 1
fi

KCU_CONSUMER_GROUP="${@/#/--group }"

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-consumer-groups \
    --bootstrap-server ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
    --delete ${KCU_CONSUMER_GROUP}