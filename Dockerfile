FROM docker.elastic.co/kibana/kibana-oss:6.2.4
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV INTERNAL="dev624-6"

ENV KIBANA_VERSION="6.2.4"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins

RUN kibana-plugin install https://github.com/lmangani/kibana_diagram/raw/master/dist/kibana_diagram-6.2.4.zip
RUN kibana-plugin install https://github.com/lmangani/timelion-influxdb/raw/master/dist/timelion-influxdb-1.0.0.zip
RUN kibana-plugin install https://github.com/lmangani/kibana-kable/raw/master/dist/kable-6.2.4.zip

RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.4-pre-0/sentinl-v6.2.4.zip

USER root
RUN yum update -y && yum install -y fontconfig freetype net-tools && yum clean all
USER kibana
