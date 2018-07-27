FROM docker.elastic.co/kibana/kibana-oss:6.2.4
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV INTERNAL="dev624-3"

ENV KIBANA_VERSION="6.2.4"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins
  
#RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.3-3/sentinl-v6.2.4.zip
RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.4-pre-0/sentinl-v6.2.4.zip

# Hotpatch to keep SENTINL Watcher IDs < 11 chars
# RUN sed -Ei "s/substr(2, 100)/substr(2, 3)/g" ${PLUGIN_PATH}/sentinl/public/services/watcher.js

RUN kibana-plugin install https://github.com/lmangani/kibana_diagram/raw/master/dist/kibana_diagram-6.2.4.zip
RUN kibana-plugin install https://github.com/lmangani/timelion-influxdb/raw/master/dist/timelion-influxdb-1.0.0.zip
