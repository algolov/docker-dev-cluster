#!/usr/bin/env bash

KCU_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
KCU_DC_FILES="${@/#/-file ${KCU_SRC_DIR}/docker-compose/}"

docker-compose --file ${KCU_SRC_DIR}/docker-compose/main.yml \
    --file ${KCU_SRC_DIR}/docker-compose/monitor.yml ${KCU_DC_FILES} down