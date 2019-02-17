#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: consumer-desc.sh group-name [--offsets] [--members] [--verbose] [--state]"
    echo "group-name:          The name of consumer group."
    echo "--offsets:           This is the default describe option and can be omitted."
    echo "--members:           This option provides the list of all active members in the consumer group."
    echo "--members --verbose: On top of the information reported by the '--members' options above, "
    echo "                     this option also provides the partitions assigned to each member."
    echo "--state:             This option provides useful group-level information."
    exit 1
fi

docker run --net=host \
    --rm confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-consumer-groups \
    --bootstrap-server ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
    --describe --group $@