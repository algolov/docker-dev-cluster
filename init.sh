#!/usr/bin/env bash

set -o errexit -o nounset

if [[ "${KCU_TRACE:-}" == "true" ]]; then
  set -o verbose \
      -o xtrace
fi

KCU_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. ${KCU_SRC_DIR}/profile.sh ${1:-local}

export KCU_CONFLUENT_KAFKA_VERSION=5.1.0

mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/zookeeper/zk-data
mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/zookeeper/zk-txn-logs
mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/kafka/broker1
mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/kafka/broker2
mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/kafka/broker3
mkdir -p ${KCU_SRC_DIR}/docker-compose/volumes/grafana