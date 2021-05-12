#!/bin/bash

#######################################
function es_config() {
    # ElasticSearch Configuration
    export ES_HOST=${ES_HOST}
    export ES_PORT=${ES_PORT}
    export ES_TAG_1=${ES_TAG_1}
    export ES_TAG_2=${ES_TAG_2}
    export ES_USERNAME=${ES_USERNAME}
    export ES_PASSWORD=${ES_PASSWORD}
    export ES_REFERENCE_NAME=${ES_REFERENCE_NAME}
    export ES_INDEX_NAME=${K8S_NAMESPACE}-${ES_REFERENCE_NAME}

    envsubst < /opt/source_filebeat.yml > /opt/filebeat/filebeat.yml
    touch /var/log/es-push.log
}


#######################################
function filebeat_start() {
    es_config
    export P_W_D=$PWD ; cd /opt/filebeat/
    ./filebeat -c /opt/filebeat/filebeat.yml &
    cd $P_W_D
}

filebeat_start