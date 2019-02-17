#!/usr/bin/env bash

if [[ $# -lt 2 ]]
then
    echo "Usage: consumer-reset.sh group-name topic [position]"
    echo "group-name:          The name of consumer group."
    echo "topic:               The name of topic."
    echo "position:            The position to which you want to reset the offsets."
    echo "                     --to-earliest : Reset offsets to earliest offset (this is the default)."
    echo "                     --to-latest : Reset offsets to latest offset."
    echo "                     --to-datetime <String: datetime> : Reset offsets to offsets from datetime. Format: 'YYYY-MM-DDTHH:mm:SS.sss'"
    echo "                     --shift-by <Long: number-of-offsets> : Reset offsets shifting current offset by 'n', where 'n' can be positive or negative."
    echo "                     --to-current : Resets offsets to current offset."
    echo "                     --by-duration <String: duration> : Reset offsets to offset by duration from current timestamp. Format: 'PnDTnHnMnS'"
    echo "                     --to-offset : Reset offsets to a specific offset."
    exit 1
fi

KCU_TOPIC=${2}
KCU_CONSUMER_GROUP=${1}

if [[ -z "$3" ]]; then

    KCU_POSITION="--to-earliest"

else

    shift
    shift

    KCU_POSITION="$@"
fi

docker run --net=host --rm \
    confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    kafka-consumer-groups \
    --bootstrap-server ${KCU_BOOTSTRAP_SERVER:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092} \
    --reset-offsets --group ${KCU_CONSUMER_GROUP} \
    --topic ${KCU_TOPIC} ${KCU_POSITION} --execute