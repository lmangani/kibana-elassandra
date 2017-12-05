FROM kibana:5.5.0
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV KIBANA_VERSION="5.5.0"
ENV KIBANA_PATH=/usr/share/kibana

RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-5.5/sentinl-v${KIBANA_VERSION}.zip


