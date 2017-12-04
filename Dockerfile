FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana

RUN cd /tmp \
    && wget https://github.com/dlumbrer/kbn_network/releases/download/5.5.X_5.6.X/network_vis.tar.gz \
    && tar xvzf network_vis.tar.gz && rm -rf network_vis/images && mv network_vis ${KIBANA_PATH}/network_vis \
    && rm -rf /tmp/network_vis.tar.gz

RUN kibana plugin --install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip


