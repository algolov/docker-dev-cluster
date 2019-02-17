#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: consumer-read.sh topic-name [args..]"
    echo "topic-name:       The topic id to produce messages to"
    exit 1
fi

KCU_TOPIC=${1}
shift

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-console-consumer \
    --bootstrap-server ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
    --topic ${KCU_TOPIC} ${@}