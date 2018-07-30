FROM docker.elastic.co/kibana/kibana-oss:6.2.4
LABEL maintainer "Lorenzo Mangani <lorenzo.mangani@gmail.com>"

ENV INTERNAL="dev624-4"

ENV KIBANA_VERSION="6.2.4"
ENV KIBANA_PATH=/usr/share/kibana
ENV PLUGIN_PATH=/usr/share/kibana/plugins
  
#RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.3-3/sentinl-v6.2.4.zip
RUN kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.2.4-pre-0/sentinl-v6.2.4.zip

# Hotpatch to keep SENTINL Watcher IDs < 11 chars
# RUN sed -Ei "s/substr(2, 100)/substr(2, 3)/g" ${PLUGIN_PATH}/sentinl/public/services/watcher.js

RUN kibana-plugin install https://github.com/lmangani/kibana_diagram/raw/master/dist/kibana_diagram-6.2.4.zip
RUN kibana-plugin install https://github.com/lmangani/timelion-influxdb/raw/master/dist/timelion-influxdb-1.0.0.zip

# custom throbber
RUN sed -i 's/Kibana/Homer-Kibana/g' /usr/share/kibana/src/core_plugins/kibana/translations/en.json
RUN sed -i 's/image\/svg+xml.*");/image\/svg+xml;base64,PHN2ZyB3aWR0aD0iMTU0LjAzIiBoZWlnaHQ9IjIwMC4xMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiA8bWV0YWRhdGEgaWQ9Im1ldGFkYXRhMzAiPmltYWdlL3N2Zyt4bWxMb2dvLUtpYmFuYUljb248L21ldGFkYXRhPg0KDQogPHRpdGxlPkxvZ28tS2liYW5hSWNvbjwvdGl0bGU+DQogPGc+DQogIDx0aXRsZT5iYWNrZ3JvdW5kPC90aXRsZT4NCiAgPHJlY3QgeD0iLTEiIHk9Ii0xIiB3aWR0aD0iMTU2LjAzIiBoZWlnaHQ9IjIwMi4xMSIgaWQ9ImNhbnZhc19iYWNrZ3JvdW5kIiBmaWxsPSJub25lIi8+DQogPC9nPg0KIDxnPg0KICA8dGl0bGU+TGF5ZXIgMTwvdGl0bGU+DQogIDxlbGxpcHNlIGZpbGw9IiNlYjIwMjYiIHN0cm9rZT0ibnVsbCIgc3Ryb2tlLXdpZHRoPSJudWxsIiBzdHJva2Utb3BhY2l0eT0ibnVsbCIgY3g9Ijc4LjAxNTAxIiBjeT0iMTAzLjQ1NDk5IiBpZD0ic3ZnXzEiIHJ4PSI2NC41IiByeT0iNjEuNSIvPg0KICA8dGV4dCBmaWxsPSIjRkZGRkZGIiBzdHJva2U9Im51bGwiIHN0cm9rZS13aWR0aD0iMCIgc3Ryb2tlLW9wYWNpdHk9Im51bGwiIHg9IjM5LjUxNTAxIiB5PSIxNDEuOTU0OTkiIGlkPSJzdmdfMiIgZm9udC1zaXplPSIxMDgiIGZvbnQtZmFtaWx5PSJIZWx2ZXRpY2EsIEFyaWFsLCBzYW5zLXNlcmlmIiB0ZXh0LWFuY2hvcj0ic3RhcnQiIHhtbDpzcGFjZT0icHJlc2VydmUiIGZvbnQtd2VpZ2h0PSJib2xkIj5IPC90ZXh0Pg0KIDwvZz4NCjwvc3ZnPg==");/g' /usr/share/kibana/src/ui/ui_render/views/ui_app.jade /usr/share/kibana/src/ui/ui_render/views/chrome.jade

# custom style
RUN sed -i 's/title Kibana/title HOMER Kibana/g' /usr/share/kibana/src/ui/ui_render/views/chrome.jade
RUN sed -i "s/bundleFile('commons.style.css')/bundleFile('commons.style.css'),bundleFile('gradiant_style.style.css')/g" /usr/share/kibana/src/ui/ui_render/views/ui_app.jade
RUN bin/kibana-plugin install https://transfer.sh/DOWws/gradiant-style.zip
