#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: topic-create.sh topic-name [partitions] [replication-factor]"
    echo "topic-name -         The topic to be create"
    echo "partitions -         The number of partitions for the topic"
    echo "                     being created (default: 10)"
    echo "replication-factor - The replication factor for each partition"
    echo "                     in the topic being created (default: 3)"
    exit 1
fi

docker run --net=host --rm confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
  kafka-topics --create \
  --topic ${1} \
  --partitions ${2:-10} \
  --replication-factor ${3:-3} \
  --if-not-exists \
  --zookeeper ${KCU_ZK_SERVER:-1.1.1.2:2181}