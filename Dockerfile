FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV CONTAINER_VERSION="5.5.0.1"
ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

RUN apt-get update && apt-get install -y zip unzip && apt-get clean

RUN cd /tmp \
   && wget -O network_vis.tar.gz https://github.com/dlumbrer/kbn_network/releases/download/5.5.X_5.6.X/network_vis.tar.gz \
   && tar xvzf network_vis.tar.gz && rm -rf network_vis/images && mv network_vis ${PLUGIN_PATH}/network_vis \
   && rm -rf /tmp/network_vis.tar.gz

RUN cd /tmp \
   && wget -O kpd-custom-theme.tar.gz https://github.com/ErikvdVen/kpd-custom-theme/archive/v0.0.1.tar.gz \
   && tar xvzf kpd-custom-theme.tar.gz && rm -rf kpd-custom-theme-0.0.1/images \
   && wget -O kpd-custom-theme-0.0.1/public/images/logo.png https://i.imgur.com/4b6mE12.png  \
   && mv kpd-custom-theme-0.0.1 ${PLUGIN_PATH}/kpd_custom_theme \
   && rm -rf /tmp/kpd-custom-theme.tar.gz
   
RUN cd /tmp \
   && wget -O kibana_time_plugin.tar.gz https://github.com/nreese/kibana-time-plugin/archive/5.5.tar.gz \
   && tar xvzf kibana_time_plugin.tar.gz \
   && mv kibana-time-plugin-5.5 ${PLUGIN_PATH}/kibana_time_plugin \
   && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\"/" ${PLUGIN_PATH}/kibana_time_plugin/package.json \
   && rm -rf /tmp/kpd-custom-theme.tar.gz
   
RUN cd /tmp \
   && wget https://github.com/codingchili/kbn-authentication-plugin/releases/download/1.0.0/kbn-authentication-plugin.zip \
 #   && mkdir -p kibana/kbn-authentication-plugn \
 #   && unzip -p kbn-authentication-plugin.zip kibana/kbn-authentication-plugn/package.json > kibana/kbn-authentication-plugn/package.json \
 #   && unzip -p kbn-authentication-plugin.zip kibana/kbn-authentication-plugn/config.json > kibana/kbn-authentication-plugn/config.json \
   && unzip kbn-authentication-plugin.zip \
   && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\",/" kibana/kbn-authentication-plugn/package.json \
   && sed -Ei "s/(\"kbnVersion\":).*$/\1 \"$KIBANA_VERSION\",/" kibana/kbn-authentication-plugn/config.json \
 #  && zip kbn-authentication-plugin.zip kibana/kbn-authentication-plugn/package.json \
 #  && zip kbn-authentication-plugin.zip kibana/kbn-authentication-plugn/config.json \
   && zip kbn-authentication-plugin.zip kibana \
   && kibana-plugin install file:///tmp/kbn-authentication-plugin.zip \
   && rm -rf /tmp/*
   
RUN cd /tmp \
   && wget -O kibi_timeline_vis.zip https://github.com/sirensolutions/kibi_timeline_vis/releases/download/5.5.3/kibi_timeline_vis-5.5.3.zip \
   && mkdir -p kibana/kibi_timeline_vis-5.5.3 \
   && unzip -p kibi_timeline_vis.zip kibana/kibi_timeline_vis-5.5.3/package.json > kibana/kibi_timeline_vis-5.5.3/package.json \
   && sed -Ei "s/5.5.3/5.5.0/g" kibana/kibi_timeline_vis-5.5.3/package.json \
   && zip kibi_timeline_vis.zip kibana/kibi_timeline_vis-5.5.3/package.json \
   && kibana-plugin install file:///tmp/kibi_timeline_vis.zip \
   && rm -rf /tmp/*
   
   
RUN kibana-plugin install https://github.com/Webiks/kibana-API/releases/download/5.5.0/kibana_api-0.2.0.zip

RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip

RUN kibana-plugin install https://github.com/prelert/kibana-swimlane-vis/releases/download/v5.5.0/prelert_swimlane_vis-5.5.0.zip

RUN kibana-plugin install https://github.com/seadiaz/computed-columns/releases/download/0.7.0/computed-columns-0.7.0-5.5.0.zip

# Hotpatch to keep SENTINL Watcher IDs < 11 chars
RUN sed -Ei "s/substr(2, 100)/substr(2, 3)/g" ${PLUGIN_PATH}/sentinl/public/services/watcher.js
