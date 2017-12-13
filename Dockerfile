FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV CONTAINER_VERSION="5.5.0.2"
ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

RUN apt-get update && apt-get install -y nodejs npm zip unzip curl nodejs npm && ln -s /usr/bin/nodejs /usr/bin/node && apt-get clean && npm install -g bower
   
RUN cd /tmp \
   && wget -O network_vis.tar.gz https://github.com/dlumbrer/kbn_network/releases/download/5.5.X_5.6.X/network_vis.tar.gz \
   && tar xvzf network_vis.tar.gz && rm -rf network_vis/images && mv network_vis ${PLUGIN_PATH}/network_vis \
   && rm -rf /tmp/network_vis.tar.gz

RUN cd /tmp \
   && wget -O kpd-custom-theme.tar.gz https://github.com/ErikvdVen/kpd-custom-theme/archive/v0.0.1.tar.gz \
   && tar xvzf kpd-custom-theme.tar.gz && rm -rf kpd-custom-theme-0.0.1/images \
   && wget -O kpd-custom-theme-0.0.1/public/images/logo.png https://user-images.githubusercontent.com/1423657/33860929-5aae34f6-dedb-11e7-8d20-c09c3a53394c.png \
   && wget -O kpd-custom-theme-0.0.1/public/images/logo-white.png https://user-images.githubusercontent.com/1423657/33860928-5a901d36-dedb-11e7-8ef4-45f5b31cd98e.png \
   && mv kpd-custom-theme-0.0.1 ${PLUGIN_PATH}/kpd_custom_theme \
   && rm -rf /tmp/kpd-custom-theme.tar.gz
   
RUN cd /tmp \
   && wget -O kibana_time_plugin.tar.gz https://github.com/nreese/kibana-time-plugin/archive/5.5.tar.gz \
   && tar xvzf kibana_time_plugin.tar.gz \
   && mv kibana-time-plugin-5.5 ${PLUGIN_PATH}/kibana-time-plugin \
   && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\"/" ${PLUGIN_PATH}/kibana-time-plugin/package.json \
   && cd ${PLUGIN_PATH}/kibana-time-plugin && bower --allow-root install \
   && rm -rf /tmp/*.tar.gz
      
RUN cd /tmp \
   && wget -O kibi_timeline_vis.zip https://github.com/sirensolutions/kibi_timeline_vis/releases/download/5.5.3/kibi_timeline_vis-5.5.3.zip \
   && mkdir -p kibana/kibi_timeline_vis-5.5.3 \
   && unzip -p kibi_timeline_vis.zip kibana/kibi_timeline_vis-5.5.3/package.json > kibana/kibi_timeline_vis-5.5.3/package.json \
   && sed -Ei "s/5.5.3/5.5.0/g" kibana/kibi_timeline_vis-5.5.3/package.json \
   && zip kibi_timeline_vis.zip kibana/kibi_timeline_vis-5.5.3/package.json \
   && kibana-plugin install file:///tmp/kibi_timeline_vis.zip \
   && rm -rf /tmp/*
   
RUN cd /tmp \
   && wget -O mapster.zip  https://github.com/elastickent/mapster/archive/master.zip \
   && unzip mapster.zip && mv mapster-master ${PLUGIN_PATH}/mapster \
   && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\"/" ${PLUGIN_PATH}/mapster/package.json \
   && rm -rf /tmp/*
   
RUN kibana-plugin install https://github.com/Webiks/kibana-API/releases/download/5.5.0/kibana_api-0.2.0.zip

RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip

# Hotpatch to keep SENTINL Watcher IDs < 11 chars
RUN sed -Ei "s/substr(2, 100)/substr(2, 3)/g" ${PLUGIN_PATH}/sentinl/public/services/watcher.js

RUN kibana-plugin install https://github.com/prelert/kibana-swimlane-vis/releases/download/v5.5.0/prelert_swimlane_vis-5.5.0.zip

RUN cd /tmp \
  && wget https://github.com/dlumbrer/kbn_searchtables/releases/download/5.5.X-3/kbn_searchtables.zip \
  && unzip kbn_searchtables.zip && mv kbn_searchtables ${PLUGIN_PATH}/kbn_searchtables \
  && rm -rf /tmp/*
  
RUN cd /tmp \
  && wget -O kbn_sankey_vis.zip  https://github.com/LeonAgmonNacht/kbn_sankey_vis/archive/master.zip \
  && unzip kbn_sankey_vis.zip && mv kbn_sankey_vis-master ${PLUGIN_PATH}/kbn_sankey_vis \
  && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\"/" ${PLUGIN_PATH}/kbn_sankey_vis/package.json \
  && cd ${PLUGIN_PATH}/kbn_sankey_vis && npm install \
  && rm -rf /tmp/*

RUN kibana-plugin install https://github.com/seadiaz/computed-columns/releases/download/0.7.0/computed-columns-0.7.0-5.5.0.zip


