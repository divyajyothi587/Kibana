FROM akhilrajmailbox/elasticsearch:docker-jre-8u171_alpine_3.8.1
MAINTAINER Akhil Raj

# Export HTTP & Transport
EXPOSE 9200 9300

ENV ES_VERSION 6.8.0

ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/elasticsearch"
ENV ES_TARBAL "${DOWNLOAD_URL}/elasticsearch-${ES_VERSION}.tar.gz"
ENV ES_TARBALL_ASC "${DOWNLOAD_URL}/elasticsearch-${ES_VERSION}.tar.gz.asc"
ENV GPG_KEY "46095ACC8548582C1A2699A9D27D666CD88E42B4"

# Install Elasticsearch.
RUN apk add --no-cache --update bash ca-certificates su-exec util-linux curl
RUN apk add --no-cache -t .build-deps gnupg openssl \
  && cd /tmp \
  && echo "===> Install Elasticsearch..." \
  && curl -o elasticsearch.tar.gz -Lskj "$ES_TARBAL"; \
	if [ "$ES_TARBALL_ASC" ]; then \
		curl -o elasticsearch.tar.gz.asc -Lskj "$ES_TARBALL_ASC"; \
		export GNUPGHOME="$(mktemp -d)"; \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"; \
		gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz; \
		rm -r "$GNUPGHOME" elasticsearch.tar.gz.asc; \
	fi; \
  tar -xf elasticsearch.tar.gz \
  && ls -lah \
  && mv elasticsearch-$ES_VERSION /elasticsearch \
  && adduser -DH -s /sbin/nologin elasticsearch \
  && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins \
  && chown -R elasticsearch:elasticsearch /elasticsearch \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

ENV PATH /elasticsearch/bin:$PATH

WORKDIR /elasticsearch
ADD plugins/readonlyrest-1.18.7_es${ES_VERSION}.zip /tmp/readonlyrest-1.18.7_es${ES_VERSION}.zip
ADD plugins/repository-azure-${ES_VERSION}.zip /tmp/repository-azure-${ES_VERSION}.zip
ADD plugins/repository-gcs-${ES_VERSION}.zip /tmp/repository-gcs-${ES_VERSION}.zip
ADD plugins/repository-s3-${ES_VERSION}.zip /tmp/repository-s3-${ES_VERSION}.zip
# RUN rm -rf /elasticsearch/modules/x-pack*


# Copy configuration
COPY config /elasticsearch/config

# Copy run script
COPY run.sh /

# Set environment variables defaults
ENV ES_JAVA_OPTS "-Xms512m -Xmx512m"
ENV CLUSTER_NAME elasticsearch-default
ENV NODE_MASTER true
ENV NODE_DATA true
ENV NODE_INGEST true
ENV HTTP_ENABLE true
ENV NETWORK_HOST _site_
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_MASTERS 1
ENV MAX_LOCAL_STORAGE_NODES 1
ENV SHARD_ALLOCATION_AWARENESS ""
ENV SHARD_ALLOCATION_AWARENESS_ATTR ""
ENV MEMORY_LOCK false
ENV REPO_LOCATIONS ""
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV AUTH_CONFIG ""
ENV AZURE_REPOSITORY_CONFIG ""
ENV AZURE_REPOSITORY_ACCOUNT_NAME ""
ENV AZURE_REPOSITORY_ACCOUNT_KEY ""
ENV GCS_REPOSITORY_CONFIG ""
ENV S3_REPOSITORY_CONFIG ""
ENV S3_ACCESS_KEY ""
ENV S3_SECRET_KEY ""
ENV KIBANA_ADMIN_PASSWORD "Admin@Kibana"
ENV KIBANA_RO_PASSWORD "Ro@Kibana"
ENV PUSHLOG_PASSWORD "Push2ES"


# Volume for Elasticsearch data
VOLUME ["/data"]

CMD ["/run.sh"]
