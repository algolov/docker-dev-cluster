#!/usr/bin/env bash

if [[ -z "$1" ]] || [[ "$1" = "local" ]]
then
    export KCU_ZK_SERVER=1.1.1.2:2181
    export KCU_BOOTSTRAP_SERVER=1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092
elif [[ "$1" = "prod" ]]
then

    export KCU_ZK_SERVER=some-prod-host:2181/dcos-service-confluent-kafka

    export KCU_KAFKA_BROKERS_ENDPOINT="http://kafka.prod-host.com/service/confluent-kafka/v1/endpoints/broker"
	export KCU_BOOTSTRAP_SERVER="$(curl -s ${KCU_KAFKA_BROKERS_ENDPOINT} | jq -r '.address | join(",")')"
else
  echo "Unknown profile [${1}]."
fi