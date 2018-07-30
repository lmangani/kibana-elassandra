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
RUN sed -i 's/image\/svg+xml.*");/image\/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAuMDAwMDAwMDAwMDAwMDEiIGhlaWdodD0iNTEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+DQogPG1ldGFkYXRhIGlkPSJtZXRhZGF0YTM4Ij5pbWFnZS9zdmcreG1sS2liYW5hLUZ1bGwtTG9nbzwvbWV0YWRhdGE+DQoNCiA8c3R5bGUgdHlwZT0idGV4dC9jc3MiPi5zdDB7ZmlsbDojRkZGRkZGO2ZpbGwtb3BhY2l0eTowLjkyNTM7fQ0KCS5zdDF7b3BhY2l0eTowLjc7ZmlsbDojRkZGRkZGO30NCgkuc3Qye29wYWNpdHk6MC41O2ZpbGw6I0ZGRkZGRjt9DQoJLnN0M3tmaWxsOiNGRkZGRkY7fTwvc3R5bGU+DQogPHRpdGxlPktpYmFuYS1GdWxsLUxvZ288L3RpdGxlPg0KIDxnPg0KICA8dGl0bGU+YmFja2dyb3VuZDwvdGl0bGU+DQogIDxyZWN0IHg9Ii0xIiB5PSItMSIgd2lkdGg9IjUyIiBoZWlnaHQ9IjUzIiBpZD0iY2FudmFzX2JhY2tncm91bmQiIGZpbGw9Im5vbmUiLz4NCiA8L2c+DQogPGc+DQogIDx0aXRsZT5MYXllciAxPC90aXRsZT4NCiAgPGVsbGlwc2UgZmlsbD0iI2ViMjAyNiIgc3Ryb2tlPSJudWxsIiBzdHJva2Utd2lkdGg9Im51bGwiIHN0cm9rZS1vcGFjaXR5PSJudWxsIiBjeD0iMjUuMTY2NjY2IiBjeT0iMjUuMjMzMzMzIiBpZD0ic3ZnXzEiIHJ4PSIxNyIgcnk9IjE3LjUiLz4NCiAgPGxpbmUgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmZmZmIiBzdHJva2Utd2lkdGg9IjciIHgxPSIxOS4wNDI5NjYiIHkxPSIzLjMzMzc5MyIgeDI9IjEzLjc5MzA2NiIgeTI9IjQ2LjMzMjkyMyIgaWQ9InN2Z182IiBzdHJva2UtbGluZWpvaW49Im51bGwiIHN0cm9rZS1saW5lY2FwPSJudWxsIi8+DQogIDxsaW5lIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIzIiB4MT0iMzYuMjkyNjE2IiB5MT0iMi4wODM4MTMiIHgyPSIzMS4wNDI3MTYiIHkyPSI0NS4wODI5NDMiIGlkPSJzdmdfNyIgc3Ryb2tlLWxpbmVqb2luPSJudWxsIiBzdHJva2UtbGluZWNhcD0ibnVsbCIvPg0KICA8bGluZSBmaWxsPSJub25lIiBzdHJva2Utd2lkdGg9IjUiIHN0cm9rZS1vcGFjaXR5PSJudWxsIiBmaWxsLW9wYWNpdHk9Im51bGwiIHgxPSIxNi4yOTMwMTYiIHkxPSIyMy4zMzMzODMiIHgyPSIzMi41NDI2ODYiIHkyPSIzMS4wODMyMzMiIGlkPSJzdmdfOCIgc3Ryb2tlLWxpbmVqb2luPSJudWxsIiBzdHJva2UtbGluZWNhcD0ibnVsbCIgc3Ryb2tlPSIjZmZmZmZmIi8+DQogPC9nPg0KPC9zdmc+");/g' /usr/share/kibana/src/ui/ui_render/views/ui_app.jade /usr/share/kibana/src/ui/ui_render/views/chrome.jade

# custom style
RUN sed -i 's/title Kibana/title HOMER Kibana/g' /usr/share/kibana/src/ui/ui_render/views/chrome.jade
RUN sed -i "s/bundleFile('commons.style.css')/bundleFile('commons.style.css'),bundleFile('gradiant_style.style.css')/g" /usr/share/kibana/src/ui/ui_render/views/ui_app.jade
RUN bin/kibana-plugin install https://transfer.sh/DOWws/gradiant-style.zip
