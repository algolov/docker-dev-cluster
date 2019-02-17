#!/usr/bin/env bash

docker run --rm --net=host --name=zk-shell \
    confluentinc/cp-zookeeper:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
    zookeeper-shell ${KCU_ZK_SERVER:-1.1.1.2:2181} $@