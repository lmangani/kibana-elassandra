FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV CONTAINER_VERSION="5.5.0.9"
ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

RUN apt-get update && apt-get install -y zip unzip curl \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install nodejs \
  && apt-get clean && npm install -g npm && npm install -g bower
   
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
  && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\",/" ${PLUGIN_PATH}/kbn_sankey_vis/package.json \
  && cd ${PLUGIN_PATH}/kbn_sankey_vis && npm install \
  && rm -rf /tmp/*

RUN kibana-plugin install https://github.com/seadiaz/computed-columns/releases/download/0.7.0/computed-columns-0.7.0-5.5.0.zip

RUN cd /tmp \
  && wget -O kbn-auth.zip http://github.com/lmangani/kibana-elassandra/releases/download/5.5.0/kbn-authentication-plugin.zip \
  && kibana-plugin install file:///tmp/kbn-auth.zip \
  && chmod 775 ${PLUGIN_PATH}/kbn-authentication-plugin/users.json \
  && sed -Ei "s/(\"enabled\":).*$/\1 \"false\",/" ${PLUGIN_PATH}/kbn-authentication-plugin/config.json \
  && rm -rf /tmp/*

RUN chown -R kibana:kibana /usr/share/kibana

# Alias ADDUSER command (eval $ADDUSER username password)
ENV ADDUSER="nodejs /usr/share/kibana/plugins/kbn-authentication-plugin/adduser.js"
RUN ADDUSER username elassandra

RUN cd /tmp \
  && wget https://github.com/nreese/enhanced_tilemap/releases/download/v2017-10-20/enhanced-tilemap-v2017-10-20-5.5.zip \
  && unzip enhanced-tilemap-v2017-10-20-5.5.zip kibana/enhanced_tilemap/package.json \
  && sed -Ei "s/(\"version\":).*$/\1 \"$KIBANA_VERSION\",/"  kibana/enhanced_tilemap/package.json \
  && zip enhanced-tilemap-v2017-10-20-5.5.zip kibana/enhanced_tilemap/package.json \
  && kibana-plugin install file:///tmp/enhanced-tilemap-v2017-10-20-5.5.zip \
  && rm -rf /tmp/*

RUN cd /tmp \
  && wget -O metric-percent.zip https://github.com/amannocci/kibana-plugin-metric-percent/archive/master.zip \
  && unzip metric-percent.zip && mv kibana-plugin-metric-percent-master ${PLUGIN_PATH}/metric-percent \
  && rm -rf /tmp/*
  
RUN cd /tmp \
  && wget https://github.com/nyurik/kibana-vega-vis/releases/download/v0.5.0/vega_vis-0.5.0--for-Kibana-5.5.0.zip \
  && kibana-plugin install file:///tmp/vega_vis-0.5.0--for-Kibana-5.5.0.zip \
  && rm -rf /tmp/*
  
RUN cd /tmp \
  && wget https://github.com/sw-jung/kibana_markdown_doc_view/releases/download/v5.5.0/markdown_doc_view-5.5.0.zip \
  && kibana-plugin install file:///tmp/markdown_doc_view-5.5.0.zip \
  && rm -rf /tmp/*

RUN cd /tmp \
   && wget -O logtrail.zip https://github.com/sivasamyk/logtrail/releases/download/v0.1.21/logtrail-5.6.0-0.1.21.zip \
   && unzip logtrail.zip kibana/logtrail/package.json \
   && sed -Ei "s/5.6.0/5.5.0/g" /tmp/kibana/logtrail/package.json \
   && zip logtrail.zip kibana/logtrail/package.json \
   && kibana-plugin install file:///tmp/logtrail.zip \
   && rm -rf /tmp/*

