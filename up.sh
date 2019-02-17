#!/usr/bin/env bash

set -o errexit

KCU_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

KCU_DC_FILES="${@/#/--file ${KCU_SRC_DIR}/docker-compose/}"

KCU_CUR_USER=$(id -u):$(id -g) docker-compose --file ${KCU_SRC_DIR}/docker-compose/main.yml ${KCU_DC_FILES} up --detach

echo "Waiting kafka-manager"
until $(curl --max-time 2 --output /dev/null --silent --head --fail http://1.1.1.6:9000); do
    printf '.'
    sleep 2
done

echo
echo "Adding cluster settings to the kafka-manager..."

curl --max-time 3 'http://1.1.1.6:9000/clusters' \
    --output /dev/null \
    --silent \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data 'name=local&zkHosts=1.1.1.2%3A2181&kafkaVersion=0.9.0.1&jmxEnabled=true&jmxUser=&jmxPass=&pollConsumers=true&activeOffsetCacheEnabled=true&tuning.brokerViewUpdatePeriodSeconds=30&tuning.clusterManagerThreadPoolSize=2&tuning.clusterManagerThreadPoolQueueSize=100&tuning.kafkaCommandThreadPoolSize=2&tuning.kafkaCommandThreadPoolQueueSize=100&tuning.logkafkaCommandThreadPoolSize=2&tuning.logkafkaCommandThreadPoolQueueSize=100&tuning.logkafkaUpdatePeriodSeconds=30&tuning.partitionOffsetCacheTimeoutSecs=5&tuning.brokerViewThreadPoolSize=8&tuning.brokerViewThreadPoolQueueSize=1000&tuning.offsetCacheThreadPoolSize=8&tuning.offsetCacheThreadPoolQueueSize=1000&tuning.kafkaAdminClientThreadPoolSize=8&tuning.kafkaAdminClientThreadPoolQueueSize=1000' \
    --compressed

echo
echo "Cluster up and running...."
echo
docker-compose -f ${KCU_SRC_DIR}/docker-compose/main.yml ${KCU_DC_FILES} ps