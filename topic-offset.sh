#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: topic-offset.sh topic-name [first | last | f | l]"
    echo "Return first (f) or last (l) offset for each partition of the topic with name 'topic-name'"
    exit 1
fi

if [[ -z "$2" ]] || [[ "$2" -eq "last" ]] || [[ "$2" -eq "l" ]] || [[ "$2" -eq "-l" ]]
then
    KCU_OFFSET="-1"
else
    KCU_OFFSET="-2"
fi

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-run-class kafka.tools.GetOffsetShell --broker-list \
    ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
    --topic $1 --time ${KCU_OFFSET}