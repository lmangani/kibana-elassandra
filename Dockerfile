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
RUN sed -i 's/image\/svg+xml.*");/image\/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUwLjAwMDAxIiBoZWlnaHQ9IjUxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPg0KIDxtZXRhZGF0YSBpZD0ibWV0YWRhdGEzOCI+aW1hZ2Uvc3ZnK3htbEtpYmFuYS1GdWxsLUxvZ288L21ldGFkYXRhPg0KDQogPHN0eWxlIHR5cGU9InRleHQvY3NzIj4uc3Qwe2ZpbGw6I0ZGRkZGRjtmaWxsLW9wYWNpdHk6MC45MjUzO30NCgkuc3Qxe29wYWNpdHk6MC43O2ZpbGw6I0ZGRkZGRjt9DQoJLnN0MntvcGFjaXR5OjAuNTtmaWxsOiNGRkZGRkY7fQ0KCS5zdDN7ZmlsbDojRkZGRkZGO308L3N0eWxlPg0KIDx0aXRsZT5LaWJhbmEtRnVsbC1Mb2dvPC90aXRsZT4NCiA8Zz4NCiAgPHRpdGxlPmJhY2tncm91bmQ8L3RpdGxlPg0KICA8cmVjdCBmaWxsPSJub25lIiBpZD0iY2FudmFzX2JhY2tncm91bmQiIGhlaWdodD0iNTMiIHdpZHRoPSIxNTIuMDAwMDEiIHk9Ii0xIiB4PSItMSIvPg0KIDwvZz4NCiA8Zz4NCiAgPHRpdGxlPkxheWVyIDE8L3RpdGxlPg0KICA8ZWxsaXBzZSByeT0iMTcuNSIgcng9IjE3IiBpZD0ic3ZnXzEiIGN5PSIyOC40IiBjeD0iMjMuNSIgc3Ryb2tlLW9wYWNpdHk9Im51bGwiIHN0cm9rZS13aWR0aD0ibnVsbCIgc3Ryb2tlPSJudWxsIiBmaWxsPSIjZWIyMDI2Ii8+DQogIDx0ZXh0IHRyYW5zZm9ybT0ibWF0cml4KDIuMjc5OTk5OTcxMzg5NzcwNSwwLDAsMS42Mzc1NDc4NTA2MDg4MjU3LC0xMC4xMTk5OTk3NzM4MDAzNzMsLTI5LjY1NTkzNjczODQ3NjE1NykgIiBmb250LXN0eWxlPSJub3JtYWwiIGZvbnQtd2VpZ2h0PSI2MDAiIGZvbnQtc2l6ZT0iTmFOIiBmb250LWZhbWlseT0iRXVwaG9yaWEsIHNhbnMtc2VyaWYiIGZpbGw9IiNGRkZGRkYiIHN0cm9rZS13aWR0aD0iMXB4IiB4bWw6c3BhY2U9InByZXNlcnZlIiB4PSIxMC4xMTIwMyIgeT0iNDAuNTE3OSIgaWQ9InRleHQ0MTU2Ij5IPC90ZXh0Pg0KICA8dGV4dCBmaWxsPSIjMDAwMDAwIiBzdHJva2U9Im51bGwiIHN0cm9rZS13aWR0aD0iMXB4IiBzdHJva2Utb3BhY2l0eT0ibnVsbCIgZmlsbC1vcGFjaXR5PSJudWxsIiB4PSI0OS41IiB5PSIzMy45IiBpZD0ic3ZnXzIiIGZvbnQtc2l6ZT0iMjBweCIgZm9udC1mYW1pbHk9IkV1cGhvcmlhLCBzYW5zLXNlcmlmIiB0ZXh0LWFuY2hvcj0ic3RhcnQiIHhtbDpzcGFjZT0icHJlc2VydmUiPmVsYXN0aWM8L3RleHQ+DQogPC9nPg0KPC9zdmc");/g' /usr/share/kibana/src/ui/ui_render/views/ui_app.jade /usr/share/kibana/src/ui/ui_render/views/chrome.jade

# custom style
RUN sed -i 's/title Kibana/title HOMER Kibana/g' /usr/share/kibana/src/ui/ui_render/views/chrome.jade
RUN sed -i "s/bundleFile('commons.style.css')/bundleFile('commons.style.css'),bundleFile('gradiant_style.style.css')/g" /usr/share/kibana/src/ui/ui_render/views/ui_app.jade
RUN bin/kibana-plugin install https://github.com/qxip/Kibana-style-plugin/archive/v6.2.4.zip
