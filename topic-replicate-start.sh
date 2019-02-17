#!/usr/bin/env bash

if [[ -z "$2" ]]
then
    KCU_RND_POSTFIX=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
    KCU_CONSUMER_GROUP="replicate-${1}-${KCU_RND_POSTFIX}"
fi

if [[ -z "$KCU_PROD_CONF" ]]
then

KCU_PROD_CONF="bootstrap.servers=${KCU_KAFKA_DST_SERVERS:-1.1.1.3:9092,1.1.1.4:9092,1.1.1.5:9092}
acks=1
client.id=mirror_maker_producer
max.in.flight.requests.per.connection=1
retries=5
compression.type=snappy"

fi

if [[ -z "$KCU_CONS_CONF" ]]
then
	if [[ -z "$KCU_KAFKA_SRC_SERVERS" ]]
	then
		KCU_KAFKA_SRC_SERVERS="$(curl -s ${KCU_KAFKA_BROKERS_ENDPOINT} | jq -r '.address | join(",")')"
	fi

KCU_CONS_CONF="bootstrap.servers=${KCU_KAFKA_SRC_SERVERS}
group.id=${KCU_CONSUMER_GROUP}
exclude.internal.topics=true
client.id=mirror_maker_consumer
enable.auto.commit=true
auto.offset.reset=earliest
#partition.assignment.strategy=org.apache.kafka.clients.consumer.RoundRobinAssignor"

fi


echo
echo "Starting replication of [${1}] topic..."
echo

docker run -d --net=host --name replicator --rm \
	confluentinc/cp-kafka:${KCU_CONFLUENT_KAFKA_VERSION:-latest} \
	bash -c "cub kafka-ready -z ${KCU_ZK_SERVER:-1.1.1.2:2181} 3 30 && \
	printf \"${KCU_PROD_CONF}\" > /etc/producer.cfg && \
	printf \"${KCU_CONS_CONF}\" > /etc/consumer.cfg && \
	kafka-mirror-maker \
	   --consumer.config /etc/consumer.cfg \
	   --producer.config /etc/producer.cfg \
	   --whitelist ${1} --num.streams 1"