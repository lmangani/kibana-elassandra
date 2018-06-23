FROM kibana:6.2.3
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV CONTAINER_VERSION="6.2.3.1"
ENV KIBANA_VERSION="6.2.3"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

RUN apt-get update && apt-get install -y zip unzip curl \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install nodejs \
  && apt-get clean && npm install -g npm && npm install -g bower
  
RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip

# Hotpatch to keep SENTINL Watcher IDs < 11 chars
RUN sed -Ei "s/substr(2, 100)/substr(2, 3)/g" ${PLUGIN_PATH}/sentinl/public/services/watcher.js


