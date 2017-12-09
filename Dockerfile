FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV CONTAINER_VERSION="5.5.0.1"
ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

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

RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip
